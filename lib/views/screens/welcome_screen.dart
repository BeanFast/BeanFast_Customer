import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/views/widgets/sbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '/contains/theme_color.dart';
import '/views/screens/login_screen.dart';
import '/views/screens/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final Duration duration = const Duration(milliseconds: 800);

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 2000),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 5,
                  right: 5,
                ),
                width: size.width,
                height: size.height / 2,
                child: Lottie.asset("assets/wl.json", animate: true),
              ),
            ),
      
            const SizedBox(
              height: 15,
            ),
      
            /// TITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1600),
              child: const Text(
                "Bean Fast",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
      
            ///
            const SizedBox(
              height: 10,
            ),
      
            /// SUBTITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1000),
              child: const Text(
                'Bữa sáng "siêu tốc", bé đi học "siêu nhanh"!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    color: Colors.black54,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),
      
            ///
            Expanded(child: Container()),
      
            /// GOOGLE BTN
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 600),
              child: SButton(
                borderColor: ThemeColor.textButtonColor,
                color: ThemeColor.itemColor,
                text: "Đăng nhập",
                textStyle: Get.textTheme.titleMedium!
                    .copyWith(color: ThemeColor.textButtonColor),
                onPressed: () {
                  Get.to(LoginView());
                },
              ),
            ),
      
            ///
            const SizedBox(
              height: 20,
            ),
      
            /// GITHUB BTN
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 200),
              child: SButton(
                borderColor: Colors.white,
                color: ThemeColor.textButtonColor,
                text: "Đăng ký",
                textStyle: Get.textTheme.titleMedium!
                    .copyWith(color: ThemeColor.itemColor),
                onPressed: () {
                  Get.to(RegisterView());
                },
              ),
            ),
      
            ///
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}


