/*
 * 功能：工具类
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-12 14:10
 * 修改日期：2019-11-12 14:10
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtRoot {

  /*=======================================
   * 作者：WangZezhi  (2019-11-26  09:35)
   * 功能：时间相关
   * 描述：
   *=======================================*/
  static DateTime getDateTimeByStr(String strDate) {
    return DateTime.parse(strDate);
  }

  static String getZHWeekDay(DateTime dateTime, [bool simple=false]) {
    if (dateTime == null) return "";
    String weekday="";
    switch (dateTime.weekday) {
      case 1:
        weekday = simple ? "周一" : "星期一";
        break;
      case 2:
        weekday = simple ? "周二" : "星期二";
        break;
      case 3:
        weekday = simple ? "周三" : "星期三";
        break;
      case 4:
        weekday = simple ? "周四" : "星期四";
        break;
      case 5:
        weekday = simple ? "周五" : "星期五";
        break;
      case 6:
        weekday = simple ? "周六" : "星期六";
        break;
      case 7:
        weekday = simple ? "周日" : "星期日";
        break;
      default:
        break;
    }
    return weekday;
  }

  static int getMonthEndDay(DateTime dateTime){
    if(dateTime==null) return 0;
    int stampMonthEndDay = DateTime(dateTime.year, dateTime.month+1, 1).millisecondsSinceEpoch - (24 * 60 * 60 * 1000);
    return DateTime.fromMillisecondsSinceEpoch(stampMonthEndDay).day;
  }

  // yyyy-MM-dd
  static String getCurDateStr() {
    var date = DateTime.now();
    return "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
  }

  /*=======================================
   * 作者：WangZezhi  (2019-11-26  09:35)
   * 功能：UI相关
   * 描述：
   *=======================================*/
  static void toastShort(final String strMsg) {
    Fluttertoast.showToast(
        msg: strMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFFAAAAAA),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void toastLong(final String strMsg) {
    Fluttertoast.showToast(
        msg: strMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Color(0xFFAAAAAA),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // 通过传入一个默认颜色和生成颜色数量，会返回一个由传入颜色为基础，
  // 生成的指定数量的集合返回
  static List<Color> makeColorList(Color defColor, int count) {
    final colors = <Color>[];
    for (int i=0; i<count; i++) {
      final fraction = i / count;
      colors.add(Color.fromARGB(
          defColor.alpha + ((255 - defColor.alpha) * fraction).round(),
          defColor.red + ((255 - defColor.red) * fraction).round(),
          defColor.green + ((255 - defColor.green) * fraction).round(),
          defColor.blue + ((255 - defColor.blue) * fraction).round())
      );
    }
    return colors;
  }

  /*=======================================
   * 作者：WangZezhi  (2019-11-14  16:01)
   * 功能：偏好存储
   * 描述：
   *=======================================*/
//  static spSetString(String key, value) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString(key, value);
//  }
//
//  static spGetString(String key) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.getString(key);
//  }
//
//  static spRemove(String key) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.remove(key);
//  }

}
