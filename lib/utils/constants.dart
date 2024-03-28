import 'package:get/get.dart';

import '/models/user.dart';
import '/models/profile.dart';

Rx<User> currentUser = User().obs;
Rx<Profile> currentProfile = Profile().obs;

dynamic dataSessionOfSchool = {
  "data": [
    {
      "id": "e41b7de0-5ec7-45b5-93af-5badde20387f",
      "code": "BUOISANG070224",
      "orderStartTime": "2024-03-04T06:00:00",
      "orderEndTime": "2024-04-04T18:00:00",
      "deliveryStartTime": "2024-03-25T05:30:00",
      "deliveryEndTime": "2024-04-07T06:30:00",
      "menu": {
        "id": "6215aa94-857f-44af-98ad-c0a43c92957e",
        "kitchenId": "43a53060-dfe0-4e5f-8b41-48b4fb8db5a2",
        "createrId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "updaterId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "code": "MENU0003",
        "createDate": "2024-02-04T00:00:00",
        "updateDate": "2024-02-04T00:00:00",
        "menuDetails": [
          {
            "price": 15000,
            "food": {
              "code": "NUOCDONGCHAI02",
              "name": "Sting Dâu",
              "price": 15000,
              "description": "Nước ngọt có gas",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fsting.jpeg?alt=media&token=0f308f6a-20cb-45fd-a367-4df31bf2c928",
              "category": {"name": "Nước đóng chai"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "BANHMI05",
              "name": "Bánh mì ốp la",
              "price": 15000,
              "description":
                  "Bánh mì + 2 trứng ốp la + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20%E1%BB%91p%20la.jfif?alt=media&token=e7b6bc4b-2fe6-4779-a062-a5ceefb8d33b",
              "category": {"name": "Bánh mì"}
            }
          },
          {
            "price": 20000,
            "food": {
              "code": "BANHMI01",
              "name": "Bánh mì heo quay",
              "price": 20000,
              "description":
                  "Bánh mì + Heo quay + Nước sốt đặc biệt Dưa leo + Dưa chua + Hành ngò + Ớt",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2FB%C3%A1nh%20m%C3%AC%20heo%20quay.jpg?alt=media&token=0bb5e9ff-9791-444e-abce-b56a0f1164ef",
              "category": {"name": "Bánh mì"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCDONGCHAI03",
              "name": "7UP",
              "price": 15000,
              "description": "Nước ngọt có gas",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2F7up.jpg?alt=media&token=9022ff90-3b9b-4b5f-92e4-23175948b065",
              "category": {"name": "Nước đóng chai"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCDONGCHAI05",
              "name": "Pepsi",
              "price": 15000,
              "description": "Nước ngọt có gas",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fpepsi.jpg?alt=media&token=d5f30d07-3edb-4bb9-9a7c-c71a686e72ee",
              "category": {"name": "Nước đóng chai"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "BANHMI03",
              "name": "Bánh mì nem nướng",
              "price": 15000,
              "description":
                  "Bánh mì + Nem nướng + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20nem%20n%C6%B0%E1%BB%9Bng.jpg?alt=media&token=85a4bae1-a057-426f-a0ab-c1ac009478cb",
              "category": {"name": "Bánh mì"}
            }
          },
          {
            "price": 20000,
            "food": {
              "code": "BANHMI02",
              "name": "Bánh mì cá hộp",
              "price": 20000,
              "description":
                  "Bánh mì + Cá mồi hộp + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20c%C3%A1%20h%E1%BB%99p.png?alt=media&token=51cf21e4-be8f-4e5c-8776-91728b7ec0a7",
              "category": {"name": "Bánh mì"}
            }
          },
          {
            "price": 7000,
            "food": {
              "code": "NUOCDONGCHAI01",
              "name": "Nước suối",
              "price": 7000,
              "description": "Nước suối Aquafina",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fn%C6%B0%E1%BB%9Bc%20su%E1%BB%91i.jpg?alt=media&token=5fc5db56-f6c2-410f-b795-e1891ef49ad7",
              "category": {"name": "Nước đóng chai"}
            }
          },
          {
            "price": 25000,
            "food": {
              "code": "BANHMI06",
              "name": "Bánh mì thập cẩm",
              "price": 25000,
              "description":
                  "Bánh mì + Heo quay + Xá xíu + Nem nướng + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20th%E1%BA%ADp%20c%E1%BA%A9m.jpg?alt=media&token=c004abe2-40a2-4c4e-a283-f4aab56e5fbb",
              "category": {"name": "Bánh mì"}
            }
          }
        ]
      },
      "sessionDetails": [
        {
          "id": "c5815e85-64c2-4fdb-9022-33febc51511f",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        },
        {
          "id": "f4b7d852-325a-47e8-83cc-564d40381f0d",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        },
        {
          "id": "d2dbd348-a4ac-46d3-8a06-8316fc33c0c0",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        },
        {
          "id": "9d2ef316-f4c6-490c-b762-e3bd16406793",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        }
      ]
    },
    {
      "id": "9fcf46b2-4d28-41bb-8576-699400135f86",
      "code": "BUOISANG050224",
      "orderStartTime": "2024-02-05T06:00:00",
      "orderEndTime": "2024-02-04T18:00:00",
      "deliveryStartTime": "2024-02-05T05:30:00",
      "deliveryEndTime": "2024-02-05T06:30:00",
      "menu": {
        "id": "3fd3a0bf-a83c-4304-b0b6-900e4f4a9184",
        "kitchenId": "43a53060-dfe0-4e5f-8b41-48b4fb8db5a2",
        "createrId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "updaterId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "code": "MENU0001",
        "createDate": "2024-02-04T00:00:00",
        "updateDate": "2024-02-04T00:00:00",
        "menuDetails": [
          {
            "price": 35000,
            "food": {
              "code": "BUN03",
              "name": "Bún thịt xào",
              "price": 35000,
              "description": "Bún + Thịt xào + Nước mắm",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%BAn%20th%E1%BB%8Bt%20x%C3%A0o.jpg?alt=media&token=4350cc06-b3d5-435c-b69f-6df1704f4ade",
              "category": {"name": "Bún"}
            }
          },
          {
            "price": 40000,
            "food": {
              "code": "COM08",
              "name": "Cơm tấm xíu mại",
              "price": 40000,
              "description": "Cơm tấm + Xíu mại",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fc%C6%A1m%20t%E1%BA%A5m%20x%C3%ADu%20m%E1%BA%A1i.jpg?alt=media&token=efd6534a-73ec-4b71-80d4-328118ce8c3d",
              "category": {"name": "Cơm"}
            }
          },
          {
            "price": 7000,
            "food": {
              "code": "NUOCDONGCHAI01",
              "name": "Nước suối",
              "price": 7000,
              "description": "Nước suối Aquafina",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fn%C6%B0%E1%BB%9Bc%20su%E1%BB%91i.jpg?alt=media&token=5fc5db56-f6c2-410f-b795-e1891ef49ad7",
              "category": {"name": "Nước đóng chai"}
            }
          },
          {
            "price": 35000,
            "food": {
              "code": "BUN01",
              "name": "Bún nem nướng",
              "price": 35000,
              "description": "Bún + 2 Nem nướng",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%BAn%20nem%20n%C6%B0%E1%BB%9Bng.jpeg?alt=media&token=82c35ea3-00be-4357-a29e-084b147968af",
              "category": {"name": "Bún"}
            }
          },
          {
            "price": 45000,
            "food": {
              "code": "BUN04",
              "name": "Bún thịt nướng đặc biệt",
              "price": 45000,
              "description":
                  "Bún + Thịt nướng + Bì + Nem nướng + Chả giò + Nước mắm",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%BAn%20%C4%91%E1%BA%B7c%20bi%E1%BB%87t.jpeg?alt=media&token=9f0612d4-b5f5-4600-b6a9-dcd91631d4e7",
              "category": {"name": "Bún"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCTRA03",
              "name": "Trà nho đen",
              "price": 15000,
              "description": "Trà giải khát",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Ftr%C3%A0%20nho%20%C4%91en.jpg?alt=media&token=8751f2e1-6a77-4ab2-918b-621b15578686",
              "category": {"name": "Nước Trà"}
            }
          },
          {
            "price": 40000,
            "food": {
              "code": "COM02",
              "name": "Cơm đùi gà mắm tỏi",
              "price": 40000,
              "description": "Cơm + Đùi gà + Sốt mắm tỏi",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fc%C6%A1m%20g%C3%A0%20m%E1%BA%AFm%20t%E1%BB%8Fi.jpg?alt=media&token=857c329f-03cb-4c61-893c-e2a615298d3d",
              "category": {"name": "Cơm"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCTRA077",
              "name": "Trà tắc",
              "price": 15000,
              "description": "Trà giải khát",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Ftr%C3%A0%20t%E1%BA%AFc.jpg?alt=media&token=7e0ef6ff-355a-43f9-8c10-085ee3c3d541",
              "category": {"name": "Nước Trà"}
            }
          }
        ]
      },
      "sessionDetails": [
        {
          "id": "18f7f0b8-e3b8-4818-aa1b-589904ab6772",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        },
        {
          "id": "cffcc04f-f012-4cf6-af78-c1504641a45f",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        }
      ]
    },
    {
      "id": "04d23d8b-02b0-4ce4-ba40-ea877215abc1",
      "code": "BUOISANG060224",
      "orderStartTime": "2024-02-06T06:00:00",
      "orderEndTime": "2024-02-04T18:00:00",
      "deliveryStartTime": "2024-02-06T05:30:00",
      "deliveryEndTime": "2024-02-06T06:30:00",
      "menu": {
        "id": "d2418593-91aa-4cb5-9a3e-3f39a290ee1d",
        "kitchenId": "43a53060-dfe0-4e5f-8b41-48b4fb8db5a2",
        "createrId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "updaterId": "f61f6e0b-2b1e-4d3d-8e8f-0a5b9c0d1e2f",
        "code": "MENU0002",
        "createDate": "2024-02-04T00:00:00",
        "updateDate": "2024-02-04T00:00:00",
        "menuDetails": [
          {
            "price": 40000,
            "food": {
              "code": "PHO03",
              "name": "Phở tái viên",
              "price": 40000,
              "description": "Phở + Thịt bò tái + Bò viên",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fph%E1%BB%9F%20t%C3%A1i%20vi%C3%AAn.jpeg?alt=media&token=bbedb6da-0b11-4134-a3e1-3a49a88a3e96",
              "category": {"name": "Bún/Phở/Mỳ"}
            }
          },
          {
            "price": 55000,
            "food": {
              "code": "COMBOANSANG02",
              "name": "Phở đặc biệt + Coca Cola",
              "price": 55000,
              "description": "Combo ăn sáng",
              "isCombo": true,
              "imagePath": "Chưa có ảnh",
              "category": {"name": "Combo"}
            }
          },
          {
            "price": 35000,
            "food": {
              "code": "HUTIEU01",
              "name": "Hủ tiếu bò kho",
              "price": 35000,
              "description": "Hủ tiếu + Nước bò kho",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fh%E1%BB%A7%20ti%E1%BA%BFu%20b%C3%B2%20kho.jpeg?alt=media&token=8ec2a2c9-826a-456e-9bdc-3cc49cbb2f8b",
              "category": {"name": "Bún/Phở/Mỳ"}
            }
          },
          {
            "price": 50000,
            "food": {
              "code": "PHO06",
              "name": "Phở đặc biệt",
              "price": 50000,
              "description":
                  "Phở + Thịt bò tái + Nạm + Gầu  + Gân + Vè + Bò viên",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fph%E1%BB%9F%20%C4%91%E1%BA%B7c%20bi%E1%BB%87t.jpeg?alt=media&token=9122d69e-f34a-4a7f-9ca5-8b0490682eb8",
              "category": {"name": "Bún/Phở/Mỳ"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCTRA06",
              "name": "Trà tắc xí muội",
              "price": 15000,
              "description": "Trà giải khát",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Ftr%C3%A0%20t%E1%BA%AFc%20x%C3%AD%20mu%E1%BB%99i.jpg?alt=media&token=f19f3854-39ec-4abf-b8e7-439d0cd64090",
              "category": {"name": "Nước Trà"}
            }
          },
          {
            "price": 40000,
            "food": {
              "code": "PHO02",
              "name": "Phở tái nạm",
              "price": 40000,
              "description": "Phở + Thịt bò tái + Thịt nạm",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fph%E1%BB%9F%20t%C3%A1i%20n%E1%BA%A1m.jpeg?alt=media&token=1d7d3594-84c9-454f-a6cf-476945a8c611",
              "category": {"name": "Bún/Phở/Mỳ"}
            }
          },
          {
            "price": 35000,
            "food": {
              "code": "MIBOKHO",
              "name": "Mì bò kho",
              "price": 35000,
              "description": "Mì gói + Nước bò kho",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fm%C3%AC%20b%C3%B2%20kho.jpeg?alt=media&token=f4a80dac-80ef-4692-85f6-bc178dd6ce20",
              "category": {"name": "Bún/Phở/Mỳ"}
            }
          },
          {
            "price": 15000,
            "food": {
              "code": "NUOCTRA05",
              "name": "Trà việt quất",
              "price": 15000,
              "description": "Trà giải khát",
              "isCombo": false,
              "imagePath":
                  "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Ftr%C3%A0%20vi%E1%BB%87t%20qu%E1%BA%A5t.jpg?alt=media&token=3e0b858e-1430-407e-9b07-ae770076391a",
              "category": {"name": "Nước Trà"}
            }
          }
        ]
      },
      "sessionDetails": [
        {
          "id": "f68b6a0a-289f-416f-95e8-855b37c4059a",
          "location": {
            "name": "Địa điểm giao hàng trường TH Long Thạnh Mỹ",
            "schoolId": "b254a297-cae1-4d26-afe2-b093227ded0a"
          }
        }
      ]
    }
  ],
  "message": "Thành công",
  "time": "2024-03-28T10:18:17.5682155Z"
};
