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
                        "id": "daa40ec9-f3d3-4129-87d6-23107584ed7e",
                        "price": 15000,
                        "food": {
                            "id": "26b0b242-b90a-4e98-a372-22f371055a90",
                            "code": "NUOCDONGCHAI02",
                            "name": "Sting Dâu",
                            "price": 15000,
                            "description": "Nước ngọt có gas",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fsting.jpeg?alt=media&token=0f308f6a-20cb-45fd-a367-4df31bf2c928",
                            "category": {
                                "name": "Nước đóng chai"
                            }
                        }
                    },
                    {
                        "id": "65734f7d-1bb3-4cc3-bf04-27559f5cc8f3",
                        "price": 15000,
                        "food": {
                            "id": "1aa3b14e-d6f1-4c57-9f6c-8f1887417a55",
                            "code": "BANHMI05",
                            "name": "Bánh mì ốp la",
                            "price": 15000,
                            "description": "Bánh mì + 2 trứng ốp la + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20%E1%BB%91p%20la.jfif?alt=media&token=e7b6bc4b-2fe6-4779-a062-a5ceefb8d33b",
                            "category": {
                                "name": "Bánh mì"
                            }
                        }
                    },
                    {
                        "id": "fa2dcc19-0c6d-404f-b86d-2e1802e64818",
                        "price": 20000,
                        "food": {
                            "id": "012c16de-643c-4944-9dd3-9fb31f434183",
                            "code": "BANHMI01",
                            "name": "Bánh mì heo quay",
                            "price": 20000,
                            "description": "Bánh mì + Heo quay + Nước sốt đặc biệt Dưa leo + Dưa chua + Hành ngò + Ớt",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2FB%C3%A1nh%20m%C3%AC%20heo%20quay.jpg?alt=media&token=0bb5e9ff-9791-444e-abce-b56a0f1164ef",
                            "category": {
                                "name": "Bánh mì"
                            }
                        }
                    },
                    {
                        "id": "093abb20-7708-4581-b471-4a610c9df77a",
                        "price": 15000,
                        "food": {
                            "id": "c144f88c-6ac1-4f2d-ba6f-413a3ddd6482",
                            "code": "NUOCDONGCHAI03",
                            "name": "7UP",
                            "price": 15000,
                            "description": "Nước ngọt có gas",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2F7up.jpg?alt=media&token=9022ff90-3b9b-4b5f-92e4-23175948b065",
                            "category": {
                                "name": "Nước đóng chai"
                            }
                        }
                    },
                    {
                        "id": "1501b906-a402-447a-8a1b-95e3dacdee64",
                        "price": 15000,
                        "food": {
                            "id": "3b787018-6ff3-4a4c-ad96-89c4791a4399",
                            "code": "NUOCDONGCHAI05",
                            "name": "Pepsi",
                            "price": 15000,
                            "description": "Nước ngọt có gas",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fpepsi.jpg?alt=media&token=d5f30d07-3edb-4bb9-9a7c-c71a686e72ee",
                            "category": {
                                "name": "Nước đóng chai"
                            }
                        }
                    },
                    {
                        "id": "935bd153-cae1-4e16-afd0-a9dc5a9c77ff",
                        "price": 15000,
                        "food": {
                            "id": "a7d151ce-71b0-47a0-a6a7-c4c95f1ca4f6",
                            "code": "BANHMI03",
                            "name": "Bánh mì nem nướng",
                            "price": 15000,
                            "description": "Bánh mì + Nem nướng + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20nem%20n%C6%B0%E1%BB%9Bng.jpg?alt=media&token=85a4bae1-a057-426f-a0ab-c1ac009478cb",
                            "category": {
                                "name": "Bánh mì"
                            }
                        }
                    },
                    {
                        "id": "027708b7-575a-4ec3-89ff-c9829bf8e353",
                        "price": 20000,
                        "food": {
                            "id": "b8be369c-8b82-4114-ae99-30a978fb7019",
                            "code": "BANHMI02",
                            "name": "Bánh mì cá hộp",
                            "price": 20000,
                            "description": "Bánh mì + Cá mồi hộp + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20c%C3%A1%20h%E1%BB%99p.png?alt=media&token=51cf21e4-be8f-4e5c-8776-91728b7ec0a7",
                            "category": {
                                "name": "Bánh mì"
                            }
                        }
                    },
                    {
                        "id": "3edfbbe3-8be3-4b69-9751-cd5d11f109e9",
                        "price": 7000,
                        "food": {
                            "id": "76b1ecea-0b97-418e-bb35-d9b5d9934d29",
                            "code": "NUOCDONGCHAI01",
                            "name": "Nước suối",
                            "price": 7000,
                            "description": "Nước suối Aquafina",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Drinks%2Fn%C6%B0%E1%BB%9Bc%20su%E1%BB%91i.jpg?alt=media&token=5fc5db56-f6c2-410f-b795-e1891ef49ad7",
                            "category": {
                                "name": "Nước đóng chai"
                            }
                        }
                    },
                    {
                        "id": "4b6a3302-db1b-47d3-b80b-d77dfd38ff1d",
                        "price": 25000,
                        "food": {
                            "id": "347c8c49-c6bb-4abf-bf4c-c06e35ae5b6d",
                            "code": "BANHMI06",
                            "name": "Bánh mì thập cẩm",
                            "price": 25000,
                            "description": "Bánh mì + Heo quay + Xá xíu + Nem nướng + Nước sốt đặc biệt + Dưa leo + Dưa chua + Hành ngò + Ớt",
                            "isCombo": false,
                            "imagePath": "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fb%C3%A1nh%20m%C3%AC%20th%E1%BA%ADp%20c%E1%BA%A9m.jpg?alt=media&token=c004abe2-40a2-4c4e-a283-f4aab56e5fbb",
                            "category": {
                                "name": "Bánh mì"
                            }
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
        }
    ],
    "message": "Thành công",
    "time": "2024-04-02T10:08:01.0480149Z"
};
