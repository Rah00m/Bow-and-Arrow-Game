class Arrow {
  float x; // X position of the arrow
  float y; // Y position of the arrow
  float speed = 9; // Speed of the arrow
  float accelerationFactor = 15.0; // Acceleration factor when left button is pressed
  boolean isLeftButtonPressed = false; // Flag to track if left button is pressed
  float lastUpdateTime; // Last update time
  float accelerationTime = 0; // Time left button is pressed
  float maxAccelerationTime = 45.0; // Maximum time to apply acceleration

  Arrow(float x,
  float y) {
    this.x = x;
    this.y = y;
    this.lastUpdateTime = millis();
  }

  void display() {
    image(arrowImage, x, y);
  }

  boolean isOffscreen() {
    // Check if the arrow has reached the right edge of the screen
    return x > width;
  }

 void update() {
  // Calculate time difference
  float currentTime = millis();
  float deltaTime = (currentTime - lastUpdateTime) / 1000.0; // Convert milliseconds to seconds
  lastUpdateTime = currentTime;

  // Apply acceleration only if left button is pressed and acceleration time is within limit
  float acceleration = 1.0;
  if (isLeftButtonPressed && accelerationTime < maxAccelerationTime) {
    acceleration = accelerationFactor;
    accelerationTime += deltaTime;
  } else {
    accelerationTime = 0;
  }

  // Move the arrow horizontally with acceleration
  x += speed * acceleration;

  // Check for collisions with images
  for (int i = 0; i < imageCount; i++) {
    if (images[i] != null && x > width - ((imageWidth*1.5 + imageSpacing) * (i + 1)) &&
        x < width - ((imageWidth*1.5 + imageSpacing) * i) &&
        y + imageHeight / 2 > imageY && y + imageHeight / 2 < imageY + imageHeight) {

      // Remove the image
      images[i] = null;
      nOFshotsBallons++;
      break;
    }
  }
}
}
