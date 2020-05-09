package com.yami.movie_flutter_app_v5;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends Activity {
//  @Override
//  protected void onCreate(Bundle savedInstanceState) {
//    super.onCreate(savedInstanceState);
//    GeneratedPluginRegistrant.registerWith(this);
//  }

    private Map<String, String> sharedData = new HashMap();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        // Handle intent when app is initially opened
        handleSendIntent(getIntent());

        new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.contentEquals("getSharedData")) {
                            result.success(sharedData);
                            sharedData.clear();
                        }
                    }
                }
        );
    }

    @Override
    protected void onNewIntent(Intent intent) {
        // Handle intent when app is resumed
        super.onNewIntent(intent);
        handleSendIntent(intent);
    }

    private void handleSendIntent(Intent intent) {
        String action = intent.getAction();
        String type = intent.getType();

        // We only care about sharing intent that contain plain text
        if (Intent.ACTION_SEND.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                sharedData.put("subject", intent.getStringExtra(Intent.EXTRA_SUBJECT));
                sharedData.put("text", intent.getStringExtra(Intent.EXTRA_TEXT));
            }
        }
    }
}
