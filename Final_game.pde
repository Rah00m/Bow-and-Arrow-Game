int reloadTime; // Time taken to reload (in frames)
int reloadTimer; // Timer for reloading
int score1;
int score2;
int totalScore;
int imageWidth = 30;
int imageHeight = 50;
int imageSpacing = 2;
int imageY;
int nOFshotsBallons;
int shotsArrows;
int total_score;
int remainingArrows;
int ammoCount;
int arrowCount = 0; 
int imageCount = 15;
int numRedCircles = 12;
int numYellowCircles = 3;
int circleRadius = 40;
int redCircleColor;
int yellowCircleColor;
// Declare variables for button position and size
int buttonX = 10;
int buttonY = 10;
int buttonWidth = 70;
int buttonHeight = 60;
//Declare variables for player
float playerY;
float playerX;
float playerWidth; 
float playerHeight;
float startTime;
float redCircleSpeed = 4.5f;
float yellowCircleSpeed = 5.0f;  // Adjusted speed for yellow balloons
Circle[] circles;
boolean isDragging; // Flag to indicate if the player is being dragged
boolean isFiring; // Flag to indicate if the arrow is being fired
boolean gameOver = false;
boolean isReloading; // Flag to indicate if the player is reloading
boolean startposition;
boolean Level1;
boolean Level2;
boolean win=false;
import ddf.minim.*;
Minim minim;
AudioPlayer winSound;
AudioPlayer overSound;
boolean normal_mode1=true;
boolean normal_mode2=false;
boolean shootingEnabled = true;
boolean isButtonPressed = false;
// Declare variables to store button images
PImage buttonIdle;
PImage buttonPressed;
PImage background;
PImage[] images = new PImage[imageCount];
PImage position1;
PImage position2;
PImage[][] movement;
PImage arrowImage;
ArrayList<Arrow> arrows; // List to store the arrows
ArrayList<Balloon1> balloons; // List to store the balloons
Level1 level1;
Level2 level2;
//******************************************************************************************************************************//
void setup() {
 // minim = new Minim(this);
 // AudioPlayer player = minim.loadFile("play.mp3");
 // player.loop();
  // Adjusting the volume of the player sound
//player.setGain(0.0001); // Adjust the value as needed (e.g., 0.5 for half volume)
  //minim = new Minim(this);
  //winSound = minim.loadFile("winner.mp3");
   //minim = new Minim(this);
  //overSound = minim.loadFile("over.mp3");
  size(1000, 600);
  //Level1=false; 
  Level1=true;
  level1 = new Level1();
  level2 = new Level2();
  total_score=0;
  playerX = width / 80;
  playerY = height / 2; // Set the player's vertical position to the middle of the game window
  playerWidth = 146; // Set the player's width
  playerHeight = 190; // Set the player's height
  isDragging = false; // Initialize the dragging flag to false
  isFiring = false; // Initialize the firing flag to false
  ammoCount = 20; // Set the initial ammo count
  isReloading = false; // Initialize the reloading flag to false
  reloadTime = 60; // Set the reload time (in frames) to 60 (1 second)
  reloadTimer = 0; // Initialize the reload timer to 0
  startposition = true;
  imageY = height - imageHeight;
  arrows = new ArrayList<Arrow>(); // Initialize the arrow list
  balloons = new ArrayList<Balloon1>(); // Initialize the balloon list
  background = loadImage("simple-game-background.png");
  position1= loadImage("p1.png");
  position2= loadImage("p2.png");
  arrowImage=loadImage("arrows.png");

  // Load button images
  buttonIdle = loadImage("tinywow_change_bg_photo_53218826.png");
  buttonPressed = loadImage("tinywow_change_bg_photo_53219177.png");
  shotsArrows=0;
  remainingArrows= 20 -shotsArrows;
  
  level1.setup();
  level2.setup(score1);
}

