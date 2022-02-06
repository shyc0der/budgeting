import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ClipPath(
              clipper: Clipper1(),
              child: Container(
                height: 124,
                width: 164,
                color: Colors.orange,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ClipPath(
              clipper: Clipper2(),
              child: Container(
                height: 124,
                width: 164,
                color: Colors.orange[400],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     height: 64,
          //     width: 154,
          //     color: Colors.orange[400],
          //   ),
          // ),
        ],
      ),
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
      size.width *.25 + size.width *.05, (size.height - size.height*.1), 
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
      size.width *.25 + size.width *.05, (size.height - size.height*.1), 
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