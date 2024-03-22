import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GiftExchangeScreen extends StatelessWidget {
  const GiftExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi quà',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        actions: <Widget>[
          Container(
            width: 150,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.card_giftcard, color: Colors.black),
                Text('Điểm: 100.000'),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              3,
              (index) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                alignment: Alignment.center,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      'https://via.placeholder.com/50',
                                      width: 50,
                                      height: 50,
                                    ),
                                    const Text(
                                      'Đồ chơi',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100 -
                                          150,
                                      child: Text(
                                        'Đồ chơi trẻ em số $index',
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100 -
                                          150,
                                      child: Text(
                                        '150.000',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.red),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: TextButton(
                              style: ButtonStyle(
                                // foregroundColor:
                                //     MaterialStateProperty.all<Color>(
                                //         Colors.white), // Text color
                                // backgroundColor:
                                //     MaterialStateProperty.all<Color>(
                                //         Colors.green), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Đổi quà',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
