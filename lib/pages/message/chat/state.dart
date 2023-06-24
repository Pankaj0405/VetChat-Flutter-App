import 'package:get/get.dart';
import 'package:vetcurekartchat/common/entities/entities.dart';
class ChatState{
RxList<Msgcontent> msgcontentList= <Msgcontent>[].obs;
var to_token="".obs;
var to_name="".obs;
var to_avatar="".obs;
var to_online="".obs;
RxBool more_status=false.obs;
}