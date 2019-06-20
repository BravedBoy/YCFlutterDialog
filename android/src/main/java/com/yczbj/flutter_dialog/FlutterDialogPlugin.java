package com.yczbj.flutter_dialog;

import android.content.Context;
import android.graphics.Color;
import android.support.v7.widget.CardView;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


public class FlutterDialogPlugin implements MethodCallHandler {

  private Context context;
  private Toast custonToast;
  private Toast systemToast;
  private final String yc_show_toast = "yc_show_toast";
  private final String yc_cancel_toast = "yc_cancel_toast";
  /**
   * ANDROID_CHANNEL 是我们 method channel 的名称，很重要，Dart 代码里还需要用到它。
   */
  private static final String ANDROID_CHANNEL = "yc/flutter_toast";

  private FlutterDialogPlugin(Context context) {
    this.context = context;
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), ANDROID_CHANNEL);
    Context context = registrar.context();
    channel.setMethodCallHandler(new FlutterDialogPlugin(context));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String method = call.method;
    Log.i("Android-onMethodCall--", method);
    switch (method){
      case yc_show_toast:
        Log.i("Android-onMethodCall--", "yc_show_toast");
        String title = call.argument("title");
        String desc = call.argument("desc");
        String typeToast = call.argument("typeToast");
        String length = call.argument("length");
        String gravity = call.argument("gravity");
        double radius = call.argument("radius");
        long bgColor = call.argument("bgColor");
        long textColor = call.argument("textColor");
        double fontSize = call.argument("fontSize");
        if (typeToast == "SYSTEM"){
          if (systemToast == null){
            systemToast = Toast.makeText(
                    context.getApplicationContext(),title,Toast.LENGTH_SHORT);
          }else {
            systemToast.setText(title);
          }
          systemToast.show();
        }else {
          if (custonToast == null){
            custonToast = new Toast(context.getApplicationContext());
          }

          if (gravity != null) {
            switch (gravity){
              case "top":
                custonToast.setGravity(Gravity.TOP,0,100);
                break;
              case "center":
                custonToast.setGravity(Gravity.CENTER,0,0);
                break;
              case "bottom":
              default:
                custonToast.setGravity(Gravity.BOTTOM,0,100);
                break;
            }
          }

          if ("long".equals(length)){
            custonToast.setDuration(Toast.LENGTH_LONG);
          }else {
            custonToast.setDuration(Toast.LENGTH_SHORT);
          }

          CardView rootView = (CardView) LayoutInflater.from(context).inflate(R.layout.view_toast_custom, null);
          TextView textView = rootView.findViewById(R.id.toastTextView);
          TextView descTv = rootView.findViewById(R.id.desc);
          rootView.setCardElevation(2.0f);
          if (fontSize!=0){
            textView.setTextSize((float) fontSize);
          }else {
            textView.setTextSize(14.0f);
          }

          if (bgColor!=0){
            rootView.setCardBackgroundColor((int) bgColor);
          }else {
            rootView.setCardBackgroundColor(context.getResources().getColor(R.color.color_bg));
          }

          if (textColor!=0){
            textView.setTextColor((int) textColor);
          }else {
            textView.setTextColor(Color.WHITE);
          }

          if (radius!=0){
            rootView.setRadius((float) radius);
          }else {
            rootView.setRadius(10.0f);
          }

          textView.setText(title);
          if (TextUtils.isEmpty(desc)){
            descTv.setVisibility(View.GONE);
          }else {
            descTv.setVisibility(View.VISIBLE);
            descTv.setText(desc);
          }

          custonToast.setView(rootView);
          custonToast.show();

          result.success(true);
        }
        break;
      case yc_cancel_toast:
        if (custonToast!=null){
          custonToast.cancel();
        }
        result.success(true);
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
