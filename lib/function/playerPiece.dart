import 'package:flutter/material.dart';

playerPiece(List<List<int>> checkerboard, Offset offset, double height,
    double titlePadding, Size screenSize) {
  Offset position =
      Offset(offset.dx, offset.dy - (height * 0.2 + titlePadding));
  print(position);

  final int rows = checkerboard.length;
  final int columns = checkerboard[0].length;

  final double realHeight = height * 0.7;
  final posX = realHeight / rows;
  final posY = screenSize.width / columns;

  final cX = (((((position.dy - posX / 2) * 10)) / (realHeight - posX)) *
          ((rows - 1) / 10))
      .round();
  final cY =
      (((((position.dx - posY / 2) * 10) / (screenSize.width - posY))) *
              ((columns - 1) / 10))
          .round();
  return [cX, cY];
}
