// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bn_chartline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BnChartLine _$BnChartLineFromJson(Map<String, dynamic> json) {
  return BnChartLine(
    json['dateNum'] as int,
    json['dateTotalPcs'] as int,
  );
}

Map<String, dynamic> _$BnChartLineToJson(BnChartLine instance) =>
    <String, dynamic>{
      'dateNum': instance.axis,
      'dateTotalPcs': instance.pcs,
    };
