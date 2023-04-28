import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/controller/constant.dart';
import 'package:quran_app/controller/loading_indicator.dart';
import 'package:quran_app/salat/utils/notification_manager.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class ScreenSalat extends StatefulWidget {
  const ScreenSalat({super.key});

  @override
  State<ScreenSalat> createState() => _ScreenSalatState();
}

class _ScreenSalatState extends State<ScreenSalat> {
  String? address;
  final box = GetStorage();
  Coordinates? coordinates;
  late PrayerTimes prayerTimes;
  DateTime date = DateTime.now();
  int get i => box.read("i") ?? 5;
  HijriCalendar hijriDate = HijriCalendar.now();
  CalculationParameters get params => paramsList[i];
  bool get isHijriDate => box.read("isHijriDate") ?? true;
  bool get isTimePresenter => box.read("isTimePresenter") ?? true;

  //? if null (??) means that it is False user didn't activated it
  bool get isFajr => box.read("isFajr") ?? false;
  bool get isDhuhr => box.read("isDhuhr") ?? false;
  bool get isAsr => box.read("isAsr") ?? false;
  bool get isMaghrib => box.read("isMaghrib") ?? false;
  bool get isIsha => box.read("isIsha") ?? false;

  List paramsList = [
    CalculationMethod.Tehran(),
    CalculationMethod.Karachi(),
    CalculationMethod.Egyptian(),
    CalculationMethod.UmmAlQura(),
    CalculationMethod.NorthAmerica(),
    CalculationMethod.MuslimWorldLeague(),
  ];

