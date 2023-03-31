import 'surah_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/controller/constant.dart';
// import 'package:quran_app/quran_read/arabic_sura_number.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class HomeQuranRead extends StatefulWidget {
  const HomeQuranRead({Key? key}) : super(key: key);

  @override
  State<HomeQuranRead> createState() => _HomeQuranReadState();
}

class _HomeQuranReadState extends State<HomeQuranRead> {
  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // var m = FlutterIslamicIcons.mosque;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'انتقل إلى المرجعية',
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahBuilder(
                  arabic: quran[0],
                  sura: bookmarkedSura - 1,
                  suraName: arabicName[bookmarkedSura - 1]['name'],
                  ayah: bookmarkedAyah,
                ),
              ),
            );
          } else {
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
                child: Text(
                  "ليس لديك أي موقع محفوظ حالياً.",
                  style: TextStyle(
                    fontSize: 14,
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
              ),
            );
          }
        },
        child: Icon(
          size: isScreenWidth(context) ? 25 : 28,
          color: Color.fromRGBO(6, 87, 96, 1),
          FlutterIslamicIcons.solidLocationMuslim,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "القرآن الكريم",
          style: isScreenWidth(context)
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.displayMedium,
        ),
        leading: Tooltip(
          message: 'معلومات',
          child: TextButton(
            child: Icon(
              size: isScreenWidth(context) ? 25 : 28,
              Icons.info,
              color: Color.fromRGBO(254, 249, 205, 1),
            ),
            onPressed: () {
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
                duration: const Duration(seconds: 15),
                messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            FlutterIslamicIcons.kaaba,
                            color: const Color.fromRGBO(254, 249, 205, 1),
                            size: 19,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "سورة مكية",
                            style: TextStyle(
                              fontSize: 14,
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            FlutterIslamicIcons.mosque,
                            color: const Color.fromRGBO(254, 249, 205, 1),
                            size: 19,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "سورة مدنية",
                            style: TextStyle(
                              fontSize: 14,
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
                    ],
                  ),
                ),
              );
            },
          ),
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
      body: FutureBuilder(
        future: readJson(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: const Color.fromRGBO(254, 249, 205, 1),
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return indexCreator(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Container indexCreator(quran, context) {
    return Container(
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
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < 114; i++)
            TextButton(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        arabicName[i]['icon'] == "FlutterIslamicIcons.kaaba"
                            ? Icon(
                                FlutterIslamicIcons.kaaba,
                                size: fontSize2,
                                color: const Color.fromRGBO(254, 249, 205, 1),
                              )
                            : Icon(
                                FlutterIslamicIcons.mosque,
                                size: fontSize2,
                                color: const Color.fromRGBO(254, 249, 205, 1),
                              ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                arabicName[i]['name'],
                                style: TextStyle(
                                  fontSize: fontSize2,
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
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FlutterIslamicIcons.quran,
                              size: fontSize2,
                              color: const Color.fromRGBO(254, 249, 205, 1),
                            ),
                            // ArabicSuraNumber(i: i),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(
                      thickness: 0.5,
                      color: const Color.fromRGBO(254, 249, 205, 0.5),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                fabIsClicked = false;
                Get.to(
                  () => SurahBuilder(
                    ayah: 0,
                    sura: i,
                    arabic: quran[0],
                    suraName: arabicName[i]['name'],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
