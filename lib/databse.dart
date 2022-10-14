import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Database {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<bool> createNotification({required String whenToNotify}) async {
    bool retVal = true;

    String? fcmToken = await _fcm.getToken();
    print(fcmToken);
    try {
      await _firestore.collection("notifications").doc(fcmToken).set({
        'token': fcmToken,
        'whenToNotify': whenToNotify,
        'notificationSent': false,
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}