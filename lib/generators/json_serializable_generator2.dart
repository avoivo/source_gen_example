library generators.json_serializable_generator2;

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/generators/json_serializable.dart';
import 'package:source_gen/generators/json_serializable_generator.dart';

class DataModelKey {
  const DataModelKey();
}

class JsonSerializableGenerator2 extends JsonSerializableGenerator {
  const JsonSerializableGenerator2();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, JsonSerializable annotation, _) async {
    var generated =
        await super.generateForAnnotatedElement(element, annotation, _);

    if (annotation.createToJson) {
      var classElement = element as ClassElement;
      // var className = classElement.name;

      var fields = classElement.fields
          .where((_) => _?.metadata
              ?.any((_) => _.constantValue?.type?.name == 'DataModelKey'))
          .fold(<String, FieldElement>{},
              (Map<String, FieldElement> map, field) {
        map[field.name] = field;
        return map;
      });

      if (fields.length > 1) {
        throw "Cannot use more than one DataModelKeys in a DataModel.";
      }

      if (fields.length != 0) {
        var toArray = generated.split("\n")..removeLast();
        var keyField = fields.values.first;
        toArray.add(
            "  String getKey() =>  ${_fieldToJsonMapValue(keyField.name, keyField.type)};");

        toArray.add(
            "  void setKey(String key) =>${keyField.name} = ${_writeAccessToVar('key', keyField.type)};");

        toArray.add("}");

        generated = toArray.join("\n");
      }
    }

    return generated;
  }
}

String _fieldToJsonMapValue(String name, DartType fieldType, [int depth = 0]) {
  if (_implementsDartList(fieldType)) {
    var indexVal = "i${depth}";

    var substitute = '${name}[$indexVal]';
    var subFieldValue = _fieldToJsonMapValue(
        substitute, _getIterableGenericType(fieldType), depth + 1);
    if (subFieldValue != substitute) {
      // TODO: the type could be imported from a library with a prefix!
      return "${name} == null ? null : "
          "new List.generate(${name}.length, (int $indexVal) => $subFieldValue)";
    }
  }

  if (_isDartDateTime(fieldType)) {
    return "$name?.toIso8601String()";
  }

  return name;
}

String _writeAccessToVar(String varExpression, DartType searchType,
    {int depth: 0}) {
  if (_isDartDateTime(searchType)) {
    // TODO: this does not take into account that dart:core could be
    // imported with another name
    return "$varExpression == null ? null : DateTime.parse($varExpression)";
  }

  if (_isDartIterable(searchType) || _isDartList(searchType)) {
    var iterableGenericType = _getIterableGenericType(searchType);

    var itemVal = "v$depth";

    var output = "($varExpression as List)?.map(($itemVal) => "
        "${_writeAccessToVar(itemVal, iterableGenericType, depth: depth+1)}"
        ")";

    if (_isDartList(searchType)) {
      output += "?.toList()";
    }

    return output;
  }

  if (!searchType.isDynamic) {
    return "$varExpression as $searchType";
  }

  return varExpression;
}

bool _implementsDartList(DartType type) => _typeTest(type, _isDartList) != null;

bool _isDartIterable(DartType type) =>
    type.element.library != null &&
    type.element.library.isDartCore &&
    type.name == 'Iterable';

bool _isDartList(DartType type) =>
    type.element.library != null &&
    type.element.library.isDartCore &&
    type.name == 'List';

bool _isDartDateTime(DartType type) =>
    type.element.library != null &&
    type.element.library.isDartCore &&
    type.name == 'DateTime';

DartType _getIterableGenericType(InterfaceType type) {
  var iterableThing = _typeTest(type, _isDartIterable);

  return iterableThing.typeArguments.single;
}

ParameterizedType _typeTest(
    DartType type, bool tester(ParameterizedType type)) {
  if (tester(type)) return type;

  if (type is InterfaceType) {
    var tests = type.interfaces.map((type) => _typeTest(type, tester));
    var match = _firstNonNull(tests);

    if (match != null) return match;

    if (type.superclass != null) {
      return _typeTest(type.superclass, tester);
    }
  }
  return null;
}

/*=T*/ _firstNonNull/*<T>*/(Iterable/*<T>*/ values) =>
    values.firstWhere((value) => value != null, orElse: () => null);
