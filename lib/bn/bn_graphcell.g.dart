// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bn_graphcell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BnGraphCell _$BnGraphCellFromJson(Map<String, dynamic> json) {
  return BnGraphCell(
    json['routeName'] as String,
    json['totalPcs'] as int,
    (json['totalActual'] as num)?.toDouble(),
    json['transportState'] as int,
  );
}

Map<String, dynamic> _$BnGraphCellToJson(BnGraphCell instance) =>
    <String, dynamic>{
      'routeName': instance.line,
      'totalPcs': instance.pcs,
      'totalActual': instance.wei,
      'transportState': instance.state,
    };

BnFlutterGraphDetail _$BnFlutterGraphDetailFromJson(Map<String, dynamic> json) {
  return BnFlutterGraphDetail(
    json['initIndex'] as int,
    (json['lsBn'] as List)
        ?.map((e) =>
            e == null ? null : BnGraphCell.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BnFlutterGraphDetailToJson(
        BnFlutterGraphDetail instance) =>
    <String, dynamic>{
      'initIndex': instance.initIndex,
      'lsBn': instance.lsBn,
    };
