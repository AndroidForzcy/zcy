/*
 * 功能：线路货量排行单元格bean类
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-13 17:31
 * 修改日期：2019-11-13 17:31
 */
import 'package:json_annotation/json_annotation.dart';

part 'bn_graphcell.g.dart';

@JsonSerializable()
class BnGraphCell {
  @JsonKey(name: "routeName")
  final String line; //线路名称

  @JsonKey(name: "totalPcs")
  final int pcs; //件数

  @JsonKey(name: "totalActual")
  final double wei; //重量

  @JsonKey(name: "transportState")
  final int state; //0已运；1未运

  BnGraphCell(this.line, this.pcs, this.wei, this.state);

  factory BnGraphCell.fromJson(Map<String, dynamic> json) => _$BnGraphCellFromJson(json);
  Map<String, dynamic> toJson() => _$BnGraphCellToJson(this);
}

List<BnGraphCell> getLsBnGraphCell(List<dynamic> list){
  List<BnGraphCell> result = [];
  list.forEach((item){
    result.add(BnGraphCell.fromJson(item));
  });
  return result;
}


// 增加指针传递
@JsonSerializable()
class BnFlutterGraphDetail {
  final int initIndex;
  final List<BnGraphCell> lsBn;

  BnFlutterGraphDetail(this.initIndex, this.lsBn);

  factory BnFlutterGraphDetail.fromJson(Map<String, dynamic> json) => _$BnFlutterGraphDetailFromJson(json);
  Map<String, dynamic> toJson() => _$BnFlutterGraphDetailToJson(this);

}