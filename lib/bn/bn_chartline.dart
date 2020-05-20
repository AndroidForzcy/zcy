/*
 * 功能：折线图bean类
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-13 17:31
 * 修改日期：2019-11-13 17:31
 */
import 'package:json_annotation/json_annotation.dart';

part 'bn_chartline.g.dart';

@JsonSerializable()
class BnChartLine {
  @JsonKey(name: "dateNum")
  final int axis; //日期坐标

  @JsonKey(name: "dateTotalPcs")
  final int pcs; //件数

  BnChartLine(this.axis, this.pcs);


  factory BnChartLine.fromJson(Map<String, dynamic> json) => _$BnChartLineFromJson(json);
  Map<String, dynamic> toJson() => _$BnChartLineToJson(this);
}

List<BnChartLine> getLsBnChartLine(List<dynamic> list){
  List<BnChartLine> result = [];
  list.forEach((item){
    result.add(BnChartLine.fromJson(item));
  });
  return result;
}