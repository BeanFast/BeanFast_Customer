import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutDetailScreen extends StatelessWidget {
  const CheckOutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                      children: List.generate(
                          2,
                          (index) => Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Card(
                                      color: ThemeColor.bgColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            height: 50,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              color: ThemeColor.bgTitleColor,
                                              border: const Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              'Name',
                                              style: Get.textTheme.titleMedium,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 50,
                                                        width: 20,
                                                        child: Icon(Icons
                                                            .location_on_outlined)),
                                                    Expanded(
                                                      child: ListTile(
                                                        title: const Text(
                                                            'Địa chỉ nhận hàng'),
                                                        subtitle: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Trường Đại học Kinh tế TP.HCM'),
                                                            Text('Cổng số 1'),
                                                          ],
                                                        ),
                                                        trailing: IconButton(
                                                          iconSize: 24,
                                                          onPressed: () {
                                                            gateSelection(
                                                                context);
                                                          },
                                                          icon: const Icon(Icons
                                                              .arrow_forward_outlined),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        height: 60,
                                                        width: 20,
                                                        child: Icon(
                                                            Icons.schedule)),
                                                    Expanded(
                                                      child: ListTile(
                                                        title: Text(
                                                            'Thời gian nhận hành'),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                '10:00 - 12:00 20/10/2021'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: List.generate(
                                                    2,
                                                    (index) => Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              top: 10),
                                                      height: 90,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 90,
                                                            height: 90,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          12)),
                                                              child:
                                                                  Image.network(
                                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl4VZwkWyUGUoL_GW5_FOXgsrowU_Z0DVfQETNpqp2Rw&s',
                                                                fit: BoxFit
                                                                    .cover,
                                                                color:
                                                                    Colors.cyan,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      child:
                                                                          Text(
                                                                        'Tên sản phẩm',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                  const SizedBox(
                                                                    child: Text(
                                                                      'Phân loại: Bánh mì',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black54),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                  Row(
                                                                    children: [
                                                                      if (true)
                                                                        Text(
                                                                          Formater.formatMoney(
                                                                              200000.toString()),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                          ),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        Formater.formatMoney(
                                                                            200000.toString()),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.red),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                      const Spacer(),
                                                                      const Text(
                                                                        'x 2',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ))),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 30,
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.content_paste_go_outlined,
                                  color: Colors.amber,
                                ),
                              ),
                              Text('Chi tiết thanh toán',
                                  style: Get.textTheme.titleMedium),
                            ],
                          ),
                          const RowInforWidget(
                              title: 'Tổng đơn hàng: ', data: '46.000đ'),
                          const RowInforWidget(
                              title: 'Giảm giá sản phẩm: ', data: '-46.000đ'),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  child: Text(
                                'Tổng thanh toán',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '44.000đ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Màu của đổ bóng và độ mờ
                  spreadRadius: 5, // Độ lan rộng của đổ bóng
                  blurRadius: 7, // Độ mờ của đổ bóng
                  offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                ),
              ],
            ),
            height: 60,
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20 - 15 - 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Tổng thanh toán',
                          style: TextStyle(fontSize: 14)),
                      Text(Formater.formatMoney(20000000.toString()),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.to(const CheckOutDetailScreen());
                    },
                    child:
                        const Text('Đặt hàng', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> gateSelection(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            right: 10,
            left: 10,
          ),
          child: Column(
            children: [
              const Icon(Icons.more_horiz_outlined),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.network(
                            'https://image.nhandan.vn/w800/Uploaded/2024/huounvj/2023_03_23/ngodocbongbay-9529.jpg.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text('Cổng số 1'),
                        subtitle: const Text('Trường Đại học Kinh tế TP.HCM'),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RowInforWidget extends StatelessWidget {
  const RowInforWidget({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        )),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
