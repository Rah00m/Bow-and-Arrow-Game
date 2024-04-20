//balloon level1

class Balloon1 {
  float x; // X position of the balloon
  float y; // Y position of the balloon
  color c; // Color of the balloon
  float speed; // Speed of the balloon
  float acceleration; // Acceleration of the balloon

  Balloon1(float x, float y, color c) {
    this.x = x * 15;
    this.y = y * 15;
    this.c = c;
    this.speed = random(400, 600); 
    this.acceleration = 500.0;
  }

  void update() {
    // Update balloon position
    y += speed*5500;
    speed += acceleration;
  }
}
