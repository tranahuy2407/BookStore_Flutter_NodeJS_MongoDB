import 'package:flutter/material.dart';

String uri = 'http://172.17.9.98:3000';



class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    'https://danviet.mediacdn.vn/zoom/600_315/296231569849192448/2023/9/21/mua-he-khong-tenbia-1695271440342968259363-932-0-1647-1365-crop-1695271546522680437722.jpeg',
    'https://images.spiderum.com/sp-images/33aa11f0b76f11edb8f5af6c5b4c8dfc.jpeg',
    'https://allimages.sgp1.digitaloceanspaces.com/tipeduvn/2022/06/1655053645_568_Hinh-anh-cuon-sach-dep-%E2%80%93-Nguon-tri-thuc-vo.jpg',
    'https://blog.ejoy-english.com/wp-content/uploads/2018/03/to-kill-a-mockingbird.jpg',
    'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474118aqq/hinh-nen-quyen-sach-tuyet-dep_012555444.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Giáo khoa',
      'image': 'assets/images/gk.png',
    },
    {
      'title': 'Văn học',
      'image': 'assets/images/vh.png',
    },
    {
      'title': 'Lịch sử',
      'image': 'assets/images/ls.png',
    },
    {
      'title': 'Truyện tranh',
      'image': 'assets/images/tt.png',
    },
    {
      'title': 'Tâm lý',
      'image': 'assets/images/tc.png',
    },
  ];
}