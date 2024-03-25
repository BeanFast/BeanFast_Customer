import 'package:beanfast_customer/views/screens/login_screen.dart';
import 'package:beanfast_customer/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Container(
                    color: Colors.black,
                    width: 250,
                    height: 250,
                    child: Image.network(
                      'https://play-lh.googleusercontent.com/nGpFXOAY4jShndUA63DtfD5D-sDApplKpDCuLpmELuY4vr2KfREUOhKkLPuovu0U1jc',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Don't skip breakfast, we've got you covered.",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Container(
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // Background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(RegisterView());
                      },
                      child: const Text('Đăng ký', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // Background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(LoginView());
                      },
                      child: const Text('Đăng nhập', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }
}
