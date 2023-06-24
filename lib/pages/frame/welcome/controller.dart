import 'package:get/get.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/pages/frame/welcome/state.dart';

class WelcomeController extends GetxController{

  WelcomeController();
  final title="Vetcure .";
  final state=WelcomeState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),()=> Get.offAllNamed(AppRoutes.Message)
    );

  }
}