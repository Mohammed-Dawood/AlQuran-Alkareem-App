import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/controller/constant.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahBuilder extends StatefulWidget {
  final int ayah;
  final dynamic sura;
  final dynamic arabic;
  final dynamic suraName;

  SurahBuilder({
    Key? key,
    required this.ayah,
    required this.sura,
    required this.arabic,
    required this.suraName,
  }) : super(key: key);

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool view = true;

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToAyah());
    super.initState();
  }

  jumpToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.arabic[index + previousVerses]['aya_text'],
            textDirection: TextDirection.rtl,
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
          ),
        ),
      ],
    );
  }

  SafeArea SingleSuraBuilder(LengthOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < LengthOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
      bottom: false,
      child: Container(
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
        child: ScrollablePositionedList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                    ? const Text('')
                    : const RetunBasmala(),
                PopupMenuButton(
                  color: const Color.fromRGBO(254, 249, 205, 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                    ),
                    child: verseBuilder(index, previousVerses),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        saveBookMark(widget.sura + 1, index);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "إشارة مرجعية",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'quran',
                              color: const Color.fromRGBO(6, 87, 96, 1),
                              shadows: [
                                Shadow(
                                  blurRadius: 1.0,
                                  offset: Offset(.5, .5),
                                  color: const Color.fromRGBO(254, 249, 205, 1),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            size: 30,
                            color: Color.fromRGBO(6, 87, 96, 1),
                            FlutterIslamicIcons.solidLocationMuslim,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: LengthOfSura,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];

    return Scaffold(
      appBar: AppBar(
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
                duration: const Duration(seconds: 10),
                messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "اضغط في اي مكان على الشاشة لحفظ الموقع الذي وصلت إليه أثناء القراءة، حتى يتسنى لك الرجوع إليه في المستقبل.",
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
                ),
              );
            },
          ),
        ),
        // leading: Tooltip(
        //   message: 'Mushaf Mode',
        //   child: TextButton(
        //     child: Icon(
        //       size: isScreenWidth(context) ? 25 : 28,
        //       Icons.chrome_reader_mode,
        //       color: Color.fromRGBO(254, 249, 205, 1),
        //     ),
        //     onPressed: () {
        //       setState(
        //         () {
        //           view = !view;
        //         },
        //       );
        //     },
        //   ),
        // ),
        title: Text(
          widget.suraName,
          style: isScreenWidth(context)
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleSuraBuilder(LengthOfSura),
    );
  }
}

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'بسم الله الرحمن الرحيم',
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
    );
  }
}
