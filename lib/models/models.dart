library models;

import 'package:source_gen/generators/json_serializable.dart';
import 'package:source_gen_example/generators/json_serializable_generator2.dart';

part 'models.g.dart';

part 'example.dart';
part 'extended_example.dart';

class DataModel {}

/// the model abstraction that contains creation info.
abstract class CreationInfo {
  /// The user who created the record.
  String createdBy;

  /// The date of creation.
  DateTime createdOn;
}

/// the model abstraction that contains alteration info.
abstract class AlterationInfo {
  /// The last user who modified the record.
  String modifiedBy;

  /// The last date of modification.
  DateTime modifiedOn;
}

enum CheckPointState { IN, OUT }
