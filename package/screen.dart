import 'dart:io';

import 'point.dart';

class Screen {
  Screen({this.width, this.height, this.mines});

  Screen.createScreen({this.width, this.height, this.mines}) {
    createCoordinateSystem();
  }

  final int width; //The amount of x-coordinates as width
  final int height; //The amount of y-coordinates as height
  final List<Point> mines; //The coordinates of the mines
  List<Point> coordinateSystem = [];  //The list which hold every point
  List<Point> selectedPoints = [];    //A list that keeps track of how many bombs there have been selected

  //A function that creates every point in the coordinate system
  void createCoordinateSystem() {
    int drawnMines = 0; //Tracker of how many mines drawn. Is used as index
    //to get mine from minesCoordinates

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        //If the x and y coordinates is a mine add the mine to the coordinate system
        if (x == mines[drawnMines].x && y == mines[drawnMines].y) {
          coordinateSystem.add(mines[drawnMines]);
          drawnMines++;

          //Is a dummy functions that makes sure that index out of range error is not thrown
          if (drawnMines == mines.length) {
            drawnMines = 0;
          }

          continue;
        }
        //Else add a point to the coordinate system
        coordinateSystem.add(Point(
          x: x,
          y: y,
          isBomb: false,
        ));
      }
    }
    print(coordinateSystem);
    //print(coordinateSystem.length);
  }

  void drawScreen() {
    int pointPosition =
        0; //IndexTracker which are used to iterate through the coordinate system

    //Prints the first border wall
    print('+' + '-' * width + '+');

    for (int y = 0; y < height; y++) {
      stdout.write('|');

      for (pointPosition; coordinateSystem[pointPosition].y == y;) {
        stdout.write(coordinateSystem[pointPosition].drawPoint());

        //If block that Makes sure that pointPositions does not get out of range and cause an index error
        if (pointPosition == coordinateSystem.length - 1) {
          break;
        }
        pointPosition++;
      }
      //stdout.write("hej"); Use to print on same line
      print('|');
    }

    //prints the last border wall
    print('+' + '-' * width + '+');
  }

  //Function used to figure out how many bombs a point is adjacent to
  void calculateAdjacentBombs() {
    int mineIndex = 0; //index tracker

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        //With the help of these two loops i can loop through every bomb in mye coordinate system

        for (int tempY = -1; tempY < 2; tempY++) {
          for (int tempX = -1; tempX < 2; tempX++) {
            /*
            This variable sees if there is a point adjacent to the current bomb.
             */
            // ignore: omit_local_variable_types
            List<Point> potentialBomb = coordinateSystem.where((p) {
              if (p == coordinateSystem[mineIndex]) {
                return false;
              }
              if (p.x == coordinateSystem[mineIndex].x + tempX &&
                  p.y == coordinateSystem[mineIndex].y + tempY) {
                return true;
              }
              return false;
            }).toList();

            //If there is a point and that point is a bomb
            //Make the current bomb adjacentBomb attribute grow with 1
            if (potentialBomb.length == 1) {
              if (potentialBomb[0].isBomb) {
                coordinateSystem[mineIndex].adjacentBombs++;
              }
            }
          }
        }
        mineIndex++;
      }
    }
  }

  //If the selected point is a bomb
  //Return false and end game.
  bool selectBomb(int x, int y) {
    //Gets the selected mine from the coordinate system
    // ignore: omit_local_variable_types
    Point selectedPoint = coordinateSystem.where((p) {
      if (p.x == x && p.y == y){
        return true;
      }
      return false;
    }).toList()[0];

    //If the selectedPoint has not been selected before, add it to the score tracker
    if (!selectedPoint.isSelected){
      selectedPoints.add(selectedPoint);
    }

    selectedPoint.isSelected = true;

    if (selectedPoint.isBomb){
      print('You lost, it was a bomb');
      return false;
    } else if (selectedPoint.adjacentBombs == 0){
      //If the selected point has no adjacent points
      //Show all of the points adjent to the selected point
      int mineIndex = coordinateSystem.indexOf(selectedPoint);

      for (int tempY = -1; tempY < 2; tempY++) {
        for (int tempX = -1; tempX < 2; tempX++) {
          /*
            This variable sees if there is a point adjacent to the selected point.
             */
          // ignore: omit_local_variable_types
          List<Point> adjacentPoint = coordinateSystem.where((p) {
            if (p == coordinateSystem[mineIndex]) {
              return false;
            } else if (p.x == coordinateSystem[mineIndex].x + tempX &&
                p.y == coordinateSystem[mineIndex].y + tempY) {
              return true;
            }
            return false;
          }).toList();

          //If there was a match, select the bomb
          if (adjacentPoint.length == 1){
            //And add it to the selectedPoints
            if(!adjacentPoint[0].isSelected){
              selectedPoints.add(adjacentPoint[0]);
            }
            //Makes the adjacent point visible
            adjacentPoint[0].isSelected = true;
          }

        }
      }
    } else {
      selectedPoint.isSelected = true;
    }
    print("");
    drawScreen();

    //Checks if all the selectable points has been selected.
    //Is yes the game has been won
    if (selectedPoints.length == coordinateSystem.length - mines.length){
      print("\nYou won the game!");
      return false;
    }

    return true;
  }

}
