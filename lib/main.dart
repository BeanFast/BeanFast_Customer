import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart';
// import 'package:timeago/src/messages/vi_messages.dart';     
import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'binding.dart';
import 'contains/theme.dart';
import 'views/screens/network_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

Future<void> showFlutterNotificationForeground(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;

  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title!,
      notification.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

void showFlutterNotificationBackground(RemoteMessage message) {
  // print(message.data);
  print("message");
  RemoteNotification? notification = message.notification;

  AndroidNotification? android = message.notification?.android;
  print(notification!.body.toString());
  if (android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title!,
      notification.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

Future<void> main() async {
  await GetStorage.init(); // init local storage
  setLocaleMessages('vi', ViMessages());
  setDefaultLocale('vi');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var token = await FirebaseMessaging.instance.getToken();
  print("token: $token");
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onMessageOpenedApp
      .listen(showFlutterNotificationForeground);
  FirebaseMessaging.onMessage.listen(showFlutterNotificationBackground);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  // // FirebaseMessaging.instance.getToken().then((token) {
  // //   print("Token FCM: " + token.toString());
  // // });

  // WidgetsFlutterBinding.ensureInitialized();
  // FlutterError.onError = (details) {
  //   print("error");
  //   Get.snackbar("Some thing went wrong",
  //       details.exception.toString()); // the stack trace at the time
  // };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'BeanFast',
      theme: AppTheme.defaulTheme,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: '/',
          page: () => const NetworkScreen(),
          binding: MainBindingController(),
          // transition: Transition.fade,
        )
      ],
    );
  }
}
