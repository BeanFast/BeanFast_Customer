import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch sử đơn hàng',
          style: TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              color: Colors.grey[300],
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: orderController.dropdownValue.value,
                          iconSize: 24,
                          elevation: 16,
                          icon: const Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Color(0xFF26AA91), fontSize: 14),
                          onChanged: (String? newValue) {
                            orderController.updateStatus(newValue!);
                          },
                          items: <String>[
                            'Hoàn thành 1',
                            'Hoàn thành 2',
                            'Hoàn thành 3',
                            'Hoàn thành 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  TextButton(
                    onPressed: () async {
                      final DateTimeRange? pickedDateRange =
                          await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime.now(),
                        initialDateRange:
                            orderController.selectedDateRange.value,
                      );

                      if (pickedDateRange != null &&
                          pickedDateRange !=
                              orderController.selectedDateRange.value) {
                        orderController.selectedDateRange.value =
                            pickedDateRange;
                      }
                    },
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            ' ${DateFormat('dd/MM/yyyy').format(orderController.selectedDateRange.value.start)}'
                            ' - ${DateFormat('dd/MM/yyyy').format(orderController.selectedDateRange.value.end)}',
                            style: const TextStyle(
                                color: Color(0xFF26AA91), fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                //Đơn hoàn thành
                GestureDetector(
                  onTap: () {
                    Get.snackbar("Order Id 1", "1",
                        snackPosition: SnackPosition.TOP);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.grey[300],
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        // height: 200,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('6/1/2024',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('Hoàn thành',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text('Tên profile A',
                                style: TextStyle(
                                  color: Color(0xFF26AA91),
                                  fontSize: 14,
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://via.placeholder.com/150',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    height: 80,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Nước ngọt',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Color(0xFF26AA91),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Color(0xFF26AA91),
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('150.000 đ',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('2 sản phẩm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Row(
                                  children: [
                                    Text('Thành tiền ',
                                        style: TextStyle(
                                          color: Color(0xFF26AA91),
                                          fontSize: 14,
                                        )),
                                    Text('300.000 đ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Điểm tích luỹ',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('100 điểm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //Đơn đợi giao
                GestureDetector(
                  onTap: () {
                    Get.snackbar("Order Id 2", "2",
                        snackPosition: SnackPosition.TOP);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.grey[300],
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        // height: 200,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('6/1/2024',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('Đợi giao',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text('Tên profile A',
                                style: TextStyle(
                                  color: Color(0xFF26AA91),
                                  fontSize: 14,
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://via.placeholder.com/150',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    height: 80,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Nước ngọt',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Color(0xFF26AA91),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Color(0xFF26AA91),
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('150.000 đ',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('2 sản phẩm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Row(
                                  children: [
                                    Text('Thành tiền ',
                                        style: TextStyle(
                                          color: Color(0xFF26AA91),
                                          fontSize: 14,
                                        )),
                                    Text('300.000 đ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Điểm tích luỹ',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('100 điểm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //Đơn huỷ
                GestureDetector(
                  onTap: () {
                    Get.snackbar("Order Id 3", "3",
                        snackPosition: SnackPosition.TOP);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.grey[300],
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        // height: 200,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('6/1/2024',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('Huỷ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text('Tên profile A',
                                style: TextStyle(
                                  color: Color(0xFF26AA91),
                                  fontSize: 14,
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://via.placeholder.com/150',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    height: 80,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Nước ngọt',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Color(0xFF26AA91),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Color(0xFF26AA91),
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('150.000 đ',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('2 sản phẩm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Row(
                                  children: [
                                    Text('Thành tiền ',
                                        style: TextStyle(
                                          color: Color(0xFF26AA91),
                                          fontSize: 14,
                                        )),
                                    Text('300.000 đ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Điểm tích luỹ',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                                Text('100 điểm',
                                    style: TextStyle(
                                      color: Color(0xFF26AA91),
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                  'Tiền sẽ được hoàn trong vòng 24h làm việc',
                                  style: TextStyle(
                                    color: Color(0xFF26AA91),
                                    fontSize: 14,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class OrderController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dropdownValue = 'Hoàn thành 1'.obs;

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 7)),
      end: DateTime.now(),
    ),
  );
  void updateStatus(String status) {
    dropdownValue.value = status;
  }
}
