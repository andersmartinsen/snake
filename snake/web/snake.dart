import 'dart:html';
import 'dart:math';
import 'dart:async';

void main() {
  CanvasElement canvas = querySelector("#canvas");
  Board board = new Board(canvas);
  board.init();
}

class Snake {
  Board board;
  int x, y, r;
  int dx = 2;
  int dy = 4;
  bool rightDown = false;
  bool leftDown = false;
    
  Snake(this.board, this.x, this.y, this.r) {
    draw();
    document.onKeyDown.listen(_onKeyDown);
    document.onKeyUp.listen(_onKeyUp);
   }
  
  void draw() {
    if (rightDown) {
       x += dx;
       y -= dy;
    } else if (leftDown) {
       x -= dx;
       y -= dy;
    }

    board.context.beginPath();
    board.context.arc(x, y, r, 0, PI*2, true);
    board.context.closePath();
    board.context.fill();    
  }
  
  _onKeyDown(event) {
    if (event.keyCode == 39) { 
      rightDown = true;
    } else if (event.keyCode == 37) {
      leftDown = true;
    }
  }
  
  _onKeyUp(event) {
    if (event.keyCode == 39) {
      rightDown = false;
    } else if (event.keyCode == 37) {
      leftDown = false;
    }
  }
  
  void move() {
      board.clear();
      draw();
  }
}

class Board {
    CanvasRenderingContext2D context;
    int width, height;
    
    void init() {
      Snake snake = new Snake(this, 0, 300, 10); 
      new Timer.periodic(const Duration(milliseconds: 50),
                 (t) => snake.move());
    }
    
    Board(CanvasElement canvas) {
      context = canvas.getContext('2d');
      width = canvas.width;
      height = canvas.height;
    }
    
    void clear() {
        context.clearRect(0, 0, width, height);     
    }
}