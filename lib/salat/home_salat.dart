import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/constant.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class HomeSalat extends StatefulWidget {
  const HomeSalat({super.key});

  @override
  State<HomeSalat> createState() => _HomeSalatState();
}

class _HomeSalatState extends State<HomeSalat> {
  late DateTime date;
  final box = GetStorage();
  late PrayerTimes prayerTimes;
  late Coordinates coordinates;
  late CalculationParameters params;
  bool get isTimePresenter => box.read('isTimePresenter') ?? true;

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  String timePresenter(DateTime dateTime) {
    String timeInString = "";
    int minute = dateTime.minute;
    bool isGreaterThan12 = dateTime.hour > 12;
    String prefix = dateTime.hour > 11 ? "pm" : "am";
    int hour = isGreaterThan12 ? dateTime.hour - 12 : dateTime.hour;
    String hourInString = hour.toString().length == 1 ? "0$hour" : "$hour";
    String minuteInString =
        minute.toString().length == 1 ? "0$minute" : "$minute";
    return "$hourInString:$minuteInString $prefix";
  }

  @override
  void initState() {
    date = DateTime.now();
    params = CalculationMethod.MuslimWorldLeague();
    coordinates = Coordinates(48.88849896670728, 2.238074852108114);
    prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
    // TODO: implement initState
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
            icon: Icons.watch_later_outlined,
            title: isTimePresenter ? "12" : "24",
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
            setState(() {
              box.write("isTimePresenter", !isTimePresenter);
            });
          }
          if (screenNumber == 1) {}
          if (screenNumber == 2) {}
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: isScreenWidth(context) ? 50 : 60,
              ),
              Text(
                'Mecca',
                style: TextStyle(
                  fontSize: fontSize3,
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
                height: isScreenWidth(context) ? 50 : 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTimePresenter
                          ? "${timePresenter(prayerTimes.fajr!.toLocal())}"
                          : "${prayerTimes.fajr!.toLocal().hour}:${prayerTimes.fajr!.toLocal().minute}",
                      style: TextStyle(
                        fontSize: fontSize3,
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
                    Row(
                      children: [
                        Text(
                          "الفجر",
                          style: TextStyle(
                            fontSize: fontSize3,
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
                          width: 10,
                        ),
                        Icon(
                          FlutterIslamicIcons.prayingPerson,
                          size: fontSize3,
                          color: const Color.fromRGBO(254, 249, 205, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  height: 10,
                  thickness: 0.5,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTimePresenter
                          ? "${timePresenter(prayerTimes.dhuhr!.toLocal())}"
                          : "${prayerTimes.dhuhr!.toLocal().hour}:${prayerTimes.dhuhr!.toLocal().minute}",
                      style: TextStyle(
                        fontSize: fontSize3,
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
                    Row(
                      children: [
                        Text(
                          "الظهر",
                          style: TextStyle(
                            fontSize: fontSize3,
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
                          width: 10,
                        ),
                        Icon(
                          FlutterIslamicIcons.prayingPerson,
                          size: fontSize3,
                          color: const Color.fromRGBO(254, 249, 205, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  height: 10,
                  thickness: 0.5,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTimePresenter
                          ? "${timePresenter(prayerTimes.asr!.toLocal())}"
                          : "${prayerTimes.asr!.toLocal().hour}:${prayerTimes.asr!.toLocal().minute}",
                      style: TextStyle(
                        fontSize: fontSize3,
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
                    Row(
                      children: [
                        Text(
                          "العصر",
                          style: TextStyle(
                            fontSize: fontSize3,
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
                          width: 10,
                        ),
                        Icon(
                          FlutterIslamicIcons.prayingPerson,
                          size: fontSize3,
                          color: const Color.fromRGBO(254, 249, 205, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  height: 10,
                  thickness: 0.5,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTimePresenter
                          ? "${timePresenter(prayerTimes.maghrib!.toLocal())}"
                          : "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                      style: TextStyle(
                        fontSize: fontSize3,
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
                    Row(
                      children: [
                        Text(
                          "المغرب",
                          style: TextStyle(
                            fontSize: fontSize3,
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
                          width: 10,
                        ),
                        Icon(
                          FlutterIslamicIcons.prayingPerson,
                          size: fontSize3,
                          color: const Color.fromRGBO(254, 249, 205, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  height: 10,
                  thickness: 0.5,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTimePresenter
                          ? "${timePresenter(prayerTimes.isha!.toLocal())}"
                          : "${prayerTimes.isha!.toLocal().hour}:${prayerTimes.isha!.toLocal().minute}",
                      style: TextStyle(
                        fontSize: fontSize3,
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
                    Row(
                      children: [
                        Text(
                          "العشاء",
                          style: TextStyle(
                            fontSize: fontSize3,
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
                          width: 10,
                        ),
                        Icon(
                          FlutterIslamicIcons.prayingPerson,
                          size: fontSize3,
                          color: const Color.fromRGBO(254, 249, 205, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  height: 10,
                  thickness: 0.5,
                  color: const Color.fromRGBO(254, 249, 205, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
