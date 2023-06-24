import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/common/store/user.dart';
import 'package:vetcurekartchat/pages/frame/welcome/state.dart';
import 'package:vetcurekartchat/pages/profile/state.dart';

class ProfileController extends GetxController{

  ProfileController();
  final title="Vetcure .";
  final state=ProfileState();


Future<void> goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
}

}