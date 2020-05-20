/*
 * 功能：胶囊切换按钮
 * 描述：
 * 作者：WangZezhi
 * 邮箱：wangzezhi528@163.com
 * 创建日期：2019-11-12 10:51
 * 修改日期：2019-11-12 10:51
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*=======================================
 * 作者：WangZezhi  (2019-11-13  14:41)
 * 功能：三联切换按钮：日-月-年
 * 描述：
 *=======================================*/
class ToggleDMY extends StatefulWidget {
  final void Function(int index) onChecked;
  // 只读变量
  static int get index => _index;
  // 内部数据
  static int _index=0;

  ToggleDMY({Key key, this.onChecked}) : super(key: key);

  @override
  _ToggleDMYState createState() => _ToggleDMYState();
}

class _ToggleDMYState extends State<ToggleDMY> {
  final List<bool> _lsBooState = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ToggleButtons(
        children: [
          Text("日", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("月", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("年", style: TextStyle(fontWeight: FontWeight.bold))
        ],
        isSelected: _lsBooState,
        onPressed: (int mIndex) {
          if(ToggleDMY._index == mIndex){
            return;
          }
          // 更新状态
          setState(() {
            ToggleDMY._index = mIndex;
            for(var i=0,j=_lsBooState.length; i<j; i++) {
              if(i==mIndex){
                _lsBooState[i] = true;
              }else {
                _lsBooState[i] = false;
              }
            }
            widget.onChecked(mIndex);
          });
        },
        borderRadius: BorderRadius.circular(15),
        borderColor: Theme.of(context).primaryColor,
        selectedBorderColor: Theme.of(context).primaryColor,
      ),
    );
  }

}


/*=======================================
 * 作者：WangZezhi  (2019-11-13  14:44)
 * 功能：二联切换按钮：已运/未运
 * 描述：形状似胶囊
 *=======================================*/
class ToggleTrans extends StatefulWidget {
  List<bool> lsBooState;
  final void Function(int index) onChecked;

  ToggleTrans({Key key, this.lsBooState, this.onChecked}) : super(key: key);

  @override
  _ToggleTransState createState() => _ToggleTransState();
}

class _ToggleTransState extends State<ToggleTrans> {
  List<bool> _lsBooState = [true, false];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      child: ToggleButtons(
        children: [
          Text("已运"),
          Text("未运")
        ],
        isSelected: widget.lsBooState?? _lsBooState,
        onPressed: (int mIndex) {
          widget.onChecked(mIndex);
          setState(() {
            _updateSelectedState(mIndex);
          });
        },
        borderRadius: BorderRadius.circular(11),
        borderColor: Theme.of(context).primaryColor,
        selectedBorderColor: Theme.of(context).primaryColor,
      ),
    );
  }
  
  void _updateSelectedState(int index) {
    if(widget.lsBooState==null) {
      setState(() {
        _lsBooState = (index==1) ? [false, true] : [true, false];
      });
    }else {
      setState(() {
        widget.lsBooState = (index==1) ? [false, true] : [true, false];
      });
    }
  }

}