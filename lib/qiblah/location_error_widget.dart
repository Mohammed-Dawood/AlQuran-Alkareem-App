import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    const errorColor = const Color.fromRGBO(254, 249, 205, 1);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            error!,
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
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "أعد المحاولة",
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
            ),
            onPressed: () {
              if (callback != null) callback!();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(6, 87, 96, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
