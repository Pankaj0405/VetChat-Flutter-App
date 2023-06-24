import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/frame/welcome/controller.dart';
import 'package:vetcurekartchat/pages/profile/controller.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProfileController>(() =>ProfileController() );

  }

}