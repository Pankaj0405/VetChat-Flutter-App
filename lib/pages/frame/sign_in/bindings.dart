import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/frame/sign_in/controller.dart';

import 'package:vetcurekartchat/pages/message/controller.dart';

class SignInBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInController>(() =>SignInController() );

  }

}