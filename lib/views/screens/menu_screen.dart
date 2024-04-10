// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '/controllers/home_controller.dart';
// import '/contrains/theme_color.dart';
// import '/views/screens/product_detail_screen.dart';
// import '/views/widgets/menu_item_widget.dart';

// class MenuScreen extends GetView<HomeController> {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//     SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Loại sản phẩm",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             //Category List
//             const SizedBox(height: 15),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Obx(() => Row(
//                     children: controller.menuModel.value.listCategories.entries
//                         .map((e) {
//                       return Container(
//                         alignment: Alignment.center,
//                         height: 40,
//                         margin: const EdgeInsets.only(right: 15),
//                         child: TextButton(
//                           style: ButtonStyle(
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                               controller.selectedCategoryId.value == e.value
//                                   ? Colors.white
//                                   : HexColor("#26AA91"),
//                             ), // Text color
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                               controller.selectedCategoryId.value == e.value
//                                   ? HexColor("#26AA91")
//                                   : Colors.white,
//                             ), // Background color
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                               const EdgeInsets.all(10),
//                             ),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 side:
//                                     const BorderSide(color: Color(0xFF26AA91)),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             controller.selectedCategoryId.value = e.value;
//                             // Get.snackbar('Click category', index.toString());
//                           },
//                           child: Text(
//                             e.value,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   )),
//             ),
//             const SizedBox(height: 10),
//             Obx(
//               () => MenuItem(
//                   title: 'Combo',
//                   isCombo: true,
//                   onTap: () {
//                     Get.to(const ProductDetailScreen());
//                   },
//                   sessionId: controller.selectedSession.value.id!,
//                   list: controller.menuModel.value.listCombo),
//             ),
//             const SizedBox(height: 20),
//             Obx(
//               () => MenuItem(
//                   isCombo: false,
//                   title: 'Ưu đãi',
//                   onTap: () {
//                     Get.to(const ProductDetailScreen());
//                   },
//                   sessionId: controller.selectedSession.value.id!,
//                   list: controller.menuModel.value.listDiscountedFood),
//             ),
//             MenuItem(
//                 isCombo: false,
//                 title: 'Sản phẩm',
//                 onTap: () {
//                   Get.to(const ProductDetailScreen());
//                 },
//                 sessionId: controller.selectedSession.value.id!,
//                 list: controller.menuModel.value.listFood),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // class SessionScreen extends GetView<beanfast.MenuController> {
// //   const SessionScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     Get.put(beanfast.MenuController());

// //     return Scaffold(
// //       appBar: AppBar(
// //         actions: headerActionWidget(),
// //       ),
// //       body: LoadingScreen(
// //         future: () async {
// //           // controller.getData(schoolId);
// //         },
// //         child: Obx(() {
// //           return controller.isValidate.value
// //               ? const MenuScreen()
// //               : menuDetailScreen(context);
// //         }),
// //       ),
// //     );
// //   }

// //   Widget menuDetailScreen(BuildContext context) {
// //     WidgetsBinding.instance.addPostFrameCallback((_) async {
// //       final DateTime? picked = await showDatePicker(
// //         locale: const Locale("vi", "VI"),
// //         context: context,
// //         initialDate: DateTime.now(),
// //         firstDate: DateTime.now(),
// //         lastDate: DateTime.now().add(const Duration(days: 7)),
// //       );
// //       if (picked != null && picked != controller.selectedDate.value) {
// //         var profileController = Get.put(ProfileController());
// //         await profileController.getCurrentProfile(currentProfile.value.id!);
// //         await controller.getData(currentProfile.value.school!.id!, picked);
// //         final session = await secsionPicker(context);
// //         if (session != null) {
// //           controller.updateDate(picked);
// //         } else {
// //           Get.back();
// //         }
// //       } else {
// //         Get.back();
// //       }
// //     });
// //     return Container(
// //       color: ThemeColor.bgColor,
// //     );
// //   }

// //   Future<String?> secsionPicker(BuildContext context) async {
// //     final result = await showDialog<String>(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Row(
// //             children: [
// //               const Text('Thời gian nhận hàng', style: TextStyle(fontSize: 18),),
// //               const Spacer(),
// //               IconButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 icon: const Icon(Icons.close),
// //               ),
// //             ],
// //           ),
// //           content: SizedBox(
// //             height: Get.height * 0.3,
// //             width: Get.width,
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.vertical,
// //               child: Column(
// //                 children:
// //                     // controller.model.
// //                     List.generate(
// //                   controller.listSession.length,
// //                   (index) => ListTile(
// //                     title: Text(DateFormat('dd/MM/yyyy')
// //                         .format(controller.listSession[index].orderStartTime!)),
// //                     onTap: () {
// //                       Navigator.of(context).pop(controller
// //                           .listSession[index].orderStartTime
// //                           .toString());
// //                       controller.selectedSession.value =
// //                           controller.listSession[index];
// //                       controller.isValidate.value = true;
// //                       controller.getMenu();
// //                     },
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //     if (result != null) {
// //       return result;
// //     } else {
// //       Get.back();
// //       return null;
// //     }
// //   }
// // }
