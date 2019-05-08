package sgxxcom.on_day;

import android.app.Application;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
  Application application;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
      System.out.println("check");
    GeneratedPluginRegistrant.registerWith(this);
    ApplicationLifeCycleHandler handler = new ApplicationLifeCycleHandler(getFlutterView());
    application = (Application) MainActivity.this.getApplication();
    application.registerActivityLifecycleCallbacks(handler);
    registerComponentCallbacks(handler);
  }
}
