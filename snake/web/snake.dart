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
  
  Snake(this.board, this.x, this.y, this.r) {
    draw();
  }
  
  void draw() {
    board.context.beginPath();
    board.context.arc(x, y, r, 0, PI*2, true);
    board.context.closePath();
    board.context.fill();    
  }
  
  void move() {
      board.clear();
      draw();
      x += dx;
      y += dy;
  }
}

class Board {
    CanvasRenderingContext2D context;
    int width, height;
    
    void init() {
      Snake snake = new Snake(this, 0, 0, 10); 
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