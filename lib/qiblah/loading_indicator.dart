import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget = (Platform.isAndroid)
        ? CircularProgressIndicator()
        : CupertinoActivityIndicator();
    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}
