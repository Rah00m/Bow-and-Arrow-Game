//balloon level1

class Balloon1 {
  float x;
  float y; 
  color c; 
  float speed; 
  float acceleration; 
  Balloon1(float x, float y, color c) {
    this.x = x * 15;
    this.y = y * 15;
    this.c = c;
    this.speed = random(600, 1000); 
    this.acceleration = 5000.0;
  }

  void update() {
    // Update balloon position
    y += speed*5500;
    speed += acceleration;
  }
}
