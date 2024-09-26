import 'package:flutter/material.dart';
class ChatBubbleClipperSender extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 10, 0);
    path.lineTo(size.width, 10);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(size.width, size.height, size.width - 10, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 10);
    path.lineTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ChatBubbleClipperReceiver extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(10, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(size.width, size.height, size.width - 10, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 10);
    path.lineTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(0, 10);
    path.lineTo(0, size.height / 2);
    path.lineTo(-10, size.height / 2 + 5);
    path.lineTo(0, size.height / 2 + 10);
    path.lineTo(0, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
