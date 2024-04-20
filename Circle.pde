//balloon level2
//circle >>>>>>balloon
abstract class Circle {
  float x;
  float y;
  float speedY;
  int circleColor;

  Circle(float x, float y, float speedY, int circleColor) {
    this.x = x;
    this.y = y;
    this.speedY = speedY;
    this.circleColor = circleColor;
  }

  abstract void update();

  abstract void display();

  boolean isColliding(Arrow arrow) {
    float distance = dist(x, y, arrow.x, arrow.y);
    return distance < circleRadius;
  }
}

class RedCircle extends Circle {
  PImage redCircleImage;
  RedCircle(float x, float y, float speedY, int circleColor) {
    super(x, y, speedY, circleColor);
    redCircleImage = loadImage("gg.png");
  }

  void update() {
    y -= speedY; // Move vertically
    if (y < -circleRadius) {
      y = height + circleRadius;          // Wrap around vertically if off-screen
      x = random(width/2, width - circleRadius); // Balloons only move on the right half of the window
      // Check for collisions with existing red balloons
      for (int j = 0; j < circles.length; j++) {
        if (circles[j] instanceof RedCircle && circles[j] != this && dist(x, y, circles[j].x, circles[j].y) < circleRadius * 2) {
          y = circles[j].y + circleRadius * 2; // Move below the collided balloon
        }
      }
    }
  }

  void display() {
    image(redCircleImage, x - circleRadius, y - circleRadius, circleRadius * 2, circleRadius * 2);
  }
}

class YellowCircle extends Circle {
  PImage yellowCircleImage;

  YellowCircle(float x, float y, float speedY, int circleColor) {
    super(x, y, speedY, circleColor);
    yellowCircleImage = loadImage("tinywow_change_bg_photo_53303387.png");
  }

  void update() {
    y -= speedY; // Move vertically
    if (y < -circleRadius) {
      y = height + circleRadius; // Wrap around vertically if off-screen
      x = random(width/2, width - circleRadius); // Balloons only move on the right half of the window
    }
  }

  void display() {
    image(yellowCircleImage, x - circleRadius, y - circleRadius, circleRadius * 3, circleRadius * 3);
  }
}
