import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vetcurekartchat/common/routes/names.dart';
import 'package:vetcurekartchat/common/store/store.dart';
import 'package:vetcurekartchat/pages/message/voicecall/index.dart';

import '../../../common/values/server.dart';


class VoiceCallController extends GetxController{

  VoiceCallController();

  final state=VoiceCallState();
  final player= AudioPlayer();
  String appID=APPID;
  final db =FirebaseFirestore.instance;
  final profile_token =UserStore.to.profile.token;
  late final RtcEngine engine;

ChannelProfileType channelProfileType=ChannelProfileType.channelProfileCommunication;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data= Get.parameters;
    state.to_name.value= data["to_name"]??"";
    state.to_avatar.value=data["to_avatar"]??"";
    print("...your name id ${state.to_name.value}");
    initEngine();

  }
  Future<void> initEngine()async {
    await player.setAsset("assets/Sound_Horizon.mp3");
    engine =createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appID,
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err,String msg){
        print('[.....onError err: $err, ,msg:$msg');
      },
      onJoinChannelSuccess: (RtcConnection connection,int elapsed){
        print('.....onConnection ${connection.toJson()}');
        state.isJoined.value=true;
      },
      onUserJoined: (RtcConnection connection,int remoteUid,int elapsed) async {
        await player.pause();
      },
      onLeaveChannel: (RtcConnection connection,RtcStats stats){
        print('....user left the room.....');
        state.isJoined.value=false;

      },
      onRtcStats: (RtcConnection connection, RtcStats stats){
        print("time..");
        print(stats.duration);

      }
    ));
    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(profile: AudioProfileType.audioProfileDefault,
    scenario: AudioScenarioType.audioScenarioGameStreaming
    );
    await joinChannel();


  }
  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    await engine.joinChannel(token: "007eJxTYNi8ev/Fk3I6Si4rX81/WbDuQCFX3/TIhfXHdR7lGZ+1W+2rwGCRZpaYbJiSamxhbGhiYWSemGySkphokGaUZpiaYmZi6Rw0JaUhkJFB41oeEyMDBIL4vAwpSSWpyRm6yRmJJSWVDAwABoQkJg==",
        channelId: "dbtech-chatty",
        uid: 0,
        options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
    EasyLoading.dismiss();

  }
  Future<void> leaveChannel() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,

    );
    await player.pause();
    state.isJoined.value=false;
    EasyLoading.dismiss();
    Get.back();
  }

  Future<void> _dispose() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    _dispose();
    super.onClose();
  }

@override
  void dispose() {
    // TODO: implement disposeId
  _dispose();
    super.dispose();
  }
}