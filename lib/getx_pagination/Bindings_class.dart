
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../homepage/swipe_controller.dart';



class Splash_Bindnig implements Bindings {
  @override
  void dependencies() {
    // Get.put(SplashScreenController(), tag: SplashScreenController().toString());
  }
}
class Frontpage_Bindnig implements Bindings {
  @override
  void dependencies() {
    // Get.put(SplashScreenController(), tag: SplashScreenController().toString());
  }
}

class Ledger_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Ledger_Setup_controller(), tag: Ledger_Setup_controller().toString());
  }
}
