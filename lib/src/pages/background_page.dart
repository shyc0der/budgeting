import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ClipPath(
            clipper: Clipper1(),
            child: Container(
              height: 124,
              width: 144,
              color: const Color.fromRGBO(194, 72, 38, 1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipPath(
            clipper: Clipper2(),
            child: Container(
              height: 109,
              width: 144,
              color: const Color.fromRGBO(174, 72, 38, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0); // start form topRight
    path.lineTo(size.width, size.height); // draw line to bottom right
    path.quadraticBezierTo(
      size.width *.25 + size.width *.55, (size.height - size.height*.1), 
      size.width *.25, size.height); // draw small curvel to bottom left
    path.quadraticBezierTo(0, size.height, 0, size.height*.3); // drow curve to top left
    path.quadraticBezierTo(0, 0, size.width, 0); // drow curve to top right

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw true;
  }
  
}
class Clipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height*.05); // start form topRight
    path.lineTo(size.width, size.height); // draw line to bottom right
    path.quadraticBezierTo(
      size.width *.25 + size.width *.55, (size.height - size.height*.1), 
      size.width *.25, size.height); // draw small curvel to bottom left
    path.quadraticBezierTo(0, size.height, size.width *.02, size.height*.3); // drow curve to top left
    path.quadraticBezierTo(0, 0, size.width, 0); // drow curve to top right

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw true;
  }
  
}