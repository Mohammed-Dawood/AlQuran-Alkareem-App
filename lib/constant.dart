import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

int bookmarkedAyah = 1;
int bookmarkedSura = 1;
bool fabIsClicked = true;

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

String arabicFont = 'quran';
double fontSize1 = 20;
double fontSize2 = 20;
double fontSize3 = 20;

Future saveSettings() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('arabicFontSize', fontSize1.toInt());
  await prefs.setInt('mushafFontSize', fontSize2.toInt());
  await prefs.setInt('salatFontSize', fontSize3.toInt());
}

Future getSettings() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    fontSize1 = await prefs.getInt('arabicFontSize')!.toDouble();
    fontSize2 = await prefs.getInt('mushafFontSize')!.toDouble();
    fontSize3 = await prefs.getInt('salatFontSize')!.toDouble();
  } catch (_) {
    fontSize1 = 20;
    fontSize2 = 20;
    fontSize3 = 20;
  }
}

saveBookMark(surah, ayah) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt("surah", surah);
  await prefs.setInt("ayah", ayah);

  int ayah1 = ayah + 1;
  Get.snackbar(
    '',
    '',
    shouldIconPulse: false,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    titleText: Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Icon(
            FlutterIslamicIcons.solidQuran,
            color: const Color.fromRGBO(254, 249, 205, 1),
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'القرآن الكريم',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'quran',
              color: const Color.fromRGBO(254, 249, 205, 1),
              shadows: [
                Shadow(
                  blurRadius: 1.0,
                  offset: Offset(.5, .5),
                  color: Color.fromRGBO(6, 87, 96, 1),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    duration: const Duration(seconds: 10),
    messageText: Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Text(
            ' تم تحديد الموقع بنجاح سورة ${arabicName[surah - 1]["name"]} الآية رقم $ayah1',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'quran',
              color: const Color.fromRGBO(254, 249, 205, 1),
              shadows: [
                Shadow(
                  blurRadius: 1.0,
                  offset: Offset(.5, .5),
                  color: Color.fromRGBO(6, 87, 96, 1),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

readBookmark() async {
  print("read book mark called");
  final prefs = await SharedPreferences.getInstance();
  try {
    bookmarkedAyah = prefs.getInt('ayah')!;
    bookmarkedSura = prefs.getInt('surah')!;
    return true;
  } catch (e) {
    return false;
  }
}

List<Map> arabicName = [
  {"surah": "1", "name": "الفاتحة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "2", "name": "البقرة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "3", "name": "آل عمران", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "4", "name": "النساء", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "5", "name": "المائدة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "6", "name": "الأنعام", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "7", "name": "الأعراف", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "8", "name": "الأنفال", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "9", "name": "التوبة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "10", "name": "يونس", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "11", "name": "هود", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "12", "name": "يوسف", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "13", "name": "الرعد", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "14", "name": "ابراهيم", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "15", "name": "الحجر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "16", "name": "النحل", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "17", "name": "الإسراء", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "18", "name": "الكهف", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "19", "name": "مريم", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "20", "name": "طه", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "21", "name": "الأنبياء", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "22", "name": "الحج", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "23", "name": "المؤمنون", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "24", "name": "النور", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "25", "name": "الفرقان", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "26", "name": "الشعراء", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "27", "name": "النمل", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "28", "name": "القصص", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "29", "name": "العنكبوت", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "30", "name": "الروم", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "31", "name": "لقمان", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "32", "name": "السجدة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "33", "name": "الأحزاب", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "34", "name": "سبإ", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "35", "name": "فاطر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "36", "name": "يس", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "37", "name": "الصافات", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "38", "name": "ص", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "39", "name": "الزمر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "40", "name": "غافر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "41", "name": "فصلت", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "42", "name": "الشورى", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "43", "name": "الزخرف", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "44", "name": "الدخان", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "45", "name": "الجاثية", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "46", "name": "الأحقاف", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "47", "name": "محمد", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "48", "name": "الفتح", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "49", "name": "الحجرات", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "50", "name": "ق", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "51", "name": "الذاريات", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "52", "name": "الطور", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "53", "name": "النجم", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "54", "name": "القمر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "55", "name": "الرحمن", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "56", "name": "الواقعة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "57", "name": "الحديد", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "58", "name": "المجادلة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "59", "name": "الحشر", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "60", "name": "الممتحنة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "61", "name": "الصف", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "62", "name": "الجمعة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "63", "name": "المنافقون", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "64", "name": "التغابن", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "65", "name": "الطلاق", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "66", "name": "التحريم", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "67", "name": "الملك", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "68", "name": "القلم", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "69", "name": "الحاقة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "70", "name": "المعارج", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "71", "name": "نوح", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "72", "name": "الجن", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "73", "name": "المزمل", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "74", "name": "المدثر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "75", "name": "القيامة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "76", "name": "الانسان", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "77", "name": "المرسلات", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "78", "name": "النبإ", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "79", "name": "النازعات", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "80", "name": "عبس", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "81", "name": "التكوير", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "82", "name": "الإنفطار", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "83", "name": "المطففين", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "84", "name": "الإنشقاق", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "85", "name": "البروج", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "86", "name": "الطارق", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "87", "name": "الأعلى", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "88", "name": "الغاشية", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "89", "name": "الفجر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "90", "name": "البلد", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "91", "name": "الشمس", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "92", "name": "الليل", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "93", "name": "الضحى", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "94", "name": "الشرح", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "95", "name": "التين", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "96", "name": "العلق", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "97", "name": "القدر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "98", "name": "البينة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "99", "name": "الزلزلة", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "100", "name": "العاديات", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "101", "name": "القارعة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "102", "name": "التكاثر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "103", "name": "العصر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "104", "name": "الهمزة", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "105", "name": "الفيل", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "106", "name": "قريش", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "107", "name": "الماعون", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "108", "name": "الكوثر", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "109", "name": "الكافرون", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "110", "name": "النصر", "icon": "FlutterIslamicIcons.mosque"},
  {"surah": "111", "name": "المسد", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "112", "name": "الإخلاص", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "113", "name": "الفلق", "icon": "FlutterIslamicIcons.kaaba"},
  {"surah": "114", "name": "الناس", "icon": "FlutterIslamicIcons.kaaba"}
];

List<int> noOfVerses = [
  7,
  286,
  200,
  176,
  120,
  165,
  206,
  75,
  129,
  109,
  123,
  111,
  43,
  52,
  99,
  128,
  111,
  110,
  98,
  135,
  112,
  78,
  118,
  64,
  77,
  227,
  93,
  88,
  69,
  60,
  34,
  30,
  73,
  54,
  45,
  83,
  182,
  88,
  75,
  85,
  54,
  53,
  89,
  59,
  37,
  35,
  38,
  29,
  18,
  45,
  60,
  49,
  62,
  55,
  78,
  96,
  29,
  22,
  24,
  13,
  14,
  11,
  11,
  18,
  12,
  12,
  30,
  52,
  52,
  44,
  28,
  28,
  20,
  56,
  40,
  31,
  50,
  40,
  46,
  42,
  29,
  19,
  36,
  25,
  22,
  17,
  19,
  26,
  30,
  20,
  15,
  21,
  11,
  8,
  8,
  19,
  5,
  8,
  8,
  11,
  11,
  8,
  3,
  9,
  5,
  4,
  7,
  3,
  6,
  3,
  5,
  4,
  5,
  6
];

List arabic = [];
List quran = [];

Future readJson() async {
  final String response =
      await rootBundle.loadString("assets/hafs_smart_v8.json");
  final data = json.decode(response);
  arabic = data["quran"];
  print("Read");
  return quran = [arabic];
}
