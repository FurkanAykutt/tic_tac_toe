class Game {
  final int id;
  final String code;
  final int player;
  final String status;
  final String boardColor;
  final String gameName;

  int get secondPlayer => player == 1 ? 2 : 1;

  Game(this.id, this.code, this.player, this.status, this.boardColor,
      this.gameName);
}
