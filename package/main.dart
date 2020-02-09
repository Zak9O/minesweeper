import 'point.dart';
import 'screen.dart';

void main() {
  Screen screen = Screen.createScreen(width: 4, height: 4, mines: [
    Point(x: 0, y: 0, isBomb: true),
    Point(x: 2, y: 0, isBomb: true),
    Point(x: 1, y: 1, isBomb: true),
    Point(x: 2, y: 2, isBomb: true),
    Point(x: 3, y: 3, isBomb: true),
  ]);
  screen.calculateAdjacentBombs();
  screen.drawScreen();

  screen.selectBomb(0, 3);
  screen.selectBomb(0, 1);
  screen.selectBomb(1, 1);
  //screen.selectBomb(1, 0);
  //screen.selectBomb(2, 1);

}
