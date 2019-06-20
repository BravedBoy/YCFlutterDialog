
import 'package:flutter/material.dart';
import 'package:yc_dialog/YcNormalDialog.dart';

class DialogList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new StateDialog();
  }

}

class StateDialog extends State<DialogList>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("这个是弹窗页面"),
      ),

      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("普通的弹窗"),
            onTap: (){
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return YcNormalDialog(
                      hiddenTitle: true,
                      height: 120.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Text("请慎重地选择是否需要注销用户",
                            style: TextStyle(
                                fontSize: 16,
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      onPressed: (){

                      },
                    );
                  }
              );
            },
          ),
        ],
      ),
    );
  }
}
