import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:quran_app/qiblah/qiblah_compass.dart';
import 'package:quran_app/qiblah/loading_indicator.dart';

class HomeQiblah extends StatefulWidget {
  const HomeQiblah({Key? key}) : super(key: key);

  @override
  State<HomeQiblah> createState() => _HomeQiblahState();
}

class _HomeQiblahState extends State<HomeQiblah> {
  var _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اتجاه القبلة",
          style: (isScreenWidth(context))
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
        child: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LoadingIndicator();
            if (snapshot.hasError)
              return Center(
                child: Text(
                  "Error: ${snapshot.error.toString()}",
                  style: TextStyle(
                    fontSize: isScreenWidth(context) ? 20 : 23,
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
                ),
              );
            if (snapshot.data!)
              return QiblahCompass();
            else
              return Center(
                child: Text(
                  'جهازك لا يدعم هذه الخدمة',
                  style: TextStyle(
                    fontSize: isScreenWidth(context) ? 20 : 23,
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
                ),
              );
          },
        ),
      ),
    );
  }
}
