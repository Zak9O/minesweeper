import 'point.dart';
import 'screen.dart';
import 'dart:io';

void main() {
  Screen screen = Screen.createScreen(width: 6, height: 6, mines: [
    Point(x: 0, y: 0, isBomb: true),
    Point(x: 2, y: 0, isBomb: true),
    Point(x: 1, y: 1, isBomb: true),
    Point(x: 2, y: 2, isBomb: true),
    Point(x: 3, y: 3, isBomb: true),
  ]);
  screen.calculateAdjacentBombs();
  screen.drawScreen();

  bool playGame = true;

  while (playGame){
    String line = stdin.readLineSync();
    List<String> input = line.split(',');
    playGame = screen.selectBomb(int.parse(input[0]), int.parse(input[1]));
  }

}
