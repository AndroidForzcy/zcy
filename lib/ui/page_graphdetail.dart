/*
 * 功能：线路货量排行单元格
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-14 11:50
 * 修改日期：2019-11-14 11:50
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libflutter_graph/bn/bn_graphcell.dart';

class PageGraphDetail extends StatefulWidget {
  List<BnGraphCell> _lsBnGraphCell;
  int _index;

  PageGraphDetail(BnFlutterGraphDetail bnFlutterGraphDetail) {
    _lsBnGraphCell = bnFlutterGraphDetail.lsBn ?? [];
    _index = bnFlutterGraphDetail.initIndex ?? 0;
  }

  factory PageGraphDetail.withSample() {
    List<BnGraphCell> lsTest = [];
    lsTest.add(BnGraphCell("惠州线", 6, 12.8, 1));
    lsTest.add(BnGraphCell("深圳线", 2, 8.1, 0));
    lsTest.add(BnGraphCell("惠州线", 2, 8.1, 0));
    lsTest.add(BnGraphCell("深圳线", 2, 8.1, 1));
    return PageGraphDetail(BnFlutterGraphDetail(1, lsTest));
  }

  @override
  _PageGraphDetailState createState() => _PageGraphDetailState();
}

class _PageGraphDetailState extends State<PageGraphDetail>
    with SingleTickerProviderStateMixin {
  static const _METHOD_CHANNEL_GRAPH = const MethodChannel("net.intelink.xinhua/graphdetail");
  TabController _tabController; //需要定义一个Controller
  final _lsTab = ["已运", "未运"];
  final List<BnGraphCell> _lsBnGraph0=[];
  final List<BnGraphCell> _lsBnGraph1=[];

  @override
  void initState() {
    super.initState();
    //
    _tabController = TabController(length: _lsTab.length, vsync: this);
    _tabController.index = widget._index;
    _tabController.addListener((){
      if(widget._index != _tabController.index){
        _toPlatformUpdateIndexState(_tabController.index);
        setState(() {
          widget._index = _tabController.index;
        });
      }
    });
    //
    _initDetailData();
  }

  void _initDetailData(){
    widget._lsBnGraphCell.forEach((bnTemp) {
      if(bnTemp.state == 0){
        _lsBnGraph0.add(bnTemp);
      }else {
        _lsBnGraph1.add(bnTemp);
      }
    });
    setState(() {
    });
  }

  void _toPlatformUpdateIndexState(int index) {
    _METHOD_CHANNEL_GRAPH
        .invokeMethod("fromFlutterUpdateIndexState", {"index": index});
  }

  @override
  Widget build(BuildContext context) {
    final _lsBnCellShow = widget._index==0 ? _lsBnGraph0 : _lsBnGraph1;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            TabBar(
                controller: _tabController,
                tabs: _lsTab.map((title) {
                  return Tab(text: title);
                }).toList(),
                labelColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Color(0xFF383838),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                indicatorColor: Theme.of(context).primaryColor,
//                indicatorPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30)
            ),
            Container(
              height: 10,
              color: Color(0xFFF8F8F8),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  itemCount: _lsBnCellShow.length,
                  itemBuilder: (context, i) {
                    return GraphCell(_lsBnCellShow[i]);
                  }),
            )
          ],
        ));
  }
}

/*=======================================
 * 作者：WangZezhi  (2019-11-18  09:03)
 * 功能：单元格
 * 描述：
 *=======================================*/
class GraphCell extends StatefulWidget {
  final BnGraphCell bnGraphCell;

  GraphCell(this.bnGraphCell);

  factory GraphCell.withSample() {
    return GraphCell(BnGraphCell("珠三角", 1688, 2768.12, 1));
  }

  @override
  _GraphCellState createState() => _GraphCellState();
}

class _GraphCellState extends State<GraphCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.timeline, color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.bnGraphCell.line),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text("${widget.bnGraphCell.pcs}"),
                  )),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("${widget.bnGraphCell.wei}kg"),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Color(0xFF888888),
        )
      ],
    );
  }
}
