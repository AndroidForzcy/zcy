import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:libflutter_graph/ui/page_graph.dart';
import 'package:libflutter_graph/ui/page_graphdetail.dart';
import 'bn/bn_graphcell.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // platform 跳转方式
      home: _widgetForRoute(ui.window.defaultRouteName),
      // flutter 跳转方式
      routes: {
        "/PageGraph": (context) => PageGraph(),
        "/PageGraphDetail": (context) {
          return PageGraphDetail(ModalRoute.of(context).settings.arguments);
        },
      },
    );
  }
}

Widget _widgetForRoute(String strRouteUrl) {
  final pageName = _getPageName(strRouteUrl);
  final pageParam = _getPageParamJsonStr(strRouteUrl);
  switch (pageName) {
    case "/PageGraph":
      return PageGraph();
    case "/PageGraphDetail":
      {
        var mapJson = json.decode(pageParam);
        return PageGraphDetail(BnFlutterGraphDetail.fromJson(mapJson));
      }
  }
  return _TestHome();
}

String _getPageName(String s) {
  if (s.indexOf("?") == -1) {
    return s;
  } else {
    return s.substring(0, s.indexOf("?"));
  }
}

String _getPageParamJsonStr(String s) {
  if (s.indexOf("?") == -1) {
    return "{}";
  } else {
    return s.substring(s.indexOf("?") + 1);
  }
}

/*=======================================
 * 作者：WangZezhi  (2019-11-18  16:21)
 * 功能：测试页面
 * 描述：
 *=======================================*/
class _TestHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
                child: Text("运输报表"),
                onPressed: () {
                  Navigator.pushNamed(context, "/PageGraph");
                })
          ],
        ),
      ),
    );
  }
}
