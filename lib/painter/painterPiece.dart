import 'package:flutter/material.dart';

class PiecePainter extends CustomPainter {
  final List<List<int>> checkerboard;
  final Size screenSize;
  final double titlePadding;

  PiecePainter(this.checkerboard, this.screenSize, this.titlePadding);

  @override
  void paint(Canvas canvas, Size size) {
    final rows = checkerboard.length;
    final columns = checkerboard[0].length;
    final height = (screenSize.height - titlePadding) * 0.7;
    final posX = screenSize.width / columns / 2;
    final posY = height / rows / 2;

    Paint paint = Paint();

    for (var i = 0; i < rows; i += 1) {
      for (var j = 0; j < columns; j += 1) {
        if (checkerboard[i][j] != 0) {
          int piece = checkerboard[i][j];
          if (piece == 1) {
            paint.color = Colors.black;
          } else if (piece == 2) {
            paint.color = Colors.white;
          }
          canvas.drawCircle(
              Offset(posX + posX * 2 * j, posY + posY * 2 * i), 14, paint);
        }
      }
    }
  }

  bool shouldRepaint(PiecePainter oldDelegate) {
    return true;
  }

  bool shouldRebuildSemantics(PiecePainter oldDelegate) => true;
}
