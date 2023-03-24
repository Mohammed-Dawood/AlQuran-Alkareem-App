import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class HomeMasbaha extends StatefulWidget {
  const HomeMasbaha({super.key});

  @override
  State<HomeMasbaha> createState() => _HomeMasbahaState();
}

class _HomeMasbahaState extends State<HomeMasbaha> {
  final box = GetStorage();
  int get masbahaNumber => box.read('newMasbahaNumber') ?? 0;

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "المسبحة الالكترونية",
          style: isScreenWidth(context)
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.displayMedium,
        ),
        leading: Icon(
          Icons.abc,
          color: const Color.fromRGBO(6, 87, 96, 1),
        ),
        actions: [
          TextButton(
            child: Icon(
              size: isScreenWidth(context) ? 25 : 28,
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(254, 249, 205, 1),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      bottomNavigationBar: FloatingNavbar(
        currentIndex: 2,
        borderRadius: 5,
        itemBorderRadius: 5,
        fontSize: isScreenWidth(context) ? 20 : 23,
        iconSize: isScreenWidth(context) ? 25 : 28,
        backgroundColor: const Color.fromRGBO(6, 87, 96, 1),
        selectedItemColor: const Color.fromRGBO(6, 87, 96, 1),
        unselectedItemColor: const Color.fromRGBO(254, 249, 205, 1),
        selectedBackgroundColor: const Color.fromRGBO(254, 249, 205, 1),
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
            icon: Icons.remove,
            title: "مسح",
          ),
          FloatingNavbarItem(
            icon: Icons.restore,
            title: "تصفير",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.tasbihHand,
            title: "تسبيح",
          ),
        ],
        onTap: (int screenNumber) async {
          if (screenNumber == 0) {
            masbahaNumber == 0
                ? setState(() {
                    box.write('newMasbahaNumber', 0);
                  })
                : setState(() {
                    box.write('newMasbahaNumber', masbahaNumber - 1);
                  });
          }
          if (screenNumber == 1) {
            setState(() {
              box.write('newMasbahaNumber', 0);
            });
          }
          if (screenNumber == 2) {
            masbahaNumber == 999
                ? setState(() {
                    box.write('newMasbahaNumber', 0);
                  })
                : setState(() {
                    box.write('newMasbahaNumber', masbahaNumber + 1);
                  });
          }
        },
      ),
      body: Container(
        decoration: MediaQuery.of(context).orientation == Orientation.portrait
            ? (isScreenWidth(context))
                ? BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/background.png'),
                    ),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/background_portrait.png'),
                    ),
                  )
            : BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background_landscape.png'),
                ),
              ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$masbahaNumber',
                style: TextStyle(
                  fontSize: fontSize1 + 50,
                  fontFamily: arabicFont,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                  shadows: const [
                    Shadow(
                      offset: Offset(.5, .5),
                      blurRadius: 1.0,
                      color: Color.fromRGBO(6, 87, 96, 1),
                    )
                  ],
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
