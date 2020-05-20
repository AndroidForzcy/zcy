// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bn_chartpie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BnChartPie _$BnChartPieFromJson(Map<String, dynamic> json) {
  return BnChartPie(
    json['shipTotalPcs'] as int,
    json['notTotalPcs'] as int,
  );
}

Map<String, dynamic> _$BnChartPieToJson(BnChartPie instance) =>
    <String, dynamic>{
      'shipTotalPcs': instance.pcsOk,
      'notTotalPcs': instance.pcsNo,
    };
