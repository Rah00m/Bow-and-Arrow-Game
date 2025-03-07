
//********************************************************************************************************************************//

class Level2 {
  int score1; // Variable to store the score from Level 1



  void setup(int score1) {
    this.score1 = score1; // Store the score from Level 1
    isFiring = false;
    startposition = true;
    nOFshotsBallons = 0;
    shotsArrows = 0;
    ammoCount = 20;
    balloon2();
  } 
  //  totalScore = score1; // Set totalScore to score1 from Level 1
  void balloon2() {
    redCircleColor = color(255, 0, 0);
    yellowCircleColor = color(255, 255, 0);
    circles = new Circle[numRedCircles + numYellowCircles];
    for (int i = 0; i < numRedCircles; i++) {
      float x = random(width/2, width - circleRadius); // Balloons only move on the right half of the window
      float y = random(height);
      // Check for collisions with existing red balloons
      boolean collided = false;
      for (int j = 0; j < i; j++) {
        if (dist(x, y, circles[j].x, circles[j].y) < circleRadius * 2) {
          collided = true;
          break;
        }
      }
      if (collided) {
        i--; // Retry creating the balloon
      } else {
        Circle circle = new RedCircle(x, y, redCircleSpeed, redCircleColor);
        circles[i] = circle;
      }
    }
    for (int i = numRedCircles; i < numRedCircles + numYellowCircles; i++) {
      float x = random(width/2, width - circleRadius); // Balloons only move on the right half of the window
      float y = random(height);
      Circle circle = new YellowCircle(x, y, yellowCircleSpeed, yellowCircleColor);
      circles[i] = circle;
    }
  }

  //********************************************************************************************************************************//
  void draw() {
    if (nOFshotsBallons != 12 && ammoCount == 0 && arrows.size() == 0) {
      gameOver = true;
    }
    if (gameOver) {
      arrows.clear();
      normal_mode2 = false;
      background(0);
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      textSize(100);
      totalScore=this.score1;
      text("Game Over :-(", width/2, height/2);

      fill(255);
      textSize(50);
      text("Total Score: " + score1, width/2, height/2 + 100);
      arrows.clear();
      totalScore = score1;
      position1 = loadImage("p11.png");
      position2 = loadImage("p11.png");
      // Draw the button based on its state
      if (isButtonPressed) { 
        image(buttonPressed, buttonX, buttonY);
      } else { 
        image(buttonIdle, buttonX, buttonY);
      }
    }
    if (ammoCount >= 0 && nOFshotsBallons == 12 && arrows.size() == 0) {
      normal_mode2 = false;
      background(0); // Set background color 
      textAlign(CENTER, CENTER); // Align text to center
      textSize(64); // Set text size to 32 pixels
      fill(0, 255, 0); // Set text color to green
      text("You win :D", width/2, height/2); // Display "You win" in the middle of the screen

      arrows.clear();
      position1 = loadImage("p11.png");
      position2 = loadImage("p11.png");
      // Calculate score2 and update totalScore
      remainingArrows = 20 - shotsArrows;
      score2 = (remainingArrows + 1) * nOFshotsBallons;
      totalScore = this.score1 + score2; // Update totalScore by adding score2
      fill(255);
      textSize(50);
      text("Total Score: " + totalScore, width/2, height/2 + 100);
      if (isButtonPressed) { 
        image(buttonPressed, buttonX, buttonY);
      } else { 
        image(buttonIdle, buttonX, buttonY);
      }
    }

    if (normal_mode2) {
      position1 = loadImage("p1.png");
      position2 = loadImage("p2.png");
      background.resize(1000, 600);
      background(background);

      if (isButtonPressed) { 
        image(buttonPressed, buttonX, buttonY);
      } else { 
        image(buttonIdle, buttonX, buttonY);
      }
      fill(139, 69, 19);
      textSize(60);
      text("Level 2", 450, 50);
      fill(139, 69, 19);
      textSize(20);
      text("Arrow: " + ammoCount, 650, 30);
      text("ShotsArrows " + shotsArrows, 800, 60);
      text("Shots Ballons " + nOFshotsBallons, 800, 30);
      // Calculate score2 and update totalScore
      remainingArrows = 20 - shotsArrows;
      score2 = (remainingArrows + 1) * nOFshotsBallons;
      totalScore = this.score1 + score2; // Update totalScore by adding score2
      // Display score and totalScore
      fill(139, 69, 19);
      textSize(32);
      text("Score: " + score2, 200, 30);
      //  text("Total Score: " + totalScore, width/2, height/2 + 100);
      if (isReloading) {
        reloadTimer++;
        if (reloadTimer >= reloadTime) {
          isReloading = false; // Reset the reloading flag
          reloadTimer = 0; // Reset the reload timer
        }
      }

      // Update and draw all the circles
      for (int i = 0; i < circles.length; i++) {
        Circle circle = circles[i];
        circle.update();
        circle.display();
        // Check for collision with bullets
        for (int j = arrows.size() - 1; j >= 0; j--) {
          Arrow arrow = arrows.get(j);
          if (circle instanceof RedCircle && circle.isColliding(arrow)) {
            // Remove the circle
            circles[i] = null;
            nOFshotsBallons++; // Increment the count of shot balloons
            break; // Exit the inner loop since the circle has been hit
          }
          if (circle instanceof YellowCircle && circle.isColliding(arrow)) {
            circles[i] = null;
            // Set game over state
            gameOver = true;
            shootingEnabled = false; // Disable shooting when the game is over
            break; 
          }
        }
      }

      // Remove null circles (hit red circles) from the array
      int newSize = 0;
      for (int i = 0; i < circles.length; i++) {
        if (circles[i] != null) {
          circles[newSize] = circles[i];
          newSize++;
        }
      }
      Circle[] filteredCircles = new Circle[newSize];
      System.arraycopy(circles, 0, filteredCircles, 0, newSize);
      circles = filteredCircles;
      // Update and draw all the arrows
      for (int i = arrows.size() - 1; i >= 0; i--) {
        Arrow arrow = arrows.get(i);
        arrow.update();
        arrow.display();

        // Check if the arrows is off-screen and remove it from the list
        if (arrow.isOffscreen()) {
          arrows.remove(i);
        }
      }
    }
  }
}
