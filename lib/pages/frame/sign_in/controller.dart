import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vetcurekartchat/common/apis/apis.dart';
import 'package:vetcurekartchat/common/entities/entities.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/common/store/store.dart';
import 'package:vetcurekartchat/common/utils/http.dart';
import 'package:vetcurekartchat/common/widgets/toast.dart';

import 'package:vetcurekartchat/pages/frame/sign_in/state.dart';
import 'package:vetcurekartchat/pages/message/state.dart';

class SignInController extends GetxController{

  SignInController();
  final title="Vetcure .";
  final state=SignInState();
final GoogleSignIn _googleSignIn =GoogleSignIn(
scopes: [
  'openid'
]
);

Future<void> handleSignIn(String type) async {
//1:google ,2:facebook,3:apple,4:phone

try{
if(type=="phone number"){
  print("...you are logging in with phone number ...");

}
else if(type=="google"){
var user= await _googleSignIn.signIn();
if(user!=null){
  String? displayName=user.displayName;
  String email=user.email;
  String id=user.id;
  String photoUrl=user.photoUrl??"assets/icons/google.png";
  LoginRequestEntity loginPanelListRequestEntity= LoginRequestEntity();
  loginPanelListRequestEntity.avatar=photoUrl;
  loginPanelListRequestEntity.name=displayName;
  loginPanelListRequestEntity.email=email;
  loginPanelListRequestEntity.open_id=id;
  loginPanelListRequestEntity.type=2;
  print(jsonEncode(loginPanelListRequestEntity));
  asyncPostAllData(loginPanelListRequestEntity);


}
}
else{
  if (kDebugMode) {
    print("...login type not sure...");

  }}
}
catch(e){
  if(kDebugMode) {
    print('..error with login $e');
  }
}
}

asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
// First save in the database
// second save in the local storage
//   UserStore.to.setIsLogin=true;
// var response= await HttpUtil().get(
//     '/api/index'
// );
// print(response);
// UserStore.to.setIsLogin=true;
EasyLoading.show(
indicator: const CircularProgressIndicator(),
  maskType: EasyLoadingMaskType.clear,dismissOnTap: true
);


var result=await UserAPI.Login(params: loginRequestEntity);
if(result.code==0){
  await UserStore.to.saveProfile(result.data!);
  EasyLoading.dismiss();
}else{
  EasyLoading.dismiss();
  toastInfo(msg: "Internet error");
}
  Get.offAllNamed(AppRoutes.Message);
}

  }
