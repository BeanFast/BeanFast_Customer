import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';
import '/views/screens/otp_confirmation.dart';
import '/views/widgets/gradient_button.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: FadeInUp(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Số điện thoại',
                        style: Get.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_android_outlined),
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          String pattern = r'^(0[3|5|7|8|9])+([0-9]{8})\b$';

                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mật khẩu',
                        style: Get.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        child: TextFormField(
                          obscureText: controller.isPasswordVisible.value,
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            border: const UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (!RegExp(
                                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,20}$')
                                .hasMatch(value)) {
                              return 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ hoa, chữ thường và số';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Xác nhận mật khẩu',
                        style: Get.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        child: TextFormField(
                          obscureText: controller.isRePasswordVisible.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            border: const UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isRePasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: controller.toggleRePasswordVisibility,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (!RegExp(
                                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,20}$')
                                .hasMatch(value)) {
                              return 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ hoa, chữ thường và số';
                            }
                            if (value != controller.passwordController.text) {
                              return 'Mật khẩu không khớp';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: controller.isChecked.value,
                              onChanged: (value) {
                                controller.toggleIschecked();
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ruleDialog(context);
                          },
                          child: const Text('Chấp nhận với điều khoản'),
                        )
                      ],
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.errorMessage.value,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GradientButton(
                      text: 'Đăng ký',
                      onPressed: () async {
                        if (controller.isChecked.value == true) {
                          controller.errorMessage.value = '';
                          if (_formKey.currentState!.validate()) {
                            controller.errorMessage.value = '';
                            await controller.register();
                            Get.to(
                              () => const OtpConfirmationView(),
                              binding: BindingsBuilder(() {
                                Get.put(OTPController(
                                  phone: controller.phoneController.text,
                                ));
                              }),
                            );
                          }
                        } else {
                          controller.errorMessage.value =
                              'Vui lòng chấp nhận điều khoản';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<dynamic> ruleDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Điều khoản sử dụng'),
          content: SizedBox(
            height: Get.height / 2,
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Mục đích:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nỨng dụng này được tạo ra nhằm mục đích cung cấp dịch vụ đặt đồ ăn sáng tiện lợi cho phụ huynh học sinh. Ứng dụng giúp phụ huynh dễ dàng đặt mua đồ ăn sáng cho con em mình từ các nhà cung cấp uy tín, đảm bảo vệ sinh an toàn thực phẩm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐối tượng sử dụng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text: '\nTạo tài khoản và sử dụng ứng dụng miễn phí.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nTìm kiếm và lựa chọn nhà cung cấp, món ăn sáng phù hợp cho con em mình.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nĐặt mua đồ ăn sáng, thanh toán trực tuyến an toàn.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nTheo dõi đơn hàng và nhận thông báo trạng thái đơn hàng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐánh giá nhà cung cấp và chất lượng dịch vụ.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGửi phản hồi, góp ý cho nhà cung cấp và nhà phát triển ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nCung cấp thông tin chính xác, đầy đủ khi tạo tài khoản và sử dụng ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThanh toán đầy đủ cho các đơn hàng đã đặt mua.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nSử dụng ứng dụng đúng mục đích, tuân thủ các quy định của ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nGiữ gìn bí mật thông tin tài khoản cá nhân.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChịu trách nhiệm cho mọi hành vi sử dụng tài khoản của mình.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nQuyền và nghĩa vụ của nhà cung cấp:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nĐăng ký tài khoản và cung cấp thông tin về nhà cung cấp, thực đơn món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(text: '\nNhận đơn hàng từ phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChế biến và giao đồ ăn sáng đúng thời gian, đảm bảo vệ sinh an toàn thực phẩm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNhận thanh toán cho các đơn hàng đã bán.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐánh giá phản hồi của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGửi phản hồi, góp ý cho nhà phát triển ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nCung cấp thông tin chính xác, đầy đủ về nhà cung cấp, thực đơn món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nĐảm bảo chất lượng vệ sinh an toàn thực phẩm cho các món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiao đồ ăn sáng đúng thời gian, địa điểm theo yêu cầu của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChịu trách nhiệm cho chất lượng sản phẩm và dịch vụ cung cấp.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiải quyết khiếu nại của phụ huynh học sinh một cách thỏa đáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nQuyền và nghĩa vụ của nhà phát triển ứng dụng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text: '\nPhát triển, vận hành và bảo trì ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThu thập và sử dụng thông tin của người dùng nhằm mục đích cải thiện chất lượng dịch vụ.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChặn quyền truy cập đối với những tài khoản vi phạm quy định của ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThay đổi, bổ sung các điều khoản sử dụng ứng dụng mà không cần thông báo trước.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nBảo đảm tính an toàn, bảo mật thông tin cho người dùng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nCung cấp dịch vụ hỗ trợ khách hàng chuyên nghiệp, tận tâm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiải quyết khiếu nại của người dùng một cách thỏa đáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nChính sách hủy đơn hàng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nPhụ huynh học sinh có thể hủy đơn hàng miễn phí khi đơn hàng ở trạng thái chuẩn bị. Sau thời gian này, phụ huynh học sinh có thể bị tính phí hủy đơn hàng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nNhà cung cấp có thể hủy đơn hàng nếu không thể cung cấp sản phẩm hoặc dịch vụ theo yêu cầu của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nChính sách giải quyết tranh chấp:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nMọi tranh chấp liên quan đến việc sử dụng ứng dụng sẽ được giải quyết thông qua thương lượng giữa các bên.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nNếu không thể giải quyết tranh chấp qua thương lượng, các bên có thể đưa vụ việc ra tòa án có thẩm quyền để giải quyết.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nLưu ý:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nCác điều khoản sử dụng này có thể thay đổi bất cứ lúc nào mà không cần thông báo trước.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nViệc sử dụng ứng dụng đồng nghĩa với việc phụ huynh học sinh đã đồng ý với tất cả các điều khoản sử dụng được nêu trong tài liệu này.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nLiên hệ:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nNếu có bất kỳ thắc mắc nào về ứng dụng, vui lòng liên hệ với chúng tôi qua beanfast.mail@gmail.com',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nỨng dụng dành cho phụ huynh học sinh có con em theo học tại các trường học đã liên kết với ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nCảm ơn quý phụ huynh đã sử dụng ứng dụng của chúng tôi !',
                        style: Get.textTheme.titleSmall),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Chập thuận'),
              onPressed: () {
                controller.isChecked.value = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
