class Level1 {
  int winTimer;
  
  
  void setup() {
    nOFshotsBallons=0;
    totalScore = 0;
    shotsArrows=0;
    ammoCount=20;
    balloons = new ArrayList<Balloon1>(); // Initialize the balloon list
    nOFshotsBallons=0;
    for (int i = 0; i < imageCount; i++) {
      images[i] = loadImage("gg.png"); 
    }
  }
  //****************************************************************************************//
  void draw() {


    if (ammoCount == 0 && arrows.size()==0 &&nOFshotsBallons!=15) {  
      // Draw "Game Over" text in the middle
      background(0); 
      fill(255, 0, 0); 
      textAlign(CENTER, CENTER);
      textSize(64);
      text("Game Over :-(", width/2, height/2);
      normal_mode1=false;
      arrows.clear();
      position1= loadImage("p11.png");
      // gameOver=true;
      if (isButtonPressed) { 
        image(buttonPressed, buttonX, buttonY);
      } else { 
        image(buttonIdle, buttonX, buttonY);
      }
    } else {
      // Draw the normal game background
      background(255);
      background.resize(1000, 600);
      background(background);
      if (isButtonPressed) { 
        image(buttonPressed, buttonX, buttonY);
      } else { 
        image(buttonIdle, buttonX, buttonY);
      }

      if (ammoCount >= 0 && nOFshotsBallons==15) {
        winTimer++;
        if (winTimer <= 50) {         // seconds (300 frames at 60 fps)
          // Draw "You win" message
          background(0);
          fill(0, 255, 0); 
          textAlign(CENTER, CENTER);
          textSize(64);
          totalScore = score1;
          text("You win :D", width / 2, height / 2);
          isFiring=true;
          startposition=false;
          win=true;
          arrows.clear();
          balloons.clear();
          if (isButtonPressed) {
            image(buttonPressed, buttonX, buttonY);
          } else {
            image(buttonIdle, buttonX, buttonY);
          }
        } else {
          win=false;
          Level1=false;
         level2.setup(score1); 
          Level2 = true;
        }
      }
    }

    if (normal_mode1) {
      position1= loadImage("p1.png");
      position2= loadImage("p2.png");
      // Display the ammo count
     fill(139, 69, 19);
      textSize(20);
      text("Arrow: " + ammoCount, 650, 30);
      text("ShotsArrows " +shotsArrows, 800, 60);
      text("Shots Balloons " + nOFshotsBallons, 800, 30);


      // Display score
      fill(139, 69, 19);
      textSize(32);
      remainingArrows = 20-shotsArrows;                  // Update the remaining arrows count
      score1 = (remainingArrows + 1) * nOFshotsBallons; // Calculate the score1 based on the provided formula
      text("Score: " + score1, 200, 30);


      textSize(60);
      text("Level 1", 450, 55);
      // Draw the images
      for (int i = 0; i < imageCount; i++) {
        if (images[i] != null) { 
          float imageX = width - ((imageWidth*1.5 + imageSpacing) * i + imageWidth*1.5);
          image(images[i], imageX, imageY, imageWidth*1.5, imageHeight*1.5);
        }
      }

      // Update and draw all the arrows
      for (int i = arrows.size() - 1; i >= 0; i--) {
        Arrow arrow = arrows.get(i);
        arrow.update();
        arrow.display();

        // Check if the arrow is off-screen and remove it from the list
        if (arrow.isOffscreen()) {
          arrows.remove(i);
        }
      }
      // Update and draw all the balloons
      for (int i = balloons.size() - 1; i >= 0; i--) {
        Balloon1 balloon = balloons.get(i);
        nOFshotsBallons=15-balloons.size();
        balloon.update();
      }
      // Move the images up
      imageY -= 1;
      // Repeat the animation
      if (imageY + imageHeight < 0) {
        imageY = height - imageHeight;
      }
    }
  }
}
