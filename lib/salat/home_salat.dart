import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
// import 'package:adhan_dart/adhan_dart.dart';
// import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
// import 'package:quran_app/controller/get_current_location_controller.dart';

class HomeSalat extends StatefulWidget {
  const HomeSalat({super.key});

  @override
  State<HomeSalat> createState() => _HomeSalatState();
}

class _HomeSalatState extends State<HomeSalat> {
  // DateTime date = new DateTime.now();
  // Coordinates coordinates = Coordinates(21.3891, 39.8579);
  // CalculationParameters params = CalculationMethod.MuslimWorldLeague();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // @override
  // void initState() {
  //   getCurrentLocation().then((value) {
  //     setState(() {
  //       coordinates = new Coordinates(value.latitude, value.longitude);
  //     });
  //   });
  //   date = new DateTime.now();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // params.madhab = Madhab.Hanafi;
    // PrayerTimes prayerTimes =
    //     new PrayerTimes(coordinates, date, params, precision: true);

    // params.adjustments.fajr = 2;
    return Scaffold(
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
        child: Center(
          child: Text(
            'هذا المحتوى غير متوفر حاليا',
            style: TextStyle(
              fontSize: 25,
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

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //       height: isScreenWidth(context) ? 50 : 60,
          //     ),
          //     Text(
          //       'Mecca',
          //       style: TextStyle(
          //         fontSize: fontSize3,
          //         fontFamily: arabicFont,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //         shadows: const [
          //           Shadow(
          //             offset: Offset(.5, .5),
          //             blurRadius: 1.0,
          //             color: Color.fromRGBO(6, 87, 96, 1),
          //           )
          //         ],
          //       ),
          //       textDirection: TextDirection.rtl,
          //     ),
          //     SizedBox(
          //       height: isScreenWidth(context) ? 50 : 60,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 30,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "${prayerTimes.fajr}",
          //             style: TextStyle(
          //               fontSize: fontSize3,
          //               fontFamily: arabicFont,
          //               color: const Color.fromRGBO(254, 249, 205, 1),
          //               shadows: const [
          //                 Shadow(
          //                   offset: Offset(.5, .5),
          //                   blurRadius: 1.0,
          //                   color: Color.fromRGBO(6, 87, 96, 1),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "الفجر",
          //                 style: TextStyle(
          //                   fontSize: fontSize3,
          //                   fontFamily: arabicFont,
          //                   color: const Color.fromRGBO(254, 249, 205, 1),
          //                   shadows: const [
          //                     Shadow(
          //                       offset: Offset(.5, .5),
          //                       blurRadius: 1.0,
          //                       color: Color.fromRGBO(6, 87, 96, 1),
          //                     )
          //                   ],
          //                 ),
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 FlutterIslamicIcons.prayingPerson,
          //                 size: fontSize3,
          //                 color: const Color.fromRGBO(254, 249, 205, 1),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: const Divider(
          //         height: 10,
          //         thickness: 0.5,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 30,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "18:30",
          //             style: TextStyle(
          //               fontSize: fontSize3,
          //               fontFamily: arabicFont,
          //               color: const Color.fromRGBO(254, 249, 205, 1),
          //               shadows: const [
          //                 Shadow(
          //                   offset: Offset(.5, .5),
          //                   blurRadius: 1.0,
          //                   color: Color.fromRGBO(6, 87, 96, 1),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "الظهر",
          //                 style: TextStyle(
          //                   fontSize: fontSize3,
          //                   fontFamily: arabicFont,
          //                   color: const Color.fromRGBO(254, 249, 205, 1),
          //                   shadows: const [
          //                     Shadow(
          //                       offset: Offset(.5, .5),
          //                       blurRadius: 1.0,
          //                       color: Color.fromRGBO(6, 87, 96, 1),
          //                     )
          //                   ],
          //                 ),
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 FlutterIslamicIcons.prayingPerson,
          //                 size: fontSize3,
          //                 color: const Color.fromRGBO(254, 249, 205, 1),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: const Divider(
          //         height: 10,
          //         thickness: 0.5,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 30,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "18:30",
          //             style: TextStyle(
          //               fontSize: fontSize3,
          //               fontFamily: arabicFont,
          //               color: const Color.fromRGBO(254, 249, 205, 1),
          //               shadows: const [
          //                 Shadow(
          //                   offset: Offset(.5, .5),
          //                   blurRadius: 1.0,
          //                   color: Color.fromRGBO(6, 87, 96, 1),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "العصر",
          //                 style: TextStyle(
          //                   fontSize: fontSize3,
          //                   fontFamily: arabicFont,
          //                   color: const Color.fromRGBO(254, 249, 205, 1),
          //                   shadows: const [
          //                     Shadow(
          //                       offset: Offset(.5, .5),
          //                       blurRadius: 1.0,
          //                       color: Color.fromRGBO(6, 87, 96, 1),
          //                     )
          //                   ],
          //                 ),
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 FlutterIslamicIcons.prayingPerson,
          //                 size: fontSize3,
          //                 color: const Color.fromRGBO(254, 249, 205, 1),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: const Divider(
          //         height: 10,
          //         thickness: 0.5,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 30,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "18:30",
          //             style: TextStyle(
          //               fontSize: fontSize3,
          //               fontFamily: arabicFont,
          //               color: const Color.fromRGBO(254, 249, 205, 1),
          //               shadows: const [
          //                 Shadow(
          //                   offset: Offset(.5, .5),
          //                   blurRadius: 1.0,
          //                   color: Color.fromRGBO(6, 87, 96, 1),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "المغرب",
          //                 style: TextStyle(
          //                   fontSize: fontSize3,
          //                   fontFamily: arabicFont,
          //                   color: const Color.fromRGBO(254, 249, 205, 1),
          //                   shadows: const [
          //                     Shadow(
          //                       offset: Offset(.5, .5),
          //                       blurRadius: 1.0,
          //                       color: Color.fromRGBO(6, 87, 96, 1),
          //                     )
          //                   ],
          //                 ),
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 FlutterIslamicIcons.prayingPerson,
          //                 size: fontSize3,
          //                 color: const Color.fromRGBO(254, 249, 205, 1),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: const Divider(
          //         height: 10,
          //         thickness: 0.5,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 30,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "18:30",
          //             style: TextStyle(
          //               fontSize: fontSize3,
          //               fontFamily: arabicFont,
          //               color: const Color.fromRGBO(254, 249, 205, 1),
          //               shadows: const [
          //                 Shadow(
          //                   offset: Offset(.5, .5),
          //                   blurRadius: 1.0,
          //                   color: Color.fromRGBO(6, 87, 96, 1),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "العشاء",
          //                 style: TextStyle(
          //                   fontSize: fontSize3,
          //                   fontFamily: arabicFont,
          //                   color: const Color.fromRGBO(254, 249, 205, 1),
          //                   shadows: const [
          //                     Shadow(
          //                       offset: Offset(.5, .5),
          //                       blurRadius: 1.0,
          //                       color: Color.fromRGBO(6, 87, 96, 1),
          //                     )
          //                   ],
          //                 ),
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 FlutterIslamicIcons.prayingPerson,
          //                 size: fontSize3,
          //                 color: const Color.fromRGBO(254, 249, 205, 1),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: const Divider(
          //         height: 10,
          //         thickness: 0.5,
          //         color: const Color.fromRGBO(254, 249, 205, 1),
          //       ),
          //     ),
          //     // SizedBox(
          //     //   height: 50,
          //     // ),
          //     // Text(
          //     //   // "${prayerTimes.fajr}",

          //     //   "${tz.TZDateTime.from(prayerTimes.fajr, date)}",
          //     //   style: TextStyle(
          //     //     fontSize: 30,
          //     //     fontFamily: arabicFont,
          //     //     color: const Color.fromRGBO(254, 249, 205, 1),
          //     //     shadows: const [
          //     //       Shadow(
          //     //         offset: Offset(.5, .5),
          //     //         blurRadius: 1.0,
          //     //         color: Color.fromRGBO(6, 87, 96, 1),
          //     //       )
          //     //     ],
          //     //   ),
          //     //   textDirection: TextDirection.rtl,
          //     // ),
          //     // ElevatedButton.icon(
          //     //   onPressed: () {
          //     //     getCurrentLocation().then((value) {
          //     //       setState(() {
          //     //         coordinates =
          //     //             new Coordinates(value.latitude, value.longitude);
          //     //       });
          //     //     });
          //     //     date = new DateTime.now();
          //     //   },
          //     //   icon: Icon(FlutterIslamicIcons.allah),
          //     //   label: Text('Add Adress'),
          //     // ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
