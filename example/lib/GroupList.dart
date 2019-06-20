

import 'package:flutter/material.dart';
import 'package:yc_dialog/YcPopupWindow.dart';


class GroupList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new GroupState();
  }
}

class GroupState extends State<GroupList>{

  GlobalKey addKey = GlobalKey();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("popupWindow案例"),
        actions: <Widget>[
          IconButton(
            key: addKey,
            onPressed: (){
              showAddMenu();
            },
            icon: new Icon(Icons.add,),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    Widget body = new Center(
      child: new Text("popupWindow案例，点击右上角的按钮即可"),
    );
    return body;
  }


  void showAddMenu() {
    final RenderBox button = addKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset("lib/image/jt.png", width: 8.0, height: 4.0,),
            ),
            Container(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  onPressed: (){

                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  ),
                  icon: new Icon(Icons.add_box),
                  label: new Text("添加申请")
              ),
            ),
            Container(width: 120.0, height: 0.6),
            Container(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                  ),
                  icon: new Icon(Icons.report),
                  label: new Text("拒绝申请")
              ),
            ),
          ],
        ),
      ),
    );
  }

}





