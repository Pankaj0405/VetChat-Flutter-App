import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/frame/welcome/controller.dart';

class WelcomeBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WelcomeController>(() =>WelcomeController() );

  }

}