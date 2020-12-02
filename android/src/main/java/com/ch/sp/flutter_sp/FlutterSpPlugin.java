package com.ch.sp.flutter_sp;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterSpPlugin implements MethodChannel.MethodCallHandler {

    private static final String CHANNEL = "io.flutter.plugins/flutter_sp";
    private SharedPreferences sp;
    private static final String UID_KEY = "uid";

    private FlutterSpPlugin(PluginRegistry.Registrar registrar) {
        sp = registrar.context().getSharedPreferences("hairbobocfg", Context.MODE_MULTI_PROCESS);
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new FlutterSpPlugin(registrar));
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String methodName = call.method;
        if (methodName.equals("get_uid")) {
            String uid = sp.getString(UID_KEY, "");
            result.success(uid);
        } else if (methodName.equals("set_uid")) {
            SharedPreferences.Editor editor = sp.edit();
            editor.putString(UID_KEY, "");
            editor.apply();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }
}
