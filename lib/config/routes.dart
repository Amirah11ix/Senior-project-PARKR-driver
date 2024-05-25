import 'package:get/get.dart';
import 'package:Driver/pages/about_us/about_us.dart';
import 'package:Driver/pages/homescreen.dart';

var pages = [
  GetPage(
    name: '/homepage',
    page: () => HomeScreen(),
    transition: Transition.rightToLeft,
  ),
  
  GetPage(
    name: '/about-us',
    page: () => AboutUs(),
    transition: Transition.rightToLeft,
  ),

];
