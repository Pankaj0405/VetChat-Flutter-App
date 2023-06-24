import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/contact/index.dart';

class ContactBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ContactController>(() =>ContactController());

  }

}