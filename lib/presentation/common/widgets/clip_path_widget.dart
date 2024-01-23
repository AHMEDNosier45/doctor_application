import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';

class ClipPathWidget extends StatelessWidget {
  final Widget? widget;
  final double height;
  final bool isDown;

  const ClipPathWidget(
      {Key? key, this.widget, required this.height, required this.isDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: isDown ? Clipper() : CustomClipPath(),
          child: Container(
            width: size.width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorManager.primary, ColorManager.darkPrimary2]),
            ),
            child:  widget ?? const SizedBox(),
          ),
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 80, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height *.6);
    path.quadraticBezierTo(
        size.width * .5, size.height, size.width, size.height * .6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
