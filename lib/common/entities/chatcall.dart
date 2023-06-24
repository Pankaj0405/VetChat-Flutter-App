import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCall {
  final String? doc_id;
  final String? from_token;
  final String? to_token;
  final String? from_name;
  final String? to_name;
  final String? from_avatar;
  final String? to_avatar;
  final String? call_time;
  final String? type;
  final Timestamp? last_time;

  ChatCall({
    this.doc_id,
    this.from_token,
    this.to_token,
    this.from_name,
    this.to_name,
    this.from_avatar,
    this.to_avatar,
    this.call_time,
    this.type,
    this.last_time,
  });

  factory ChatCall.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return ChatCall(
      from_token: data?['from_token'],
      to_token: data?['to_token'],
      from_name: data?['from_name'],
      to_name: data?['to_name'],
      from_avatar: data?['from_avatar'],
      to_avatar: data?['to_avatar'],
      last_time: data?['last_time'],
      type: data?['type'],
      call_time: data?['call_time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (from_token != null) "from_token": from_token,
      if (to_token != null) "to_token": to_token,
      if (from_name != null) "from_name": from_name,
      if (to_name != null) "to_name": to_name,
      if (from_avatar != null) "from_avatar": from_avatar,
      if (to_avatar != null) "to_avatar": to_avatar,
      if (call_time != null) "call_time": call_time,
      if (type != null) "type": type,
      if (last_time != null) "last_time": last_time,
    };
  }
}
