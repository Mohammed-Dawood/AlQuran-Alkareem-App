import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/salat/screen_salat.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:quran_app/controller/loading_indicator.dart';
import 'package:quran_app/controller/location_error_widget.dart';

class HomeSalat extends StatefulWidget {
  const HomeSalat({super.key});

  @override
  State<HomeSalat> createState() => _HomeSalatState();
}

class _HomeSalatState extends State<HomeSalat> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "أوقات الصلاة",
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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return LoadingIndicator();

              if (snapshot.data!.enabled == true) {
                switch (snapshot.data!.status) {
                  case LocationPermission.always:
                  case LocationPermission.whileInUse:
                    return ScreenSalat();

                  case LocationPermission.denied:
                    return LocationErrorWidget(
                      error: "رفض إذن خدمة الموقع",
                      callback: _checkLocationStatus,
                    );

                  case LocationPermission.deniedForever:
                    return LocationErrorWidget(
                      error: "رفض خدمة تحديد الموقع الى الابد",
                      callback: _checkLocationStatus,
                    );

                  default:
                    return const SizedBox();
                }
              } else {
                return LocationErrorWidget(
                  error: "الرجاء تشغيل خدمة تحديد الموقع",
                  callback: _checkLocationStatus,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}
