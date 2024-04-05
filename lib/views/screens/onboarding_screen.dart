import 'package:beanfast_customer/views/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
      // pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,

      pages: [
        PageViewModel(
          title: "Quality Food",
          body:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
              "industry's standard dummy text ever since the 1500s, "
              "when an unknown printer took a galley of type and scrambled it ",
          image: _buildImage('quality.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fast Delevery",
          body:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
              "industry's standard dummy text ever since the 1500s, "
              "when an unknown printer took a galley of type and scrambled it ",
          image: _buildImage('delevery.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Reward surprises",
          body:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
              "industry's standard dummy text ever since the 1500s, "
              "when an unknown printer took a galley of type and scrambled it ",
          image: _buildImage('reward.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bean Fast",
          body:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
              "industry's standard dummy text ever since the 1500s, ",
          image: _buildImage('reward.svg'),
          footer: GestureDetector(
            onTap: () {
              _onIntroEnd(context);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.fromBorderSide(
                    BorderSide(color: Colors.black, width: 1)),
              ),
              child:
                  const Text('Shop Now', style: TextStyle(color: Colors.black)),
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 50,
          ),
        ),
      ],

      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),

      skipOrBackFlex: 0,
      nextFlex: 0,

      showBackButton: false,
      showNextButton: true,
      showSkipButton: true,
      showDoneButton: true,

      //rtl: true, // Display as right-to-left

      // back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),

      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(10)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8, 8),
        color: Color(0xFFBDBDBD),
        activeSize: Size(28, 8),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
