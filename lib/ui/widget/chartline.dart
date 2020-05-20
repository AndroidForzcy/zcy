/*
 * 功能：图表：折线图
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-13 15:30
 * 修改日期：2019-11-13 15:30
 */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:libflutter_graph/bn/bn_chartline.dart';
import 'package:libflutter_graph/util/ut_root.dart';

class ChartLine extends StatefulWidget {
  final String _strDate; // 平台传过来的年月日字符串
  final int _dateType; // 0日；1月；2年；
  final List<BnChartLine> _lsBnChartLine;


  ChartLine(this._strDate, this._dateType, this._lsBnChartLine);

  /// 演示用工厂方法
  factory ChartLine.withSample() {
    var lsBn = [
      BnChartLine(1, 20),
      BnChartLine(2, 16),
      BnChartLine(3, 30),
      BnChartLine(5, 31),
      BnChartLine(7, 38),
      BnChartLine(10, 27),
      BnChartLine(11, 21),
      BnChartLine(12, 35),
      BnChartLine(13, 19),
      BnChartLine(15, 12),
      BnChartLine(17, 20),
      BnChartLine(19, 23),
      BnChartLine(20, 32),
      BnChartLine(21, 27),
      BnChartLine(22, 11),
      BnChartLine(23, 15),
      BnChartLine(24, 18),
      BnChartLine(25, 16),
      BnChartLine(26, 30),
      BnChartLine(27, 33),
      BnChartLine(28, 36),
      BnChartLine(29, 37),
      BnChartLine(30, 37),
      BnChartLine(31, 39),
    ];
    return ChartLine("2019-11-26", 1, lsBn);
  }

  @override
  _ChartLineState createState() => _ChartLineState();
}

/*=======================================
 * 作者：WangZezhi  (2019-11-13  10:02)
 * 功能：
 * 描述：
 *=======================================*/
class _ChartLineState extends State<ChartLine> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LineChart(_getLineChartData()),
    );
  }

  LineChartData _getLineChartData() {
    final int _axisMaxX = _getMaxX(); // x轴最大值
    final mMaxMin = _getLsNumMaxMin();
    return LineChartData(
      // 此处用于构建触摸点弹窗的样式
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: _getLsLineTooltipItem(),
        ),
      ),
      // 图标网格控制
      gridData: FlGridData(
        show: true,
        // 当满足如下条件时，才按下方的get方法绘制，其他忽略
        checkToShowHorizontalGrid: (double value) {
          var intAve = (mMaxMin[0] - mMaxMin[1]) ~/ 4;
          var intVal = value.toInt();
          return intVal == intAve || intVal==2*intAve || intVal==3*intAve || intVal==4*intAve;
        },
        getDrawingHorizontalGridLine: (double value) {
          return const FlLine(
            color: Color(0xffD4D4D4),
            strokeWidth: 1,
          );
        },
      ),
      // 控制只显示表格底部坐标
      titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 12,
            textStyle: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 12,
            ),
            getTitles: (value) {
              // 0日；1月；2年；
              switch (widget._dateType) {
                case 2:
                  {
                    switch (value.toInt()) {
                      case 1:
                        return '1月';
                      case 3:
                        return '3月';
                      case 6:
                        return '6月';
                      case 9:
                        return '9月';
                      case 12:
                        return '12月';
                    }
                    break;
                  }
                case 1:
                  {
                    var curValue = value.toInt();
                    if(curValue > 25){
                      if((curValue !=_axisMaxX)){
                        break;
                      }
                      switch (_axisMaxX) {
                        case 27:
                          return '27日';
                        case 28:
                          return '28日';
                        case 30:
                          return '30日';
                        case 31:
                          return '31日';
                      }
                    }else {
                      switch (curValue) {
                        case 1:
                          return '1日';
                        case 5:
                          return '5日';
                        case 10:
                          return '10日';
                        case 15:
                          return '15日';
                        case 20:
                          return '20日';
                        case 25:
                          return '25日';
                      }
                    }
                    break;
                  }
                case 0:
                  {
                    switch (value.toInt()) {
                      case 1:
                        return '1点';
                      case 4:
                        return '4点';
                      case 8:
                        return '8点';
                      case 12:
                        return '12点';
                      case 16:
                        return '16点';
                      case 20:
                        return '20点';
                      case 24:
                        return '24点';
                    }
                    break;
                  }
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          )),
      // 轴线绘制
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xffD4D4D4),
              width: 1,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 1,
      maxX: _axisMaxX.toDouble(),
      minY: mMaxMin[1],
      maxY: mMaxMin[0],
      lineBarsData: _getLineData(),
    );
  }

  // 0日；1月；2年；
  int _getMaxX() {
    switch(widget._dateType){
      case 0: return 24;
      case 1: {
        var date = UtRoot.getDateTimeByStr(widget._strDate);
        return date==null ? 0 : UtRoot.getMonthEndDay(date);
      }
      case 2: return 12;
    }
    return 0;
  }

  // 查找数据集中的最大和最小值
  List<double> _getLsNumMaxMin() {
    var min = widget._lsBnChartLine.isEmpty ? 0 : widget._lsBnChartLine[0].pcs;
    var max = 0;
    for (var bn in widget._lsBnChartLine) {
      if (bn.pcs > max) {
        max = bn.pcs;
      }
      if (min > bn.pcs) {
        min = bn.pcs;
      }
    }
    return [double.parse("$max"), double.parse("$min")];
  }

  // 编辑点击点弹窗提示内容
  GetLineTooltipItems _getLsLineTooltipItem() {
    List<LineTooltipItem> defaultLineTooltipItem(
        List<LineBarSpot> touchedSpots) {
      if (touchedSpots == null) {
        return null;
      }
      return touchedSpots.map((LineBarSpot touchedSpot) {
        if (touchedSpot == null) {
          return null;
        }
        final TextStyle textStyle = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
        // 0日；1月；2年；
        var datetime = UtRoot.getDateTimeByStr(widget._strDate);
        switch (widget._dateType) {
          case 2:
            return LineTooltipItem(
                "${datetime.year}年${touchedSpot.x.toInt()}月\n${touchedSpot.y.toInt()}件",
                textStyle);
          case 1:
            return LineTooltipItem(
                "${datetime.month}月${touchedSpot.x.toInt()}日 ${UtRoot.getZHWeekDay(datetime, true)}\n${touchedSpot.y.toInt()}件",
                textStyle);
          case 0:
            return LineTooltipItem(
                "${datetime.month}月${datetime.day}日 ${touchedSpot.x.toInt()}点\n${touchedSpot.y.toInt()}件",
                textStyle);
        }
        return LineTooltipItem("${touchedSpot.y}", textStyle);
      }).toList();
    }
    return defaultLineTooltipItem;
  }

  // 获取绘制点(spot)
  List<FlSpot> _lsBnToFlSpot() {
    List<FlSpot> lsFlSpot = [];
    for (var bn in widget._lsBnChartLine) {
      lsFlSpot
          .add(FlSpot(double.parse("${bn.axis}"), double.parse("${bn.pcs}")));
    }
    if(lsFlSpot.isEmpty){
      lsFlSpot
          .add(FlSpot(double.parse("0"), double.parse("0")));
    }
    return lsFlSpot;
  }

  // 获取折线数据
  List<LineChartBarData> _getLineData() {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: _lsBnToFlSpot(),
      isCurved: false, // 不弯曲
      colors: [
//        Color(0xff27b6fc),
          Theme.of(context).primaryColor
      ],
      barWidth: 2,
      isStrokeCapRound: false, // 不在终端绘制圆帽子
    );
    return [lineChartBarData];
  }

}
