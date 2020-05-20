/*
 * 功能：图表：饼图
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-12 17:29
 * 修改日期：2019-11-12 17:29
 */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:libflutter_graph/util/ut_root.dart';

class ChartPie extends StatefulWidget {
  final List<int> lsNum; // 0位置：已运； 1位置：未运；

  ChartPie(this.lsNum);

  /// 演示用工厂方法
  factory ChartPie.withSample() {
    return ChartPie([300, 600]);
  }

  @override
  _ChartPieState createState() => _ChartPieState();
}

/*=======================================
 * 作者：WangZezhi  (2019-11-13  10:02)
 * 功能：
 * 描述：
 *=======================================*/
class _ChartPieState extends State<ChartPie> {
  final double _chartSize = 180; // 饼图的尺寸
  List<Color> _lsColor = [];
  int _touchedIndex; // 当前触摸的位置

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: _chartSize,
        height: _chartSize,
        child: PieChart(PieChartData(
            //去除中间的空心
            centerSpaceRadius: 0,
            // 去除中间空心与外部的间隔
            sectionsSpace: 0,
            // 绘制起点调整
            startDegreeOffset: -30,
            borderData: FlBorderData(
              show: false,
            ),
            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
              setState(() {
                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                    pieTouchResponse.touchInput is FlPanEnd) {
                  _touchedIndex = -1;
                } else {
                  _touchedIndex = pieTouchResponse.touchedSectionIndex;
                }
              });
            }),
            sections: _getData(widget.lsNum))),
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Container(
            child: Column(children: _getLsMarker()),
          )
        ],
      )
    ]);
  }

  List<PieChartSectionData> _getData(List<int> lsBn) {
    // 计算总数
    var mSum = 0;
    for (var num in lsBn) {
      mSum += num;
    }
    // 界面绘制配置
    List<PieChartSectionData> lsPie = List();
    var j = lsBn.length;
    var lsColor;
    if (j > 2) {
      lsColor = UtRoot.makeColorList(const Color(0xff845bef), j - 2);
    }
    _lsColor.clear();
    for (var i = 0; i < j; i++) {
      final booTouched = i == _touchedIndex;
      final double fontSize = booTouched ? 16 : 14;
      final double chartRadius = _chartSize / 2;
      final double radius = booTouched ? chartRadius : chartRadius - 10;
      //
      Color mColor;
      String mTitel;
      if (i == 0) {
        _lsColor.add(Theme.of(context).primaryColor);
        mColor = Theme.of(context).primaryColor;
        mTitel = '已运:${(lsBn[i] * 100 / (mSum ?? 1)).toStringAsFixed(0)}%';
      } else if (i == 1) {
        _lsColor.add(const Color(0xff13d38e));
        mColor = const Color(0xff13d38e);
        mTitel = '未运:${(lsBn[i] * 100 / (mSum ?? 1)).toStringAsFixed(0)}%';
      } else {
        _lsColor.add(lsColor[i - 2]);
        mColor = lsColor[i - 2];
        mTitel = '${lsBn[i] * 100 ~/ (mSum ?? 1)}%';
      }
      //
      var pieChartSectionData = PieChartSectionData(
          color: mColor,
          value: double.parse("${lsBn[i]}"),
          title: mTitel,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white));
      lsPie.add(pieChartSectionData);
    }
    return lsPie;
  }

  List<Widget> _getLsMarker() {
    List<Widget> lsMarker = [
      ColorMarker(
        markColor: _lsColor[0],
        text: "已运件数",
      ),
      Text(
        "${widget.lsNum[0]}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20,
      ),
      ColorMarker(
        markColor: _lsColor[1],
        text: "未运件数",
      ),
      Text("${widget.lsNum[1]}", style: TextStyle(fontWeight: FontWeight.bold)),
    ];
    for (var i = 0, j = _lsColor.length; i < j; i++) {
      if (i == 0 || i == 1) {
        continue;
      } else {
        lsMarker.add(ColorMarker(
          markColor: _lsColor[i],
          text: "",
        ));
      }
    }
    return lsMarker;
  }
}

/*=======================================
 * 作者：WangZezhi  (2019-11-13  11:03)
 * 功能：颜色标注器
 * 描述：
 *=======================================*/
class ColorMarker extends StatelessWidget {
  final double markSize;
  final Color markColor;
  final bool booRect;
  final String text;
  final double textSize;
  final Color textColor;

  const ColorMarker(
      {Key key,
      @required this.markColor,
      this.markSize = 14,
      this.booRect = true, // 默认正方形，否则圆形
      @required this.text,
      this.textColor = const Color(0xff505050),
      this.textSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: markSize,
          height: markSize,
          decoration: BoxDecoration(
            shape: booRect ? BoxShape.rectangle : BoxShape.circle,
            color: markColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.normal,
              color: textColor),
        )
      ],
    );
  }
}
