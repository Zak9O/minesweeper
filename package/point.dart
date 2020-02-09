
/*
A class which represents a point in the coordinates system
 */
class Point{

  Point({this.x, this.y, this.isBomb});

  final int x; //The x-coordinate of the bomb
  final int y; //The y-coordinate of the bomb
  final bool isBomb;  //If true the point is a bomb

  int adjacentBombs = 0;  //Number of adjacent bombs
  bool isSelected = false;  //If isSelected draw the adjacentBombs attribute

  //A function that returns what to draw as the point
  String drawPoint(){
    if (isSelected){
      if (isBomb){
        return 'M';
      } else if (adjacentBombs != 0){
        return adjacentBombs.toString();
      } else {
        return ' ';
      }
    }

    return '*';

    if(isBomb){
      return 'M';
    } else if (adjacentBombs != 0){
      return adjacentBombs.toString();
    }
    return '*';
  }

  @override
  String toString() {
    return 'Point{x: $x, y: $y, isBomb: $isBomb, adjacentBombs: $adjacentBombs}';
  }
}