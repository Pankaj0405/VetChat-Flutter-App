
import 'package:flutter/material.dart';
import 'package:vetcurekartchat/common/middlewares/middlewares.dart';

import 'package:get/get.dart';
import 'package:vetcurekartchat/pages/contact/index.dart';

import '../../pages/frame/sign_in/bindings.dart';
import '../../pages/frame/sign_in/view.dart';
import '../../pages/frame/welcome/index.dart';
import '../../pages/message/chat/index.dart';
import '../../pages/message/index.dart';
import '../../pages/message/voicecall/index.dart';
import '../../pages/profile/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const   WelcomePage(),
      binding: WelcomeBinding(),
    ),

    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
/*
    // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    // 最新路由
    GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
*/
    // contact page
    GetPage(name: AppRoutes.Contact, page: () => ContactPage(), binding: ContactBinding()),
   //消息
    GetPage(name: AppRoutes.Message, page: () => const MessagePage(), binding: MessageBinding(),middlewares: [
       RouteAuthMiddleware(priority: 1),
     ],),
    //Profile Section
    GetPage(name: AppRoutes.Profile, page: () => ProfilePage(), binding: ProfileBinding()),

    //聊天详情
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),
/*
    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    */
    GetPage(name: AppRoutes.VoiceCall, page: () => VoiceCallPage(), binding: VoiceCallBinding()),
  /*
  GetPage(name: AppRoutes.VideoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),*/
  ];






}
