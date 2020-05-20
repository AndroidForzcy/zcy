/*
 * 功能：新华运输报表页面
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-11 10:37
 * 修改日期：2019-11-11 10:37
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libflutter_graph/bn/bn_chartline.dart';
import 'package:libflutter_graph/bn/bn_chartpie.dart';
import 'package:libflutter_graph/bn/bn_graphcell.dart';
import 'package:libflutter_graph/ui/page_graphdetail.dart';
import 'package:libflutter_graph/ui/widget/chartline.dart';
import 'package:libflutter_graph/ui/widget/chartpie.dart';
import 'package:libflutter_graph/ui/widget/toggle.dart';
import 'package:libflutter_graph/util/ut_root.dart';

class PageGraph extends StatefulWidget {
  @override
  _PageGraphState createState() => _PageGraphState();
}

class _PageGraphState extends State<PageGraph> {
  // 定义运输报表模块的方法通道
  static const _METHOD_CHANNEL_GRAPH = const MethodChannel("net.intelink.xinhua/graph");
  String _strCurDate = UtRoot.getCurDateStr(); // 平台传过来的年月日字符串
  var _bnChartPie = BnChartPie(0, 0); // 已运/未运 件数
  List<BnChartLine> _lsBnChartLine = [];
  BnFlutterGraphDetail _bnFlutterGraphDetail = BnFlutterGraphDetail(0, []);
  //
  var _indexDMY = 0; // 日月年切换
  List<bool> _lsBooState=[true, false];

  @override
  void initState() {
    super.initState();
    // 平台交互部分
    _METHOD_CHANNEL_GRAPH.setMethodCallHandler((call) {
      switch (call.method) {
        case "_fromPlatformUpdateDate":
          {
            var mapJson = json.decode(call.arguments);
            _fromPlatformUpdateDate(mapJson["date"]);
            return null;
          }
        case "_fromPlatformUpdatePie":
          {
            var mapJson = json.decode(call.arguments);
            _fromPlatformUpdatePie(BnChartPie.fromJson(mapJson));
            return null;
          }
        case "_fromPlatformUpdateLine":
          {
            var mapJson = json.decode(call.arguments);
            _fromPlatformUpdateLine(getLsBnChartLine(mapJson));
            return null;
          }
        case "_fromPlatformUpdateDetail":
          {
            var mapJson = json.decode(call.arguments);
            _fromPlatformUpdateDetail(BnFlutterGraphDetail.fromJson(mapJson));
            return null;
          }
      }
      return null;
    });
  }

  /*=======================================
   * 作者：WangZezhi  (2019-11-16  11:59)
   * 功能：flutter->platform
   * 描述：
   *=======================================*/
  // 切换当前指针-年月日
  void _toPlatformUpdateIndexDMY(int index) {
    _METHOD_CHANNEL_GRAPH
        .invokeMethod("fromFlutterUpdateIndexDMY", {"index": index});
  }

  // 切换当前指针-折线图
  void _toPlatformUpdateIndexLine(int index) {
    _METHOD_CHANNEL_GRAPH
        .invokeMethod("fromFlutterUpdateIndexLine", {"index": index});
  }

  // 切换当前指针-详情
  void _toPlatformUpdateIndexDetail(int index) {
    _METHOD_CHANNEL_GRAPH
        .invokeMethod("fromFlutterUpdateIndexDetail", {"index": index});
  }

  void _toPlatformGoPageToDetail() {
    _METHOD_CHANNEL_GRAPH
        .invokeMethod("fromFlutterGoPageToDetail");
  }

  /*=======================================
   * 作者：WangZezhi  (2019-11-16  11:59)
   * 功能：platform -> flutter
   * 描述：
   *=======================================*/
  void _fromPlatformUpdateDate(String strDate) {
    setState(() {
      _strCurDate = strDate;
    });
  }

  void _fromPlatformUpdatePie(BnChartPie bn) {
    setState(() {
      _bnChartPie = bn;
    });
  }

  void _fromPlatformUpdateLine(List<BnChartLine> lsBn) {
    setState(() {
      _lsBnChartLine = lsBn;
    });
  }

  void _fromPlatformUpdateDetail(BnFlutterGraphDetail bnFlutterGraphDetail) {
    setState(() {
      _bnFlutterGraphDetail = bnFlutterGraphDetail;
      _lsBooState = (bnFlutterGraphDetail.initIndex==1) ? [false, true] : [true, false];
    });
  }

  /*=======================================
   * 作者：WangZezhi  (2019-11-16  15:24)
   * 功能：UI部分
   * 描述：
   *=======================================*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: ToggleDMY(onChecked: (int index) {
                  // 日月年-切换按钮切换回调监听
                  _indexDMY = index;
                  _toPlatformUpdateIndexDMY(index);
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Text("总件数：${_bnChartPie.pcsOk + _bnChartPie.pcsNo}"),
              ChartPie([_bnChartPie.pcsOk, _bnChartPie.pcsNo]),
              Divider(
                height: 1,
                color: Color(0xFF888888),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ToggleTrans(onChecked: (int index) {
                  // 折线图-切换按钮切换回调监听
                  _toPlatformUpdateIndexLine(index);
                }),
              ),
              SizedBox(height: 10),
              //ChartLine.withSample(),
              ChartLine(_strCurDate, _indexDMY, _lsBnChartLine),
              SizedBox(height: 10),
              Divider(
                height: 1,
                color: Color(0xFF888888),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text("线路货量排行"),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ToggleTrans(lsBooState: _lsBooState, onChecked: (int index) {
                        // 详情-切换按钮切换回调监听
                        _toPlatformUpdateIndexDetail(index);
                      }),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // 动态显示隐藏控制部分
              Offstage(
                offstage: _bnFlutterGraphDetail.lsBn.length<1,
                child: (_bnFlutterGraphDetail.lsBn.length<1) ? null : GraphCell(_bnFlutterGraphDetail.lsBn[0]),
              ),
              Offstage(
                offstage: _bnFlutterGraphDetail.lsBn.length<2,
                child: (_bnFlutterGraphDetail.lsBn.length<2) ? null : GraphCell(_bnFlutterGraphDetail.lsBn[1]),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Text(
                    "查看全部 >>",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                onTap: () {
                  // 跳转到 线路货量排行详情
//                   Navigator.pushNamed(context, "/PageGraphDetail", arguments: BnFlutterGraphDetail(0, _lsBnGraphCell));
                  _toPlatformGoPageToDetail();
                },
              )
            ])));
  }
}
