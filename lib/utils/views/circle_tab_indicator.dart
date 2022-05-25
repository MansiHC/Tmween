import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({double width = 20, double height = 10})
      : _painter = _CirclePainter(width,height);

  @override
  BoxPainter createBoxPainter([ VoidCallback? onChanged]) {
    return _painter;
  }

}

class _CirclePainter extends BoxPainter {
  final Paint _paint;

  final double width;
  final double height;

  _CirclePainter(this.width, this.height)
      : _paint = Paint()
    ..color = Colors.white
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Path _trianglePath = Path();
    if (cfg.size != null){

      Offset centerTop = Offset(cfg.size!.width / 2, cfg.size!.height - height) + offset;
      Offset bottomLeft = Offset(cfg.size!.width / 2 - (width/2), cfg.size!.height) + offset;
      Offset bottomRight = Offset(cfg.size!.width / 2 + (width/2), cfg.size!.height) + offset;

      _trianglePath.moveTo(bottomLeft.dx, bottomLeft.dy);
      _trianglePath.lineTo(bottomRight.dx, bottomRight.dy);
      _trianglePath.lineTo(centerTop.dx, centerTop.dy);
      _trianglePath.lineTo(bottomLeft.dx, bottomLeft.dy);

      _trianglePath.close();
      canvas.drawPath(_trianglePath, _paint);
    }
  }
}

class MessageClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {

    var firstOffset = Offset(size.width * 0.1, 0.0);
    var secondPoint = Offset(size.width * 0.15, size.height );
    var lastPoint = Offset(size.width * 0.2, 0.0);
    var path = Path()
      ..moveTo(firstOffset.dx, firstOffset.dy)
      ..lineTo(secondPoint.dx, secondPoint.dy)
      ..lineTo(lastPoint.dx, lastPoint.dy)
      ..close();


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return true;
  }

}
