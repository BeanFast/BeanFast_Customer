import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ResultScreenWidget extends StatelessWidget {
  final bool isSuccess;
  final String content;
  final String ontapNameLeftSide;
  final VoidCallback ontapLeftSide;
  final String ontapNameRightSide;
  final VoidCallback ontapRightSide;

  const ResultScreenWidget({
    super.key,
    required this.isSuccess,
    required this.content,
    required this.ontapLeftSide,
    required this.ontapRightSide,
    required this.ontapNameLeftSide,
    required this.ontapNameRightSide,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RichTextController());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: ThemeColor.primaryColor,
        // height: 170,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSuccess
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 2),
                      Text('Đặt hàng thành công',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.titleMedium!.copyWith()),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        textAlign: TextAlign.center,
                        'Đặt hàng thất bại',
                        style: Get.textTheme.titleMedium!.copyWith(),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              content,
              style: Get.textTheme.bodySmall!.copyWith(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2 - 30,
                  child: SButton(
                      color: ThemeColor.primaryColor,
                      borderColor: Colors.black,
                      text: ontapNameLeftSide,
                      textStyle: Get.textTheme.titleMedium!
                          .copyWith(color: Colors.black),
                      onPressed: ontapLeftSide),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: Get.width / 2 - 30,
                  child: SButton(
                      color: ThemeColor.primaryColor,
                      borderColor: Colors.black,
                      text: ontapNameRightSide,
                      textStyle: Get.textTheme.titleMedium!
                          .copyWith(color: Colors.black),
                      onPressed: ontapRightSide),
                ),
              ],
            ),
            //Rich text copy xong nhớ set height lai
            //Thanh công cụ
            // QuillToolbar.simple(
            //   configurations: QuillSimpleToolbarConfigurations(
            //     controller: controller.quillController,
            //     //hiện thị nhiều dòng ở thanh công cụ
            //     multiRowsDisplay: false,
            //     sharedConfigurations: const QuillSharedConfigurations(
            //       locale: Locale('vi', 'VN'),
            //     ),
            //   ),
            // ),
            //Ô input
            Container(
              padding: const EdgeInsets.all(10),
              height: 150,
              width: Get.width - 20,
              decoration: BoxDecoration(
                color: ThemeColor.itemColor,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                    controller: controller.quillController),
              ),
            ),
            ElevatedButton(
              onPressed: controller.printContent,
              child: const Text('Print Content'),
            ),
          ],
        ),
      ),
    );
  }
}

class RichTextController extends GetxController {
  late QuillController quillController;
  @override
  void onInit() {
    super.onInit();
    quillController = QuillController.basic();
  }

  //In nội dung
  void printContent() {
    print(quillController.document.toPlainText());
    Get.snackbar('', quillController.document.toPlainText());
  }
}
