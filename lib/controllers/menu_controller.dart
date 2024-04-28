// import 'package:get/get.dart';

// import '/models/session.dart';
// import '/models/menu.dart';
// import '/models/menu_detail.dart';
// import '/services/session_service.dart';

// class MenuModel {
//   List<MenuDetail> listDiscountedCombo = [];
//   List<MenuDetail> listDiscountedFood = [];
//   List<MenuDetail> listCombo = [];
//   List<MenuDetail> listFood = [];
//   final Map<String, String> listCategories = {};
// }

// class MenuController extends GetxController {
//   List<Session> listSession = [];
//   Rx<Menu> model = Menu().obs;
//   Rx<MenuModel> menuModel = MenuModel().obs;
//   Rx<Session> selectedSession = Session().obs;
//   Rx<DateTime> selectedDate = DateTime.now().obs;

//   RxSet<String> listCategoryId = <String>{}.obs;
//   var isValidate = false.obs;

//   // Future getData(String schoolId, DateTime dateTime) async {
//   //   try {
//   //   listSession =
//   //       await SessionService().getSessionsBySchoolId(schoolId, dateTime);

//   //   // model.value = listSession.last.menu!;
//   //   // updateFoodsAndCombos(model.value.menuDetails!);
//   //   } on DioException catch (e) {
//   //     throw Exception(e);
//   //   }
//   // }

//   void getMenu() {
//     model.value = listSession
//         .where((e) =>
//             e.deliveryStartTime!.isBefore(selectedDate.value) &&
//             e.deliveryEndTime!.isAfter(selectedDate.value))
//         .first
//         .menu!;
//     updateFoodsAndCombos(model.value.menuDetails!);
//   }

//   void updateFoodsAndCombos(List<MenuDetail> list) {
//     MenuModel model = MenuModel();
//     for (var e in list) {
//       model.listCategories
//           .putIfAbsent(e.food!.category!.name!, () => e.food!.category!.name!);
//       if (e.food!.price != e.price) {
//         e.food!.isCombo!
//             ? model.listDiscountedCombo.add(e)
//             : model.listDiscountedFood.add(e);
//       } else {
//         e.food!.isCombo! ? model.listCombo.add(e) : model.listFood.add(e);
//       }
//     }
//     menuModel.value = model;
//   }

//   void updateDate(DateTime newDate) {
//     selectedDate.value = newDate;
//   }

//   RxString selectedCategoryId = ''.obs;

//   static const int saleItem = 3;
//   RxInt selectedDiscountIndex = 0.obs;

//   var amountsSale1 =
//       List<int>.filled(saleItem, 0).obs; // replace 10 with the number of items

//   void increaseAmountSale1(int index) {
//     amountsSale1[index]++;
//   }

//   void decreaseAmountSale1(int index) {
//     if (amountsSale1[index] > 0) {
//       amountsSale1[index]--;
//     }
//   }

//   static const int category1Item = 4;
//   RxInt selectedCategory1Index = 0.obs;

//   var amountsCate1 = List<int>.filled(category1Item, 0)
//       .obs; // replace 10 with the number of items

//   void increaseAmountCate1(int index) {
//     amountsCate1[index]++;
//   }

//   void decreaseAmountCate1(int index) {
//     if (amountsCate1[index] > 0) {
//       amountsCate1[index]--;
//     }
//   }
// }
