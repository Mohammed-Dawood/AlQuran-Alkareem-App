import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quran_app/controller/constant.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: isScreenWidth(context) ? 300 : 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(6, 87, 96, 1),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/logo_drawer.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${fontSize2.toInt()} ',
                      style: TextStyle(
                        fontSize: isScreenWidth(context) ? 20 : 22,
                        color: Color.fromRGBO(6, 87, 96, 1),
                        fontFamily: 'quran',
                        shadows: [
                          Shadow(
                            offset: Offset(.5, .5),
                            blurRadius: 1.0,
                            color: Color.fromRGBO(6, 87, 96, 1),
                          )
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'حجم خط القرآن',
                        style: TextStyle(
                          fontSize: isScreenWidth(context) ? 20 : 22,
                          color: Color.fromRGBO(6, 87, 96, 1),
                          fontFamily: 'quran',
                          shadows: [
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Slider(
                  activeColor: const Color.fromRGBO(6, 87, 96, 1),
                  value: fontSize2,
                  min: 20,
                  max: 40,
                  onChanged: (value) {
                    setState(
                      () {
                        fontSize2 = value;
                      },
                    );
                    saveSettings();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${fontSize1.toInt()} ',
                      style: TextStyle(
                        fontSize: isScreenWidth(context) ? 20 : 22,
                        color: Color.fromRGBO(6, 87, 96, 1),
                        fontFamily: 'quran',
                        shadows: [
                          Shadow(
                            offset: Offset(.5, .5),
                            blurRadius: 1.0,
                            color: Color.fromRGBO(6, 87, 96, 1),
                          )
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'حجم خط المسبحة',
                        style: TextStyle(
                          fontSize: isScreenWidth(context) ? 20 : 22,
                          color: Color.fromRGBO(6, 87, 96, 1),
                          fontFamily: 'quran',
                          shadows: [
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Slider(
                  activeColor: const Color.fromRGBO(6, 87, 96, 1),
                  value: fontSize1,
                  min: 20,
                  max: 40,
                  onChanged: (value) {
                    setState(
                      () {
                        fontSize1 = value;
                      },
                    );
                    saveSettings();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${fontSize3.toInt()} ',
                      style: TextStyle(
                        fontSize: isScreenWidth(context) ? 20 : 22,
                        color: Color.fromRGBO(6, 87, 96, 1),
                        fontFamily: 'quran',
                        shadows: [
                          Shadow(
                            offset: Offset(.5, .5),
                            blurRadius: 1.0,
                            color: Color.fromRGBO(6, 87, 96, 1),
                          )
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'حجم خط الصلاة',
                        style: TextStyle(
                          fontSize: isScreenWidth(context) ? 20 : 22,
                          color: Color.fromRGBO(6, 87, 96, 1),
                          fontFamily: 'quran',
                          shadows: [
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Slider(
                  activeColor: const Color.fromRGBO(6, 87, 96, 1),
                  value: fontSize3,
                  min: 20,
                  max: 40,
                  onChanged: (value) {
                    setState(
                      () {
                        fontSize3 = value;
                      },
                    );
                    saveSettings();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.share,
                        size: isScreenWidth(context) ? 25 : 27,
                        color: Color.fromRGBO(6, 87, 96, 1),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'شارك التطبيق',
                          style: TextStyle(
                            fontSize: isScreenWidth(context) ? 20 : 22,
                            color: Color.fromRGBO(6, 87, 96, 1),
                            fontFamily: 'quran',
                            shadows: [
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
                  ),
                  onPressed: () async {
                    final box = context.findRenderObject() as RenderBox?;
                    await Share.share(
                      'https://qrco.de/AlQuran-AlKareem',
                      subject: 'تطبيق القران الكريم',
                      sharePositionOrigin:
                          box!.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: isScreenWidth(context) ? 25 : 27,
                        color: Color.fromRGBO(6, 87, 96, 1),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'اتصلوا بنا',
                          style: TextStyle(
                            fontSize: isScreenWidth(context) ? 20 : 22,
                            color: Color.fromRGBO(6, 87, 96, 1),
                            fontFamily: 'quran',
                            shadows: [
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
                  ),
                  onPressed: () async {
                    Uri mail = Uri.parse(
                      "mailto:contact@mddigitaldevelopment.com?subject=QR Maker App&body=السلام عليكم,",
                    );
                    if (await canLaunchUrl(mail)) {
                      await launchUrl(mail);
                    } else {
                      throw 'Could not launch $mail';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 0.5,
                  color: const Color.fromRGBO(6, 87, 96, 0.5),
                ),
              ),
              Text(
                'الاصدار 1.3.1',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(6, 87, 96, 1),
                  fontFamily: 'quran',
                  shadows: [
                    Shadow(
                      offset: Offset(.5, .5),
                      blurRadius: 1.0,
                      color: Color.fromRGBO(6, 87, 96, 1),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}
