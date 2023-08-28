import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController friendName = TextEditingController();
  int currentPage = 0;
  PageController controller = PageController(initialPage: 0);
  PageController controller1 =
      PageController(initialPage: 0, viewportFraction: 0.3);
  bool positive = false;
  int active = 0;
  int itemCount = 12;

  dotCalculator(int count) {
    int result = (count / 5).floor();
    return result;
  }


  TabController? tabController;
  final int length = 20;
  int min = 0;
  @override
  void onInit() {
    super.onInit();
    min = dotCalculator(length);
  }
}
