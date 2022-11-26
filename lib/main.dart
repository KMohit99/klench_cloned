

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:klench_/splash_Screen.dart';
import 'package:wakelock/wakelock.dart';

import 'firebase_options.dart';
import 'getx_pagination/Bindings_class.dart';
import 'getx_pagination/binding_utils.dart';
import 'getx_pagination/page_route.dart';
import 'messaging_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

MessagingService _msgService = MessagingService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  // // TODO: Link app with Firebase (use FlutterFire CLI tools)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // await _msgService.init();

  runApp(MyApp());
}


/// Top level function to handle incoming messages when the app is in the background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(" --- background message received ---");
  print(message.notification!.title);
  print(message.notification!.body);
}


Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  //
  // //
  // // static Future<void> _throwGetMessage(RemoteMessage message) async {
  // //   print("PUSH RECEIVED");
  // //   await Firebase.initializeApp();
  // //   bFirebaseMessaging.showPushFromBackground(message);
  // // }
  //
  // var token;
  // @override
  // void initState() {
  //   // FirebaseMessaging.instance.getToken().then((token) {
  //   //   print('This is Token: ' '${token}');
  //   // });
  //   // setupToken();
  //   FlutterNativeSplash.remove();
  //   init();
  //
  //   super.initState();
  //
  //   // _fcm.configure(
  //   //   onMessage: (Map<String, dynamic> message) async {
  //   //     //this callback happens when you are in the app and notification is received
  //   //     print("onMessage: $message");
  //   //   },
  //   //   onLaunch: (Map<String, dynamic> message) async {
  //   //     //this callback happens when you launch app after a notification received
  //   //     print("onLaunch: $message");
  //   //   },
  //   //   onResume: (Map<String, dynamic> message) async {
  //   //     //this callbakc happens when you open the app after a notification received AND
  //   //     //app was running in the background
  //   //     print("onResume: $message");
  //   //   },
  //   // );
  //
  //
  //   // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
  //   // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   //   print('getInitialMessage data: ${message!.data}');
  //   // });
  //
  //   // FirebaseMessaging.onBackgroundMessage(_throwGetMessage);
  //
  //   // onMessage: When the app is open and it receives a push notification
  //
  //
  // }
  // String? _token;
  // init() async {
  //   if (Platform.isIOS)  {
  //     await _fcm.requestPermission(alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,);
  //     // FirebaseMessaging.onMessage.listen((event) {
  //     //   print("IOS Registered");
  //     // });
  //     // _fcm.onIosSettingsRegistered.listen((event) {
  //     //   print("IOS Registered");
  //     // });
  //   }
  // }
  //

  //
  // Future<void> setupToken() async {
  //   // Get the token each time the application loads
  //   String? token = await FirebaseMessaging.instance.getToken();
  //
  //   // Save the initial token to the database
  //   await saveTokenToDatabase(token!);
  //
  //   // Any time the token refreshes, store this in the database too.
  //   FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  // }


  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    initDynamicLinks();
    super.initState();
  }
  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }

    // FirebaseDynamicLinks.instance.onLink(
    //     onSuccess: (PendingDynamicLinkData dynamicLink) async {
    //       final Uri deepLink = dynamicLink?.link;
    //
    //       if (deepLink != null) {
    //         Navigator.pushNamed(context, deepLink.path);
    //       }
    //     },
    //     onError: (OnLinkErrorException e) async {
    //       print('onLinkError');
    //       print(e.message);
    //     });
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
  @override
  Widget build(BuildContext context) {
    Wakelock.enable(); // Here :)
    const style = SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
    return GetMaterialApp(
      // navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Klench_12',
      initialRoute: BindingUtils.initialRoute,
      initialBinding: Splash_Bindnig(),
      getPages: AppPages.getPageList,
      // home: (Token == '_' ||
      //         Token.toString() == 'null' ||
      //         Token.toString().isEmpty ||
      //         roles == '_' ||
      //         roles == 'null' ||
      //         roles.toString().isEmpty)
      //     ? loginScreen()
      //     : (roles == "company")
      //         ? addCompanyScreen()
      //         : (roles == "plan")
      //             ? subscription_Screen()
      //             : DashBoardScreen(),

      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
        dividerColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }


}

