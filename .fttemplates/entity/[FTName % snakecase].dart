import 'package:json_annotation/json_annotation.dart';

part '<FTName | snakecase>.g.dart';

@JsonSerializable()
class <FTName | capitalize> {


  const <FTName | capitalize>();

  factory <FTName | capitalize>.fromJson(Map<String, dynamic>? json) =>
      _$<FTName | capitalize>FromJson(json ?? <String, dynamic>{});

  factory <FTName | capitalize>.empty() => <FTName | capitalize>.fromJson({});

  Map<String, dynamic> toJson() => _$<FTName | capitalize>ToJson(this);
}