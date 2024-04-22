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
                          if (_formKey.currentState!.validate()) {
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
            child: const SingleChildScrollView(
              child: Text('Mục đích:'
                  '\nỨng dụng này được tạo ra nhằm mục đích cung cấp dịch vụ đặt đồ ăn sáng tiện lợi cho phụ huynh học sinh. Ứng dụng giúp phụ huynh dễ dàng đặt mua đồ ăn sáng cho con em mình từ các nhà cung cấp uy tín, đảm bảo vệ sinh an toàn thực phẩm.'
                  '\nĐối tượng sử dụng:'
                  '\nỨng dụng dành cho phụ huynh học sinh có con em theo học tại các trường học đã liên kết với ứng dụng.'
                  '\nQuyền và nghĩa vụ của phụ huynh:'
                  '\nQuyền:'
                  '\nTạo tài khoản và sử dụng ứng dụng miễn phí.'
                  '\nTìm kiếm và lựa chọn nhà cung cấp, món ăn sáng phù hợp cho con em mình.'
                  '\nĐặt mua đồ ăn sáng, thanh toán trực tuyến an toàn.'
                  '\nTheo dõi đơn hàng và nhận thông báo trạng thái đơn hàng.'
                  '\nĐánh giá nhà cung cấp và chất lượng dịch vụ.'
                  '\nGửi phản hồi, góp ý cho nhà cung cấp và nhà phát triển ứng dụng.'
                  '\nNghĩa vụ:'
                  '\nCung cấp thông tin chính xác, đầy đủ khi tạo tài khoản và sử dụng ứng dụng.'
                  '\nThanh toán đầy đủ cho các đơn hàng đã đặt mua.'
                  '\nSử dụng ứng dụng đúng mục đích, tuân thủ các quy định của ứng dụng.'
                  '\nGiữ gìn bí mật thông tin tài khoản cá nhân.'
                  '\nChịu trách nhiệm cho mọi hành vi sử dụng tài khoản của mình.'
                  '\nQuyền và nghĩa vụ của nhà cung cấp:'
                  '\nQuyền:'
                  '\nĐăng ký tài khoản và cung cấp thông tin về nhà cung cấp, thực đơn món ăn sáng.'
                  '\nNhận đơn hàng từ phụ huynh học sinh.'
                  '\nChế biến và giao đồ ăn sáng đúng thời gian, đảm bảo vệ sinh an toàn thực phẩm.'
                  '\nNhận thanh toán cho các đơn hàng đã bán.'
                  '\nĐánh giá phản hồi của phụ huynh học sinh.'
                  '\nGửi phản hồi, góp ý cho nhà phát triển ứng dụng.'
                  '\nNghĩa vụ:'
                  '\nCung cấp thông tin chính xác, đầy đủ về nhà cung cấp, thực đơn món ăn sáng.'
                  '\nĐảm bảo chất lượng vệ sinh an toàn thực phẩm cho các món ăn sáng.'
                  '\nGiao đồ ăn sáng đúng thời gian, địa điểm theo yêu cầu của phụ huynh học sinh.'
                  '\nChịu trách nhiệm cho chất lượng sản phẩm và dịch vụ cung cấp.'
                  '\nGiải quyết khiếu nại của phụ huynh học sinh một cách thỏa đáng.'
                  '\nQuyền và nghĩa vụ của nhà phát triển ứng dụng:'
                  '\nQuyền:'
                  '\nPhát triển, vận hành và bảo trì ứng dụng.'
                  '\nThu thập và sử dụng thông tin của người dùng nhằm mục đích cải thiện chất lượng dịch vụ.'
                  '\nChặn quyền truy cập đối với những tài khoản vi phạm quy định của ứng dụng.'
                  '\nThay đổi, bổ sung các điều khoản sử dụng ứng dụng mà không cần thông báo trước.'
                  '\nNghĩa vụ:'
                  '\nBảo đảm tính an toàn, bảo mật thông tin cho người dùng.'
                  '\nCung cấp dịch vụ hỗ trợ khách hàng chuyên nghiệp, tận tâm.'
                  '\nGiải quyết khiếu nại của người dùng một cách thỏa đáng.'
                  '\nChính sách hủy đơn hàng:'
                  '\nPhụ huynh học sinh có thể hủy đơn hàng miễn phí trước [thời gian quy định]. Sau thời gian này, phụ huynh học sinh có thể bị tính phí hủy đơn hàng.'
                  '\nNhà cung cấp có thể hủy đơn hàng nếu không thể cung cấp sản phẩm hoặc dịch vụ theo yêu cầu của phụ huynh học sinh.'
                  '\nChính sách giải quyết tranh chấp:'
                  '\nMọi tranh chấp liên quan đến việc sử dụng ứng dụng sẽ được giải quyết thông qua thương lượng giữa các bên.'
                  '\nNếu không thể giải quyết tranh chấp qua thương lượng, các bên có thể đưa vụ việc ra tòa án có thẩm quyền để giải quyết.'
                  '\nLưu ý:'
                  '\nCác điều khoản sử dụng này có thể thay đổi bất cứ lúc nào mà không cần thông báo trước.'
                  '\nViệc sử dụng ứng dụng đồng nghĩa với việc phụ huynh học sinh đã đồng ý với tất cả các điều khoản sử dụng được nêu trong tài liệu này.'
                  '\nLiên hệ:'
                  '\nNếu có bất kỳ thắc mắc nào về ứng dụng, vui lòng liên hệ với chúng tôi qua [thông tin liên hệ].'
                  '\nCảm ơn quý phụ huynh đã sử dụng ứng dụng của chúng tôi!'),
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
