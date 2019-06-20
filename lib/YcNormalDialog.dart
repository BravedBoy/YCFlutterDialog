
import 'package:flutter/material.dart';



class YcNormalDialog extends StatefulWidget{

  YcNormalDialog({
    Key key,
    this.title,
    this.onPressed,
    this.height,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final double height;
  final bool hiddenTitle;

  @override
  _YcNormalDialog createState() => _YcNormalDialog();

}

class _YcNormalDialog extends State<YcNormalDialog>{

  @override
  Widget build(BuildContext context) {
    //创建透明层
    return Scaffold(
      //透明类型
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //设置半径
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            height: widget.height,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                //这个是内容区域
                Offstage(
                  offstage: widget.hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.hiddenTitle ? "" : widget.title,
                      style: TextStyle(
                          fontSize: font_sp18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(child: widget.child),
                vGap8,
                line,
                //取消和确定按钮
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: font_sp18
                            ),
                          ),
                          textColor: text_gray,
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 48.0,
                      width: 0.6,
                      color: Color(0xFFEEEEEE),
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "确定",
                            style: TextStyle(
                                fontSize: font_sp18
                            ),
                          ),
                          textColor: Color(0xff4688FA),
                          onPressed: (){
                            widget.onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  static Widget line = Container(height: 0.6, color: Color(0xFFEEEEEE));
  static const double font_sp18 = 18;
  static const Widget vGap8 = SizedBox(height: 8.0);
  static const Color text_gray = Color(0xFF999999);
}