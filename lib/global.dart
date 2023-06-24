import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vetcurekartchat/common/services/services.dart';
import 'package:vetcurekartchat/common/store/store.dart';
import 'package:vetcurekartchat/firebase_options.dart';

class Global{
  static Future init() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
    );
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
  }
}