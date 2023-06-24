import 'package:get/get.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/pages/message/state.dart';

class MessageController extends GetxController{

  MessageController();
  final title="Vetcure .";
  final state=MessageState();


  Future<void> goProfile() async {
    await Get.toNamed(AppRoutes.Profile);
  }

  }
