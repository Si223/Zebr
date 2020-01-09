class GomokuStatus {
  int nowPlayer;

  int winPlayer;

  int type;

  bool lock;

  final List typeList = [
    '',
    'Player vs AI',
    'Player vs Player',
  ];
  GomokuStatus(this.nowPlayer, this.winPlayer, this.type, this.lock);
}
