import 'package:flutter/material.dart';

Widget figureStick(bool visible, String path) {
  return Visibility(
      visible: visible,
      child: SizedBox(
        width: 500,
        height: 300,
        child: Image.asset(path),
      ));
}
