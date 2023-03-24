import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/salat/home_salat.dart';
import 'package:quran_app/drawer/my_drawer.dart';
import 'package:quran_app/qiblah/home_qiblah.dart';
import 'package:quran_app/masbaha/home_masbaha.dart';
import 'package:quran_app/quran_read/home_quran_read.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: Text(
          "الصفحة الرئيسية",
          style: isScreenWidth(context)
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.displayMedium,
        ),
        iconTheme: IconThemeData(
          color: const Color.fromRGBO(254, 249, 205, 1),
          size: isScreenWidth(context) ? 25 : 28,
        ),
      ),
      bottomNavigationBar: FloatingNavbar(
        currentIndex: 2,
        borderRadius: 5,
        itemBorderRadius: 5,
        fontSize: isScreenWidth(context) ? 20 : 23,
        iconSize: isScreenWidth(context) ? 25 : 28,
        backgroundColor: const Color.fromRGBO(6, 87, 96, 1),
        selectedItemColor: const Color.fromRGBO(254, 249, 205, 1),
        unselectedItemColor: const Color.fromRGBO(254, 249, 205, 1),
        selectedBackgroundColor: const Color.fromRGBO(6, 87, 96, 1),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 10,
        ),
        items: [
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.prayingPerson,
            title: "الصلاة",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.qibla,
            title: "القبلة",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.tasbihHand,
            title: "المسبحة",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.quran,
            title: "القرآن",
          ),
        ],
        onTap: (int screenNumber) async {
          if (screenNumber == 0) {
            Get.to(() => HomeSalat());
          }
          if (screenNumber == 1) {
            Get.to(() => HomeQiblah());
          }
          if (screenNumber == 2) {
            Get.to(() => HomeMasbaha());
          }
          if (screenNumber == 3) {
            Get.to(() => HomeQuranRead());
          }
        },
      ),
      body: Container(
        decoration: MediaQuery.of(context).orientation == Orientation.portrait
            ? isScreenWidth(context)
                ? BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/screen.png'),
                    ),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/screen_portrait.png'),
                    ),
                  )
            : BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/screen_landscape.png'),
                ),
              ),
      ),
    );
  }
}
