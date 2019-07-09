PShape paddle, ball;
float paddleWidth, paddleHeight, x, y, ballx, bally, velx, vely;

/* 
    Set up the application
    - set the size of the window
    - create the paddle
    - create the ball
*/
void setup() {
  size(800,450);
  createRectangle();
  createBall();
}

/* 
    Continuously draw each shape
    - Fill in the background
    - Draw the paddle and the ball
    - move the ball and check for collisions
*/
void draw() {
  background(255);
  shape(paddle);
  shape(ball);
  moveBall();
  if(mousePressed) trackMouse();
  
  if(vely > 0 && vely < 15) vely += .005;
  else if(vely < 0 && vely > -15) vely -= .005;
}

/* 
    Check for conditions when a key is pressed
    - if the right arrow key or the 'd' key are pressed, move the paddle to the right
    - if the left arrow key or the 'a' key are pressed, move the paddle to the left
*/
void keyPressed() {
  if((keyCode == RIGHT || key == 'd') && x + paddleWidth < width) {
    paddle.translate(10,0);
    x += 10;
  }
  else if((keyCode == LEFT || key == 'a') && x > 0) {
    paddle.translate(-10,0);
    x -= 10;
  }
}

// Create a rectangle 50 pixels from the bottom of the window, in the center
void createRectangle() {
  paddleWidth = 100;
  paddleHeight = 25;
  y = height - 50;
  x = (width / 2) - paddleWidth / 2;
  fill(0);
  paddle = createShape(RECT, x, y, paddleWidth, paddleHeight);
}

// Create a ball that sits on top of the paddle initially, and has a random initial velocity
void createBall() {
  ballx = width / 2;
  bally = height - 75;
  vely = -3;
  while(velx < 2 && velx > -2) velx = random(-5, 5);
  fill(0, 0, 255);
  ball = createShape(ELLIPSE, ballx, bally, 10, 10);
}

// Check if the ball is currently colliding with an edge, paddle, or brick and move it accordingly
void moveBall() {
  // If the ball hit one of the edges on the top or bottom, flip the y velocity
  if(bally >= height || bally <= 0) vely *= -1;
  // If the ball hit one of the edges on the left or right, flip the x velocity
  if(ballx >= width || ballx <= 0) velx *= -1;
  
  // if the ball hits the top of the paddle, flip the y velocity
  if((bally <= y + (vely/2) && bally >= y - (vely/2) || bally >= y + paddleHeight + (vely/2) && bally <= y + paddleHeight - (vely/2)) 
      && ballx > x && ballx < x + paddleWidth) {
    vely *= -1;
  }
  // if the ball hits the side of the paddle, flip the x velocity
  if((ballx <= x + (velx/2) && ballx >= x - (velx/2) || ballx >= x + paddleWidth + (velx/2) && ballx <= x + paddleWidth - (velx/2)) 
      && bally > y && bally < y + paddleHeight) {
    velx *= -1;
  }
  
  // Move the ball in the direction of each velocity
  ball.translate(velx, vely);
  ballx += velx;
  bally += vely;
}

void trackMouse() {
  if(mouseX - (paddleWidth/2) > 0 && mouseX + (paddleWidth/2) < width) {
    println("HERE");
    paddle.translate(mouseX - (paddleWidth/2) - x, 0);
    x = mouseX - (paddleWidth/2);
  }
}
