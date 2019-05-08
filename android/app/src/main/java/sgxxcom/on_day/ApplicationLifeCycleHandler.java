package sgxxcom.on_day;

import android.app.Activity;
import android.app.Application;
import android.content.ComponentCallbacks2;
import android.content.res.Configuration;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.app.Application;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;


import android.util.Log;
import io.flutter.view.FlutterView;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class ApplicationLifeCycleHandler implements Application.ActivityLifecycleCallbacks, ComponentCallbacks2 {

    FlutterView flutterView1;

    ApplicationLifeCycleHandler(FlutterView flutterView)
    {
        this.flutterView1=flutterView;
        System.out.println("const");
        System.out.println(flutterView1);
    }

    private static final String TAG = ApplicationLifeCycleHandler.class.getSimpleName();
    private static boolean isInBackground = false;

    @Override
    public void onActivityCreated(Activity activity, Bundle bundle) {
    }

    @Override
    public void onActivityStarted(Activity activity) {
    }

    @Override
    public void onActivityResumed(Activity activity) {

        if(isInBackground){
            Log.d(TAG, "app went to foreground");
            isInBackground = false;
        }
    }

    @Override
    public void onActivityPaused(Activity activity) {
    }

    @Override
    public void onActivityStopped(Activity activity) {
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
    }

    @Override
    public void onConfigurationChanged(Configuration configuration) {
    }

    @Override
    public void onLowMemory() {
    }

    @Override
    public void onTrimMemory(int i) {
        if(i == ComponentCallbacks2.TRIM_MEMORY_UI_HIDDEN){
            Log.d(TAG, "app went to background");
            System.out.println("true background 1234567");
            System.out.println(flutterView1);

            MethodChannel channel = new MethodChannel(flutterView1, "music");
            channel.invokeMethod("message", "Hello from native host");

            isInBackground = true;
        }
    }
}