//**************************************************************************************************************************//
void draw() {
  if ( Level1) {
    level1.draw();
    normal_mode1=true;
  } else if (Level2) {
    // level2.setup()
    level2.draw();
    normal_mode2=true;
  }

  if (isFiring && !startposition&&!win ) {
    image(position2, width / 16 - playerWidth / 2, playerY);
   
  } else if (!isFiring && startposition) {
    image(position2, width / 16 - playerWidth / 2, playerY);
  } else {
    if (!win) {
      image(position1, width / 16 - playerWidth / 2, playerY);
     
    }
  }
}
//**************************************************************************************************//
void mouseClicked() {
  if (Level1) {
    if (ammoCount > 0) {
      if (mouseButton == LEFT) {
        if (!isFiring && startposition && !isDragging) {
          // Take position 2 and fire arrow
          arrows.add(new Arrow(playerX, playerY + playerHeight / 2));
          playerY = constrain(playerY, 0, height - playerHeight);
          ammoCount--;
          shotsArrows++;
          remainingArrows = 20 - shotsArrows;
          isFiring = true;
    //  minim = new Minim(this);
 // AudioPlayer player = minim.loadFile("shoot.mp3");
 // player.play();
        } else if (isFiring && !startposition) {
          // Take position 1
          isFiring = false;
          playerY = constrain(playerY, 0, height - playerHeight);
        }
      } else if (mouseButton == RIGHT) {
        // Take position 2 without firing any arrows
        isFiring = false;
  //      minim = new Minim(this);
  //AudioPlayer player = minim.loadFile("reload.mp3");
  //player.play();
        startposition = true;
        playerY = constrain(playerY, 0, height - playerHeight);
      }
    }
  } else if (Level2) {
    if (ammoCount > 0) {
      if (mouseButton == LEFT) {
        if (!isFiring && startposition && !isDragging) {
          // Take position 2 and fire bullet
          arrows.add(new Arrow(playerX, playerY + playerHeight / 2));
          playerY = constrain(playerY, 0, height - playerHeight);
          ammoCount--;
          shotsArrows++;
          remainingArrows = 20 - shotsArrows;
          isFiring = true;
    //       minim = new Minim(this);
  //AudioPlayer player = minim.loadFile("shoot.mp3");
  //player.play();
        } else if (isFiring && !startposition) {
          // Take position 1
          isFiring = false;
          playerY = constrain(playerY, 0, height - playerHeight);
       
        }
      } else if (mouseButton == RIGHT) {
        // Take position 2 without firing any bullets
        isFiring = false;
        startposition = true;
        playerY = constrain(playerY, 0, height - playerHeight);
    //   minim = new Minim(this);
  //AudioPlayer player = minim.loadFile("reload.mp3");
  //player.play();
    }
    }
  }
}
//********************************************************************************************************************************************//
public void mouseDragged() {
  // If the dragging flag is true, update the player's vertical position based on the mouse's Y-coordinate
  if (isDragging) {
    playerY = mouseY - playerHeight / 2;
    playerY = constrain(playerY, 0, height - playerHeight); // Limit the player's Y position within the valid range
  }
}
//********************************************************************************************************************************************//
public void mousePressed() {
  if (Level1) {
    // Check if the left mouse button is pressed and if the mouse is within the player's bounds
    if (mouseButton == LEFT && mouseX > playerX && mouseX < playerX + playerWidth &&
      mouseY > playerY && mouseY < playerY + playerHeight) {
      isDragging = true; // Set the dragging flag to true
    }
    if (mouseButton == RIGHT) {
      // Check if the mouse is within the button boundaries
      if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight) {
        // Button is pressed
        isButtonPressed = true;
        restartGame();
      }
    }
  } else if (Level2) {
    //  Check if the left mouse button is pressed and if the mouse is within the player's bounds
    if (mouseButton == LEFT && mouseX > playerX && mouseX < playerX + playerWidth &&
      mouseY > playerY && mouseY < playerY + playerHeight) {
      isDragging = true; // Set the dragging flag to true

      // Shoot a bullet only if the maximum bullet count has not been reached and shooting is enabled
      if (ammoCount <= 20 && shootingEnabled) {
        Arrow arrow = new Arrow(width - 50, mouseY + 50); // Start the bullet at the center of the screen
        arrows.add(arrow);
      }
    }
    if (mouseButton == RIGHT) {
      // Check if the mouse is within the button boundaries
      if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight) {
        // Button is pressed
        isButtonPressed = true;
        replayGame();
      }
    }
  }
}
//***********************************************************************************************************************************************//
public void mouseReleased() {
  // Check if the left mouse button is released
  if (mouseButton == LEFT) {
    isDragging = false;   // Set the dragging flag to false
  }
}
//*****************************************************************************************************************//
void restartGame() {
  arrows.clear();
  nOFshotsBallons=0;
  score1=0;
  win=false;
  shotsArrows=0;
  ammoCount=20;
  level1.setup();
  level1.draw();
  isButtonPressed = false;
  gameOver = false;
}
void replayGame() {
  arrows.clear();
  level2.balloon2();
  level2.draw();
  nOFshotsBallons = 0;
  score2 = 0;
  shotsArrows = 0;
  ammoCount = 20;
  totalScore = score1; // Set totalScore to score1 from Level 1
  isButtonPressed = false;
  gameOver = false;
}

//****************************************************************************************************************//
