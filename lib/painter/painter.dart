import 'package:flutter/material.dart';

class GomokuPainter extends CustomPainter {
  final List<List<int>> checkerboard;
  final Size screenSize;
  final double titlePadding;

  GomokuPainter(this.checkerboard, this.screenSize, this.titlePadding);

  @override
  void paint(Canvas canvas, Size size) {
    final int rows = checkerboard.length;
    final int columns = checkerboard[0].length;
    final height = (screenSize.height - titlePadding) * 0.7;
    final posX = screenSize.width / columns / 2;
    final posY = height / rows / 2;

    Paint paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 1;

    for (var i = 0; i < rows; i += 1) {
      canvas.drawLine(Offset(posX, posY + posY * 2 * i),
          Offset(screenSize.width - posX, posY + posY * 2 * i), paint);
    }

    for (var i = 0; i < columns; i += 1) {
      canvas.drawLine(Offset(posX + posX * 2 * i, posY),
          Offset(posX + posX * 2 * i, height - posY), paint);
    }

    canvas.drawCircle(
        Offset(posX + posX * 2 * (columns ~/ 2),
            posY + posY * 2 * (rows ~/ 2)),
        4,
        paint);
  }

  bool shouldRepaint(GomokuPainter oldDelegate) => false;

  bool shouldRebuildSemantics(GomokuPainter oldDelegate) => false;
}
