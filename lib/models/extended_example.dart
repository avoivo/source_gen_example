part of models;

class RelationDataModel implements CreationInfo {
  String id;

  @override
  String createdBy;

  @override
  DateTime createdOn;
}

@JsonSerializable()
class ExtendedExample extends DataModel
    with _$ExtendedExampleSerializerMixin
    implements RelationDataModel {
  @override
  String createdBy;

  @override
  DateTime createdOn;

  @DataModelKey()
  @override
  String id;

  ExtendedExample();

  factory ExtendedExample.fromJson(json) => _$ExtendedExampleFromJson(json);
}
