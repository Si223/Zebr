int checkOutcome(checkerboard, cX, cY) {
  final int piece = checkerboard[cX][cY];
  int pieceNum = 0;

  for (int i = 0; i < checkerboard[cX].length; i++) {
    if (checkerboard[cX][i] == piece)
      pieceNum++;
    else
      pieceNum = 0;
    if (pieceNum == 5) return piece;
  }

  for (int i = 0, pieceNum = 0; i < checkerboard.length; i++) {
    if (checkerboard[i][cY] == piece)
      pieceNum++;
    else
      pieceNum = 0;
    if (pieceNum == 5) return piece;
  }

  int diff = cX - cY;
  int sum = cX + cY;
  int qX = 0;
  int qY = 0;
  if (diff > 0) {
    qX = diff;
    qY = 0;
  } else {
    qX = 0;
    qY = -diff;
  }
  for (int i = 0, pieceNum = 0; i < 2 * checkerboard.length; i++) {
    if (qX + i >= checkerboard.length || qY + i >= checkerboard[0].length)
      break;
    if (checkerboard[qX + i][qY + i] == piece)
      pieceNum++;
    else
      pieceNum = 0;
    if (pieceNum == 5) return piece;
  }
  if (sum < checkerboard.length) {
    qX = sum;
    qY = 0;
  } else {
    qY = cY - (checkerboard.length - 1 - cX);
    qX = checkerboard.length - 1;
  }
  for (int i = 0, pieceNum = 0; i < 2 * checkerboard.length; i++) {
    if (qX - i < 0 || qY + i >= checkerboard[0].length) break;
    if (checkerboard[qX - i][qY + i] == piece)
      pieceNum++;
    else
      pieceNum = 0;
    if (pieceNum == 5) return piece;
  }
  return 0;
}
