import 'package:flutter/material.dart';
import 'dart:math';

class AuthBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Boshlanish nuqtasi (0, 0)
    path.lineTo(0, size.height);

    // 3-4 gradus qiya pastga chiziq
    double angleDegrees = 3;
    double angleRadians = angleDegrees * pi / 180;

    // Qiya pastdagi nuqta (x, y)
    double x = size.width;
    double y = size.height - tan(angleRadians) * size.width;

    path.lineTo(x, y);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
