import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: const Color.fromRGBO(254, 249, 205, 1),
    );
  }
}
