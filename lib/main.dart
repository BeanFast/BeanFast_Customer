import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/src/messages/vi_messages.dart';

import 'binding.dart';
import 'contrains/theme.dart';
import 'views/screens/splash_screen.dart';

Future<void> main() async {
  await GetStorage.init(); // init local storage
  // Get.put(HomeController());
  timeago.setLocaleMessages('vi', ViMessages());
  timeago.setDefaultLocale('vi');
  try {
    runApp(const MyApp());
  } catch (e) {
    Get.snackbar('try', e.toString());
  }
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
          page: () => const SplashScreen(),
          binding: AuthBindingController(),
          // transition: Transition.fade,
        )
      ],
    );
  }
}
