/*
 * 功能：饼图bean类
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-16 11:32
 * 修改日期：2019-11-16 11:32
 */
import 'package:json_annotation/json_annotation.dart';

part 'bn_chartpie.g.dart';

@JsonSerializable()
class BnChartPie {
  @JsonKey(name: "shipTotalPcs")
  final int pcsOk; //已运件数

  @JsonKey(name: "notTotalPcs")
  final int pcsNo; //未运件数

  BnChartPie(this.pcsOk, this.pcsNo);

  factory BnChartPie.fromJson(Map<String, dynamic> json) => _$BnChartPieFromJson(json);
  Map<String, dynamic> toJson() => _$BnChartPieToJson(this);
}