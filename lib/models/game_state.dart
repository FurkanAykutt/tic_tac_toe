import 'game_status.dart';

class GameState {
  final GameStatus status;
  final List<int> board;
  final int lastPlayed;
  final int? winner;

  String getSquareLabel(int index) {
    final value = board[index];
    if (value == 1) {
      return 'X';
    }
    if (value == 2) {
      return 'O';
    }
    return '';
  }

  GameState(this.status, this.board, this.lastPlayed, this.winner);
}
