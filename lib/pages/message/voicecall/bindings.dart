import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/message/voicecall/index.dart';


class VoiceCallBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<VoiceCallController>(() =>VoiceCallController());

  }

}