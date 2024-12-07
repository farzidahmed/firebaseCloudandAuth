import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmNotificationManager{
  static Future<void> initialize() async{
    await FirebaseMessaging.instance.requestPermission();

    //background
    FirebaseMessaging.onMessageOpenedApp.listen(_onmessaing);
    //foregraound
    FirebaseMessaging.onMessage.listen(_onmessaing);

    // termineted

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMeasseing);
  }
static void _onmessaing(RemoteMessage message){
    print(message.data);
    print(message.notification?.title);
    print(message.notification?.body);
}
}
Future<void> _onBackgroundMeasseing(RemoteMessage message)async{
  print("Got a new meassing");
}