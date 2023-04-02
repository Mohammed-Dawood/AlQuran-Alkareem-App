import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:quran_app/controller/loading_indicator.dart';
import 'package:quran_app/controller/location_error_widget.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class QiblahCompass extends StatefulWidget {
  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "رفض إذن خدمة تحديد الموقع",
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

class QiblahCompassWidget extends StatelessWidget {
  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final qiblahDirection = snapshot.data!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: isScreenWidth(context) ? 50 : 60,
              FlutterIslamicIcons.solidKaaba,
              color: Color.fromRGBO(254, 249, 205, 1),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/qiblah_free.png',
                    width: isScreenWidth(context) ? 350 : 370,
                    height: isScreenWidth(context) ? 350 : 370,
                  ),
                ),
                Transform.rotate(
                  angle: (qiblahDirection.direction * (pi / 180) * 0),
                  alignment: Alignment.center,
                  child: Icon(
                    size: isScreenWidth(context) ? 35 : 45,
                    FlutterIslamicIcons.sajadah,
                    color: Color.fromRGBO(6, 87, 96, 1),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
