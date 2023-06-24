import 'package:get/get.dart';

import 'package:vetcurekartchat/pages/message/chat/index.dart';

class ChatBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatController>(() =>ChatController() );

  }

}