  List paramsListName = [
    "جامعة طهران",
    "جامعة العلوم الاسلامية، كراتشي",
    "الهيئة المصرية العامة للمساحة",
    "جامعة أم القرى بمكة المكرمة",
    "الجمعية الاسلامية لامريكا الشمالية",
    "رابطة العالم الإسلامي",
  ];

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  String timePresenter(DateTime dateTime) {
    int minute = dateTime.minute;
    bool isGreaterThan12 = dateTime.hour > 12;
    // String prefix = dateTime.hour > 11 ? "pm" : "am";
    int hour = isGreaterThan12 ? dateTime.hour - 12 : dateTime.hour;
    String hourInString = hour.toString().length == 1 ? "0$hour" : "$hour";
    String minuteInString =
        minute.toString().length == 1 ? "0$minute" : "$minute";
    // return "$hourInString:$minuteInString $prefix";
    return "$hourInString:$minuteInString";
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: "ar_SA",
    );
    Placemark place = placemark[0];
    setState(() {
      address = '${place.country} - ${place.locality}';
    });
  }

  void getPrayerTime() {
    Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        getAddressFromLatLang(position);
        coordinates = Coordinates(position.latitude, position.longitude);
        prayerTimes = PrayerTimes(coordinates!, date, params, precision: true);
      });
    });
  }

  @override
  void initState() {
    getPrayerTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: 0,
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
            icon: FlutterIslamicIcons.iftar,
            title: isTimePresenter ? "12" : "24",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.crescentMoon,
            title: "المركز",
          ),
          FloatingNavbarItem(
            icon: FlutterIslamicIcons.calendar,
            title: "التقويم",
          ),
        ],
        onTap: (int screenNumber) async {
          if (screenNumber == 0) {
            setState(() {
              box.write("isTimePresenter", !isTimePresenter);
            });
          }
          if (screenNumber == 1) {
            if (i < paramsList.length - 1) {
              setState(() {
                box.write("i", i + 1);
                getPrayerTime();
              });
            } else {
              setState(() {
                box.write("i", 0);
                getPrayerTime();
              });
            }
          }
          if (screenNumber == 2) {
            setState(() {
              box.write("isHijriDate", !isHijriDate);
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
          child: coordinates == null
              ? LoadingIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          Text(
                            isHijriDate
                                ? '${hijriDate} هجري'
                                : "${DateFormat.yMd().format(date)} ميلادي",
                            style: TextStyle(
                              fontSize: 20,
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
                          Text(
                            '${paramsListName[i]}',
                            style: TextStyle(
                              fontSize: 20,
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
                          Text(
                            address == null ? "" : '${address}',
                            style: TextStyle(
                              fontSize: 20,
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
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              box.write("isFajr", !isFajr);
                            });

                            isFajr
                                ? await NotificationManager()
                                    .scheduleDailyNotificationWithSound(
                                    id: 0,
                                    title: "القرآن الكريم",
                                    body: "حان الان موعد اذان الفجر",
                                    snackbarBody: "تفعيل  إشعار صلاة  الفجر",
                                    time: Time(
                                      prayerTimes.fajr!.toLocal().hour,
                                      prayerTimes.fajr!.toLocal().minute,
                                    ),
                                  )
                                : await NotificationManager()
                                    .cancelNotificationById(
                                    id: 0,
                                    title: "إلغاء إشعار صلاة  الفجر",
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isTimePresenter
                                      ? "${timePresenter(prayerTimes.fajr!.toLocal())}"
                                      : "${DateFormat.Hm().format(prayerTimes.fajr!.toLocal())}",
                                  style: TextStyle(
                                    fontSize: fontSize3,
                                    fontFamily: arabicFont,
                                    color:
                                        const Color.fromRGBO(254, 249, 205, 1),
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
                                        color: const Color.fromRGBO(
                                            254, 249, 205, 1),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(.5, .5),
                                            blurRadius: 1.0,
                                            color: Color.fromRGBO(6, 87, 96, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      isFajr
                                          ? Icons.notifications_active_outlined
                                          : Icons.notifications_off_outlined,
                                      size: fontSize3,
                                      color: const Color.fromRGBO(
                                          254, 249, 205, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              box.write("isDhuhr", !isDhuhr);
                            });

                            isDhuhr
                                ? await NotificationManager()
                                    .scheduleDailyNotificationWithSound(
                                    id: 1,
                                    title: "القرآن الكريم",
                                    body: "حان الان موعد اذان الظهر",
                                    snackbarBody: "تفعيل  إشعار صلاة  الظهر",
                                    time: Time(
                                      prayerTimes.dhuhr!.toLocal().hour,
                                      prayerTimes.dhuhr!.toLocal().minute,
                                    ),
                                  )
                                : await NotificationManager()
                                    .cancelNotificationById(
                                    id: 1,
                                    title: "إلغاء إشعار صلاة  الظهر",
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isTimePresenter
                                      ? "${timePresenter(prayerTimes.dhuhr!.toLocal())}"
                                      : "${DateFormat.Hm().format(prayerTimes.dhuhr!.toLocal())}",
                                  style: TextStyle(
                                    fontSize: fontSize3,
                                    fontFamily: arabicFont,
                                    color:
                                        const Color.fromRGBO(254, 249, 205, 1),
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
                                        color: const Color.fromRGBO(
                                            254, 249, 205, 1),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(.5, .5),
                                            blurRadius: 1.0,
                                            color: Color.fromRGBO(6, 87, 96, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      isDhuhr
                                          ? Icons.notifications_active_outlined
                                          : Icons.notifications_off_outlined,
                                      size: fontSize3,
                                      color: const Color.fromRGBO(
                                          254, 249, 205, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              box.write("isAsr", !isAsr);
                            });

                            isAsr
                                ? await NotificationManager()
                                    .scheduleDailyNotificationWithSound(
                                    id: 2,
                                    title: "القرآن الكريم",
                                    body: "حان الان موعد اذان العصر",
                                    snackbarBody: "تفعيل  إشعار صلاة  العصر",
                                    time: Time(
                                      prayerTimes.asr!.toLocal().hour,
                                      prayerTimes.asr!.toLocal().minute,
                                    ),
                                  )
                                : await NotificationManager()
                                    .cancelNotificationById(
                                    id: 2,
                                    title: "إلغاء إشعار صلاة  العصر",
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isTimePresenter
                                      ? "${timePresenter(prayerTimes.asr!.toLocal())}"
                                      : "${DateFormat.Hm().format(prayerTimes.asr!.toLocal())}",
                                  style: TextStyle(
                                    fontSize: fontSize3,
                                    fontFamily: arabicFont,
                                    color:
                                        const Color.fromRGBO(254, 249, 205, 1),
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
                                        color: const Color.fromRGBO(
                                            254, 249, 205, 1),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(.5, .5),
                                            blurRadius: 1.0,
                                            color: Color.fromRGBO(6, 87, 96, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      isAsr
                                          ? Icons.notifications_active_outlined
                                          : Icons.notifications_off_outlined,
                                      size: fontSize3,
                                      color: const Color.fromRGBO(
                                          254, 249, 205, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              box.write("isMaghrib", !isMaghrib);
                            });

                            // isMaghrib
                            //     ? await NotificationService()
                            //         .showNotificationWithSound(
                            //         "القرآن الكريم",
                            //         "حان الان موعد اذان المغرب",
                            //       )
                            //     : null;

                            isMaghrib
                                ? await NotificationManager()
                                    .scheduleDailyNotificationWithSound(
                                    id: 3,
                                    title: "القرآن الكريم",
                                    body: "حان الان موعد اذان المغرب",
                                    snackbarBody: "تفعيل  إشعار صلاة  المغرب",
                                    time: Time(
                                      prayerTimes.maghrib!.toLocal().hour,
                                      prayerTimes.maghrib!.toLocal().minute,
                                    ),
                                  )
                                : await NotificationManager()
                                    .cancelNotificationById(
                                    id: 3,
                                    title: "إلغاء إشعار صلاة  المغرب",
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isTimePresenter
                                      ? "${timePresenter(prayerTimes.maghrib!.toLocal())}"
                                      : "${DateFormat.Hm().format(prayerTimes.maghrib!.toLocal())}",
                                  style: TextStyle(
                                    fontSize: fontSize3,
                                    fontFamily: arabicFont,
                                    color:
                                        const Color.fromRGBO(254, 249, 205, 1),
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
                                        color: const Color.fromRGBO(
                                            254, 249, 205, 1),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(.5, .5),
                                            blurRadius: 1.0,
                                            color: Color.fromRGBO(6, 87, 96, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      isMaghrib
                                          ? Icons.notifications_active_outlined
                                          : Icons.notifications_off_outlined,
                                      size: fontSize3,
                                      color: const Color.fromRGBO(
                                          254, 249, 205, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              box.write("isIsha", !isIsha);
                            });

                            isIsha
                                ? await NotificationManager()
                                    .scheduleDailyNotificationWithSound(
                                    id: 4,
                                    title: "القرآن الكريم",
                                    body: "حان الان موعد اذان العشاء",
                                    snackbarBody: "تفعيل  إشعار صلاة  العشاء",
                                    time: Time(
                                      prayerTimes.isha!.toLocal().hour,
                                      prayerTimes.isha!.toLocal().minute,
                                    ),
                                  )
                                : await NotificationManager()
                                    .cancelNotificationById(
                                    id: 4,
                                    title: "إلغاء إشعار صلاة  العشاء",
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isTimePresenter
                                      ? "${timePresenter(prayerTimes.isha!.toLocal())}"
                                      : "${DateFormat.Hm().format(prayerTimes.isha!.toLocal())}",
                                  style: TextStyle(
                                    fontSize: fontSize3,
                                    fontFamily: arabicFont,
                                    color:
                                        const Color.fromRGBO(254, 249, 205, 1),
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
                                        color: const Color.fromRGBO(
                                            254, 249, 205, 1),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(.5, .5),
                                            blurRadius: 1.0,
                                            color: Color.fromRGBO(6, 87, 96, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      isIsha
                                          ? Icons.notifications_active_outlined
                                          : Icons.notifications_off_outlined,
                                      size: fontSize3,
                                      color: const Color.fromRGBO(
                                          254, 249, 205, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                    SizedBox(
                      height: isScreenWidth(context) ? 50 : 60,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
