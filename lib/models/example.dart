part of models;

@JsonSerializable()
class Example extends DataModel
    with _$ExampleSerializerMixin
    implements CreationInfo, AlterationInfo {
  final String id;

  final String description;

  @DataModelKey()
  String da;

  List<String> redirectUris;

  CheckPointState state;

  @override
  String createdBy;

  @override
  DateTime createdOn;

  @override
  String modifiedBy;

  @override
  DateTime modifiedOn;

  Example(this.id, {this.description});

  factory Example.fromJson(json) => _$ExampleFromJson(json);
}
