import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:vetcurekartchat/common/apis/apis.dart';
import 'package:vetcurekartchat/common/entities/entities.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/common/store/store.dart';
import 'package:vetcurekartchat/common/values/values.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMassagingHandler {

  FirebaseMassagingHandler._();
  static AndroidNotificationChannel channel_call = const AndroidNotificationChannel(
    'com.dbestech.chatty.call', // id
    'chatty_call', // title
    importance: Importance.max,
    enableLights: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alert'),
  );
  static AndroidNotificationChannel channel_message = const AndroidNotificationChannel(
    'com.dbestech.chatty.message', // id
    'chatty_message', // title
    importance: Importance.defaultImportance,
    enableLights: true,
    playSound: true,
   // sound: RawResourceAndroidNotificationSound('alert'),
  );




  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> config() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      RemoteMessage newMessage = RemoteMessage();
      await messaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print("initialMessage------");
        print(initialMessage);
      }
      var initializationSettingsAndroid = AndroidInitializationSettings("ic_launcher");
      var darwinInitializationSettings =DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: darwinInitializationSettings);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse:(value){
        print("----------onDidReceiveNotificationResponse");
      });

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);


      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("\n notification on onMessage function \n");
        print(message);
        if(message!=null){
          _receiveNotification(message);
        }

      });
    } on Exception catch (e) {
      print("$e");
    }
  }

  static Future<void> _receiveNotification(RemoteMessage message) async {

      if(message.data!=null && message.data["call_type"]!=null) {
        //  ////1. voice 2. video 3. text, 4.cancel
        if (message.data["call_type"]=="voice") {
        //  FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          var data = message.data;
          var to_token = data["token"];
          var to_name = data["name"];
          var to_avatar = data["avatar"];
          var doc_id = data["doc_id"]??"";
          // var call_role= data["call_type"];
          if (to_token != null && to_name != null && to_avatar != null) {
            Get.snackbar(
                icon:Container(
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.all(0.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(to_avatar)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.w)),
                  ),
                ),
                "${to_name}",
                "Voice call",
                duration:Duration(seconds: 30),
                isDismissible:false,
                mainButton:TextButton(onPressed: (){}, child: Container(width:90.w, child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  GestureDetector(
                    onTap: (){
                      if(Get.isSnackbarOpen){
                        Get.closeAllSnackbars();
                      }
                      FirebaseMassagingHandler._sendNotifications("cancel",to_token,to_avatar,to_name,doc_id);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElementBg,
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.w)),
                      ),
                      child: Image.asset(
                          "assets/icons/a_phone.png"),
                    ),),
                  GestureDetector(
                      onTap: (){
                        if(Get.isSnackbarOpen){
                          Get.closeAllSnackbars();
                        }
                        Get.toNamed(AppRoutes.VoiceCall, parameters: {
                          "to_token": to_token,
                          "to_name": to_name,
                          "to_avatar": to_avatar,
                          "doc_id": doc_id,
                          "call_role": "audience"
                        });
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryElementStatus,
                          borderRadius: BorderRadius.all(
                              Radius.circular(30.w)),
                        ),
                        child: Image.asset(
                            "assets/icons/a_telephone.png"),
                      ))
                ],)))
            );

          }

        }else if(message.data["call_type"]=="video"){
      //    FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //  ////1. voice 2. video 3. text, 4.cancel
            var data = message.data;
            var to_token = data["token"];
            var to_name = data["name"];
            var to_avatar = data["avatar"];
            var doc_id = data["doc_id"]??"";
            // var call_role= data["call_type"];
            if (to_token != null && to_name != null && to_avatar != null) {
              ConfigStore.to.isCallVocie = true;
              Get.snackbar(
                  icon:Container(
                    width: 40.w,
                    height: 40.w,
                    padding: EdgeInsets.all(0.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(to_avatar)),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20.w)),
                    ),
                  ),
                  "${to_name}",
                  "Video call",
                  duration:Duration(seconds: 30),
                  isDismissible:false,
                  mainButton:TextButton(onPressed: (){}, child: Container(width:90.w, child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                    GestureDetector(
                      onTap: (){
                        if(Get.isSnackbarOpen){
                          Get.closeAllSnackbars();
                        }
                        FirebaseMassagingHandler._sendNotifications("cancel",to_token,to_avatar,to_name,doc_id);
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryElementBg,
                          borderRadius: BorderRadius.all(
                              Radius.circular(30.w)),
                        ),
                        child: Image.asset(
                            "assets/icons/a_phone.png"),
                      ),),
                    GestureDetector(
                        onTap: (){
                          if(Get.isSnackbarOpen){
                            Get.closeAllSnackbars();
                          }
                          Get.toNamed(AppRoutes.VideoCall, parameters: {
                            "to_token": to_token,
                            "to_name": to_name,
                            "to_avatar": to_avatar,
                            "doc_id": doc_id,
                            "call_role": "audience"
                          });
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryElementStatus,
                            borderRadius: BorderRadius.all(
                                Radius.circular(30.w)),
                          ),
                          child: Image.asset(
                              "assets/icons/a_telephone.png"),
                        ))
                  ],)))
              );
            }

        }else if(message.data["call_type"]=="cancel"){
              FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();

              if(Get.isSnackbarOpen){
                Get.closeAllSnackbars();
              }

              if(Get.currentRoute.contains(AppRoutes.VoiceCall) || Get.currentRoute.contains(AppRoutes.VideoCall)){
                Get.back();
              }

              var _prefs = await SharedPreferences.getInstance();
              await _prefs.setString("CallVocieOrVideo","");

        }



      }

  }

  static Future<void> _sendNotifications(String call_type,String to_token,String to_avatar,String to_name,String doc_id) async {

    CallRequestEntity callRequestEntity = new CallRequestEntity();
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = to_token;
    callRequestEntity.to_avatar = to_avatar;
    callRequestEntity.doc_id = doc_id;
    callRequestEntity.to_name = to_name;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    print("sendNotifications");
    print(res);
    if (res.code == 0) {
      print("sendNotifications success");
    } else {
      // Get.snackbar("Tips", "Notification error!");
      // Get.offAllNamed(AppRoutes.Message);
    }
  }


  static Future<void> _showNotification({RemoteMessage? message}) async {
    RemoteNotification? notification = message!.notification;
    AndroidNotification? androidNotification = message.notification!.android;
    AppleNotification? appleNotification = message.notification!.apple;

    if (notification != null &&
        (androidNotification != null || appleNotification != null)) {

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel_message.id,
            channel_message.name,
            icon: "@mipmap/ic_launcher",
            playSound: true,
            enableVibration: true,
            priority: Priority.defaultPriority,
           // channelShowBadge: true,
            importance: Importance.defaultImportance,
           // sound: RawResourceAndroidNotificationSound('alert'),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
   // PlascoRequests().initReport();
  }
/*
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackground(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    print("message data: ${message.data}");
    print("message data: ${message}");
    print("message data: ${message.notification}");

    if(message!=null){
      if(message.data!=null && message.data["call_type"]!=null) {

        if(message.data["call_type"]=="cancel"){
            FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //  await setCallVocieOrVideo(false);
            var _prefs = await SharedPreferences.getInstance();
            await _prefs.setString("CallVocieOrVideo", "");
        }
        if(message.data["call_type"]=="voice" || message.data["call_type"]=="video"){

          var data = {
            "to_token":message.data["token"],
            "to_name":message.data["name"],
            "to_avatar":message.data["avatar"],
            "doc_id":message.data["doc_id"]??"",
            "call_type":message.data["call_type"],
            "expire_time":DateTime.now().toString(),
          };
          print(data);
          var _prefs = await SharedPreferences.getInstance();
          await _prefs.setString("CallVocieOrVideo", jsonEncode(data));
        }


      }



    }

  }*/
}

