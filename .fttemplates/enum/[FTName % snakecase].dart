import 'package:json_annotation/json_annotation.dart';
import 'package:metropolis_game/configs/consts.dart';

part '<FTName | snakecase>.g.dart';

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum <FTName | capitalize> {

  unknown
}

class <FTName | capitalize>Converter extends JsonConverter<<FTName | capitalize>, String?> {
  const <FTName | capitalize>Converter();

  @override
  <FTName | capitalize> fromJson(String? json) =>
      $enumDecodeNullable(_$<FTName | capitalize>EnumMap, json, unknownValue: <FTName | capitalize>.unknown) ?? <FTName | capitalize>.unknown;

  @override
  String toJson(<FTName | capitalize> instance) => _$<FTName | capitalize>EnumMap[instance] ?? kUnknownId;
}
