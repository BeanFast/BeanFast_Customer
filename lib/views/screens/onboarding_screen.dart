import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/views/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

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

  Widget _buildLottie(String assetName, [double width = 350]) {
    return Lottie.asset('assets/images/$assetName.json',
        width: width, height: 300, fit: BoxFit.cover);
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
          title: "Chất lượng món ăn",
          bodyWidget: const Text(
            " Món ăn được chế biến từ nguyên liệu tươi ngon, đảm bảo vệ sinh an toàn thực phẩm và được trình bày đẹp mắt. Món ăn ngon sẽ kích thích vị giác của khách hàng và mang lại cho họ cảm giác thỏa mãn.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('quality.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Vận chuyển",
          bodyWidget: const Text(
            "Món ăn được vận chuyển đến tay khách hàng một cách nhanh chóng và an toàn để đảm bảo chất lượng món ăn được tốt nhất. Bao bì vận chuyển cần phù hợp với từng loại món ăn và phương tiện vận chuyển cần được đảm bảo vệ sinh sạch sẽ.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('delevery.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Trải nghiệm",
          bodyWidget: const Text(
            "Chính sách khuyến mãi hấp dẫn, chăm sóc khách hàng tận tình, nhân viên phục vụ nhiệt tình, thân thiện. Đặc biệt, nhân viên cần có thái độ niềm nở, lịch sự, tôn trọng khách hàng.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          image: _buildLottie('stored'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bean Fast",
          bodyWidget: const Text(
            'Bữa sáng "siêu tốc", bé đi học "siêu nhanh"!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('quality.svg'),
          footer: GestureDetector(
            onTap: () {
              _onIntroEnd(context);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: ThemeColor.itemColor,
                border: Border.fromBorderSide(
                    BorderSide(color: ThemeColor.textButtonColor, width: 1)),
              ),
              child: Text('Đặt hàng ngay!',
                  style: Get.textTheme.titleSmall!.copyWith(
                    color: ThemeColor.textButtonColor,
                  )),
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
