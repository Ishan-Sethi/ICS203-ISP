// Ishan Sethi //<>//
// 01/15/19
// Mr. Rosen
// ICS ISP: Towers of Hanoi

// Variable Decleration
int moveCounter; // Used for displaying moves
int[][] towerArray = new int[3][5]; // Holds values of position of the towers

// Tower Positions:
// X Positon
float xTowerLeftPos = 200;    // Tower 1
float xTowerMiddlePos = 400;  // Tower 2
float xTowerRightPos = 600;   // Tower 3

// Y Positon
float yTowerTopPos = 200;     // Top
float yTowerMiddlePos = 250;  // Middle
float yTowerBottomPos = 300;  // Bottom
float yTower4thPos = 350;     // 4th (Hard)

// Blocks:
// Small Block
float xSmallBlockPos = 400;
float ySmallBlockPos = -25;

// Medium Block
float xMedBlockPos = 400;
float yMedBlockPos = -25;

// Large Block
float xLargeBlockPos = 400;
float yLargeBlockPos = -25;

// 4th Block
float xXLargeBlockPos = 400;
float yXLargeBlockPos = -25;

// Block Selector
int blockSelect;

// Level Selector
String levelSelector = "easy";
String stateSelector = "splash";
/* 
 Possible Game States:
 "menu" = main menu
 "game" = game
 "victory" = victory screen
 "instructions" = instructions
 "level" = level select
 
 Possible Levels:
 "easy" = easy
 "hard" = hard
 */

// Fonts
PFont titleFont;
PFont bodyFont;

// Random
int randomSmallX;
int randomMediumX;
int randomLargeX;
int randomXLargeX;

// Loading Screen
int loadingCounter;

void setup() {  
  size(800, 500);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);

  // Splash Screen
  if (stateSelector.equals("splash")) {
    splashScreen();
  }
  // Main Menu
  else if (stateSelector.equals("menu")) {
    mainMenu(); // Calling the main menu functionn
  }
  // Game
  else if (stateSelector.equals("game")) {
    display(); // Calling the display function
  }
  // Victory Screen
  else if (stateSelector.equals("victory")) {
    victoryScreen(); // Calling the victory screen
  }
  // Level Selector
  else if (stateSelector.equals("level")) {
    levelSelector();
  }
  // Instructions
  else if (stateSelector.equals("instructions")) {
    instructions();
  } 
  // Exit Screen
  else {
    goodBye();
  }

  // Debugging Area
  println("Tower Array:");
  println(towerArray[0][0] + "\t" + towerArray[1][0] + "\t" + towerArray[2][0]);
  println(towerArray[0][1] + "\t" + towerArray[1][1] + "\t" + towerArray[2][1]);
  println(towerArray[0][2] + "\t" + towerArray[1][2] + "\t" + towerArray[2][2]);
  println(towerArray[0][3] + "\t" + towerArray[1][3] + "\t" + towerArray[2][3]);
  println(towerArray[0][4] + "\t" + towerArray[1][4] + "\t" + towerArray[2][4]);
  println("\nY Coordinate of small block: " + ySmallBlockPos);
  println("X Coordinate of small block: " + xSmallBlockPos); 
  println("\nY Coordinate of medium block: " + yMedBlockPos);
  println("X Coordinate of medium block: " + xMedBlockPos);
  println("\nBlock Selection: " + blockSelect); 
  println("\nMove Counter: " + moveCounter);
  println("\nLevel: " + levelSelector);
  println("\nRandom X Large Position: " + randomXLargeX);
  println("\nRandom Large Position: " + randomLargeX);   
  if (mousePressed) {
    println(mouseX + ", " + mouseY);
    mousePressed = false;
  }

  /**/
}


void splashScreen() {
  // Animating the 4th block
  if (yXLargeBlockPos < 325) {
    yXLargeBlockPos+= 5;
  } 
  // Animating the large block
  else if (yLargeBlockPos < 275) {
    yLargeBlockPos+= 5;
  } 
  // Animating the medium block
  else if (yMedBlockPos < 225) {
    yMedBlockPos+= 5;
  }
  // Animating the small block
  else if (ySmallBlockPos < 175) {
    ySmallBlockPos+= 5;
  } 
  // Going to the menu
  else {
    stateSelector = "menu";
  }

  // Towers
  for (int x = 150; x <= width; x += 250) {
    stroke(0);
    strokeWeight(12);
    line(x, 75, x, height);
  }

  // Small Block
  noStroke();
  fill(255, 0, 0);
  rect(xSmallBlockPos, ySmallBlockPos, 250, 50, 15);

  // Medium Block
  fill(0, 255, 0);
  rect(xMedBlockPos, yMedBlockPos, 300, 50, 15);

  // Large Block
  fill(0, 0, 255);
  rect(xLargeBlockPos, yLargeBlockPos, 350, 50, 15);

  // 4th Block
  fill(255, 255, 0);
  rect(xXLargeBlockPos, yXLargeBlockPos, 400, 50, 15);

  // Ground
  fill(#A5A0A0);
  rect(400, 425, 800, 150);

  // Loading text
  textSize(64);
  fill(0);
  if (loadingCounter >= 60) 
    loadingCounter = 0;
  else if (loadingCounter >= 45) 
    text("Loading...", 400, 400);
  else if (loadingCounter >= 30) 
    text("Loading..", 400, 400);
  else if (loadingCounter >= 15) 
    text("Loading.", 400, 400);
  else 
    text("Loading", 400, 400);
  loadingCounter++;
}

void mainMenu() {
  // Resetting the positions, and move counter
  blockSelect = 0;
  moveCounter = 0;
  // Reseting values in the array
  for (int x = 0; x <= 2; x++) {
    for (int i = 0; i <= 4; i++) {
      towerArray[x][i] = 5;
    }
  }

  // Depending on the difficulty will set values of the blocks
  // Easy
  if (levelSelector.equals("easy")) {
    towerArray[0][1] = 1; 
    towerArray[0][2] = 2; 
    towerArray[0][3] = 3;
    towerArray[0][4] = 5;
  } 

  // Hard
  else if (levelSelector.equals("hard")) {
    towerArray[0][1] = 1; 
    towerArray[0][2] = 2; 
    towerArray[0][3] = 3;
    towerArray[0][4] = 4;
  } 

  // Random
  else {
    // Randomizing the columns
    randomSmallX = int(random(0, 3));
    randomMediumX = int(random(0, 3));
    randomLargeX = int(random(0, 3));
    randomXLargeX = int(random(0, 3));

    // Setting the large block to a random column on the bottom floor
    towerArray[randomXLargeX][4] = 4;

    // If the 4th row is empty of the random column set the large block to the 4th level
    if (towerArray[randomLargeX][4] == 5) {
      towerArray[randomLargeX][4] = 3;
    }     
    // Else, if the 4th row is occupied, set the large block to the bottom level 
    else {
      towerArray[randomLargeX][3] = 3;
    }

    // If the 4th row is empty of the random column set the medium block to the 4th level
    if (towerArray[randomMediumX][4] == 5) {
      towerArray[randomMediumX][4] = 2;
    } 
    // Else, if the 4th row is occupied, set the medium block to the bottom level 
    else if (towerArray[randomMediumX][3] == 5) {
      towerArray[randomMediumX][3] = 2;
    } 
    // Else, set the set the medium block to the middle level 
    else {
      towerArray[randomMediumX][2] = 2;
    }

    // If the 4th row is empty of the random column set the small block to the 4th level
    if (towerArray[randomSmallX][4] == 5) {
      towerArray[randomSmallX][4] = 1;
    }
    // Else, if the 4th row is occupied, set the small block to the bottom level 
    else if (towerArray[randomSmallX][3] == 5) {
      towerArray[randomSmallX][3] = 1;
    }
    // Else, if the bottom row is occupied, set the small block to the bottom level 
    else if (towerArray[randomSmallX][2] == 5) {
      towerArray[randomSmallX][2] = 1;
    }
    // Else, set the set the small block to the middle level 
    else {
      towerArray[randomSmallX][1] = 1;
    }
  }

  // Towers
  for (int x = 150; x <= width; x += 250) {
    stroke(0);
    strokeWeight(12);
    line(x, 75, x, height);
  }

  // Ground
  noStroke(); 
  fill(#A5A0A0);
  rect(400, 425, 800, 150);

  // Title
  fill(0);
  textSize(64);
  text("Towers of Hanoi", 400, 30);

  // Play Game
  if (mouseX >= 275 && mouseX <= 525 && mouseY >= 150 && mouseY <= 200) {
    // Highlights the Block the mouse is hovered over
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      // Going to the Main Game screen
      stateSelector = "game";
      mousePressed = false;
    }
  }

  // Play Game Button
  fill(255, 0, 0);
  rect(400, 175, 250, 50, 15); 
  textSize(38);
  fill(0);
  text("Play Game", 400, 170); 
  noStroke();

  // Level Select
  if (mouseX >= 250 && mouseX <= 550 && mouseY >= 200 && mouseY <= 250) {
    // Highlights the Block the mouse is hovered over
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      // Going to the Level Select screen
      stateSelector = "level";
      mousePressed = false;
    }
  } 

  // Level Select Button
  fill(0, 255, 0);
  rect(400, 225, 300, 50, 15);
  textSize(38);
  fill (0);
  text("Level Select", 400, 220);
  noStroke();

  // Instructions
  if (mouseX >= 225 && mouseX <= 575 && mouseY >= 250 && mouseY <= 300) {
    // Highlights the Block the mouse is hovered over
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      // Going to the Instruction screen
      stateSelector = "instructions";
      mousePressed = false;
    }
  }

  // Instruction Button
  fill(0, 0, 255);
  rect(400, 275, 350, 50, 15);
  textSize(38);
  fill (0);
  text("Instructions", 400, 270);
  noStroke();

  // Exit
  if (mouseX >= 200 && mouseX <= 600 && mouseY >= 300 && mouseY <= 350) {
    // Highlights the Block the mouse is hovered over
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      // Going to the Exit screen
      stateSelector = "bye";
      mousePressed = false;
    }
  }

  // Exit Button
  fill(255, 255, 0);
  rect(400, 325, 400, 50, 15);
  textSize(38);
  fill (0);
  text("Exit", 400, 320);
  noStroke();
}

void levelSelector() {
  // Level Selector
  // Towers
  for (int x = 200; x <= 400; x += 200) {
    stroke(0);
    strokeWeight(12);
    line(x, 150, x, height);
    noStroke();
  }

  // Title
  textSize(64);
  fill(0);
  text("Level Selector", 400, 30);

  // Level
  textSize(40);
  text("Easy", 200, 100);
  text("Hard", 400, 100);
  text("Random", 600, 100);

  // Easy Selector
  if (mouseX >= 120 && mouseX <= 275 && mouseY >= 220 && mouseY <= 375) {
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      levelSelector = "easy";
      stateSelector = "menu";
      mousePressed = false;
    }
  }

  // Small Block
  fill(255, 0, 0);
  rect(200, yTowerMiddlePos, 100, 50, 15);

  // Medium Block
  fill(0, 255, 0);
  rect(200, yTowerBottomPos, 125, 50, 15);

  // Large Block
  fill(0, 0, 255);
  rect(200, yTower4thPos, 150, 50, 15);
  noStroke();

  // Hard Selector
  if (mouseX >= 305 && mouseX <= 490 && mouseY >= 170 && mouseY <= 375) {
    strokeWeight(4);
    stroke(0);
    if (mousePressed) {
      levelSelector = "hard";
      stateSelector = "menu";
      mousePressed = false;
    }
  }

  // Small Block
  fill(255, 0, 0);
  rect(400, yTowerTopPos, 100, 50, 15);

  // Medium Block
  fill(0, 255, 0);
  rect(400, yTowerMiddlePos, 125, 50, 15);

  // Large Block
  fill(0, 0, 255);
  rect(400, yTowerBottomPos, 150, 50, 15);

  // 4th Block
  fill(255, 255, 0);
  rect(400, yTower4thPos, 175, 50, 15);
  noStroke();

  // Random Selector
  if (mouseX >= 525 && mouseX <= 665 && mouseY >= 175 && mouseY <= 380) {
    fill(0);
    textSize(260);
    text("?", xTowerRightPos, yTowerMiddlePos);
    if (mousePressed) {
      levelSelector = "random";
      stateSelector = "menu";
      mousePressed = false;
    }
  }

  // Random Icon
  fill(0);
  textSize(250);
  text("?", xTowerRightPos, yTowerMiddlePos);

  // Ground
  noStroke(); 
  fill(#A5A0A0);
  rect(400, 450, 800, 150);
}

void instructions() { 
  // Title
  fill(0);
  textSize(64);
  text("Instructions", 400, 30);

  // Instructions
  textSize(20);
  text("The Towers of Hanoi is a mathematical problem with a very simple objective. " 
    + "There are 3 rods, with a certain amount of disks on the first rod (depending on difficulty). "
    + "Your objective it to move all the disks from the first rod, to the last with 2 simple rules: "
    + "Only one disk can be moved at a time. No larger disk may be placed on top of a smaller disk. "
    + "To move a block, click on it, then use the arrow keys to move it from tower to tower." 
    , 400, 160, 750, 560);

  // Graphic
  strokeWeight(6);
  stroke(0);
  line(400, 275, 400, 425);

  // Towers
  strokeWeight(4); 
  for (int x = 100; x <= 700; x += 100) {
    line(x, 300, x, 400);
  }

  // Large Block
  noStroke();
  fill(0, 0, 255);
  rect(100, 390, 75, 25, 15);

  // Medium Block
  fill(0, 255, 0);
  rect(100, 365, 55, 25, 15);

  // Small Block
  fill(255, 0, 0);
  rect(100, 340, 35, 25, 15);

  // Large Block 2
  noStroke();
  fill(0, 0, 255);
  rect(700, 390, 75, 25, 15);

  // Medium Block 2
  fill(0, 255, 0);
  rect(700, 365, 55, 25, 15);

  // Small Block 2
  fill(255, 0, 0);
  rect(700, 340, 35, 25, 15);

  // Return to menu
  textSize(30);
  fill(0);
  text("Click Anywhere to Return to the Menu", 400, 450);

  if (mousePressed) {
    stateSelector = "menu";
    mousePressed = false;
  }
}

void display() {
  // 3 Towers
  for (int x = 200; x <= 600; x += 200) {
    stroke(0);
    strokeWeight(12);
    line(x, 75, x, height);
  }

  // Ground:
  // Easy
  if (levelSelector.equals("easy")) {
    noStroke(); 
    fill(#A5A0A0);
    rect(400, 425, 800, 200);
  } 

  // Hard & Random
  else {
    noStroke(); 
    fill(#A5A0A0);
    rect(400, 450, 800, 150);
  }

  // Highlights the small block if selected
  if (blockSelect == 1) {
    strokeWeight(4);
    stroke(0);
  }

  // Small Block
  fill(255, 0, 0);
  rect(xSmallBlockPos, ySmallBlockPos, 100, 50, 15);
  noStroke();

  // Updates the position of the Block depending on the positions in the array:
  // Left Top
  if (towerArray[0][1] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerLeftPos, 0.25);
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerTopPos, 0.25);
  }

  // Left Middle
  else if (towerArray[0][2] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerLeftPos, 0.25);
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerMiddlePos, 0.25);
  }

  // Left  Bottom
  else if (towerArray[0][3] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerLeftPos, 0.25);
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerBottomPos, 0.25);
  }

  // Middle Top 
  else if (towerArray[1][1] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerMiddlePos, 0.25); 
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerTopPos, 0.25);
  }

  // Middle Middle
  else if (towerArray[1][2] == 1) {
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerMiddlePos, 0.25); 
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerMiddlePos, 0.25);
  }

  // Middle Bottom
  else if (towerArray[1][3] == 1) {
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerMiddlePos, 0.25); 
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerBottomPos, 0.25);
  } 

  // Right Top
  else if (towerArray[2][1] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerRightPos, 0.25); 
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerTopPos, 0.25);
  }

  // Right Middle
  else if (towerArray[2][2] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerRightPos, 0.25);
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerMiddlePos, 0.25);
  } 

  // Right Bottom
  else if (towerArray[2][3] == 1) { 
    xSmallBlockPos = lerp(xSmallBlockPos, xTowerRightPos, 0.25);
    ySmallBlockPos = lerp(ySmallBlockPos, yTowerBottomPos, 0.25);
  } 

  // Harder Difficulty
  else if (levelSelector.equals("hard") || levelSelector.equals("random")) {
    // Left 4th Row
    if (towerArray[0][4] == 1) {
      xSmallBlockPos = lerp(xSmallBlockPos, xTowerLeftPos, 0.25);
      ySmallBlockPos = lerp(ySmallBlockPos, yTower4thPos, 0.25);
    } 

    // Middle 4th Row
    else if (towerArray[1][4] == 1) {
      xSmallBlockPos = lerp(xSmallBlockPos, xTowerMiddlePos, 0.25); 
      ySmallBlockPos = lerp(ySmallBlockPos, yTower4thPos, 0.25);
    } 

    // Right 4th Row
    else if (towerArray[2][4] == 1) {
      xSmallBlockPos = lerp(xSmallBlockPos, xTowerRightPos, 0.25);
      ySmallBlockPos = lerp(ySmallBlockPos, yTower4thPos, 0.25);
    }
  }

  // Highlights the medium block if selected
  if (blockSelect == 2) {
    strokeWeight(4);
    stroke(0);
  }

  // Medium Block
  fill(0, 255, 0);
  rect(xMedBlockPos, yMedBlockPos, 125, 50, 15);
  noStroke();

  // Moves the block based on positions of the numbers in the Array
  // Left Middle
  if (towerArray[0][2] == 2) {
    xMedBlockPos = lerp(xMedBlockPos, xTowerLeftPos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerMiddlePos, 0.25);
  } 

  // Left Bottom
  else if (towerArray[0][3] == 2) { 
    xMedBlockPos = lerp(xMedBlockPos, xTowerLeftPos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerBottomPos, 0.25);
  }

  // Middle Middle
  else if (towerArray[1][2] == 2) { 
    xMedBlockPos = lerp(xMedBlockPos, xTowerMiddlePos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerMiddlePos, 0.25);
  } 

  // Middle Bottom
  else if (towerArray[1][3] == 2) { 
    xMedBlockPos = lerp(xMedBlockPos, xTowerMiddlePos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerBottomPos, 0.25);
  } 

  // Right Middle
  else if (towerArray[2][2] == 2) { 
    xMedBlockPos = lerp(xMedBlockPos, xTowerRightPos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerMiddlePos, 0.25);
  }

  // Right Bottom
  else if (towerArray[2][3] == 2) { 
    xMedBlockPos = lerp(xMedBlockPos, xTowerRightPos, 0.25);
    yMedBlockPos = lerp(yMedBlockPos, yTowerBottomPos, 0.25);
  }

  // If the hard level is selected (adding another layer)
  else if (levelSelector.equals("hard") || levelSelector.equals("random")) {
    // Left 4th Row
    if (towerArray[0][4] == 2) {
      xMedBlockPos = lerp(xMedBlockPos, xTowerLeftPos, 0.25);
      yMedBlockPos = lerp(yMedBlockPos, yTower4thPos, 0.25);
    } 

    // Middle 4th Row
    else if (towerArray[1][4] == 2) {
      xMedBlockPos = lerp(xMedBlockPos, xTowerMiddlePos, 0.25);
      yMedBlockPos = lerp(yMedBlockPos, yTower4thPos, 0.25);
    } 

    // Right 4th Row
    else if (towerArray[2][4] == 2) {
      xMedBlockPos = lerp(xMedBlockPos, xTowerRightPos, 0.25);
      yMedBlockPos = lerp(yMedBlockPos, yTower4thPos, 0.25);
    }
  }

  // Highlights the large block if selected
  if (blockSelect == 3) {
    strokeWeight(4);
    stroke(0);
  }

  // Large Block
  fill(0, 0, 255);
  rect(xLargeBlockPos, yLargeBlockPos, 150, 50, 15);
  noStroke();

  // Moves the block based on positions of the numbers in the Array
  // Left Bottom
  if (towerArray[0][3] == 3) { 
    xLargeBlockPos = lerp(xLargeBlockPos, xTowerLeftPos, 0.25);
    yLargeBlockPos = lerp(yLargeBlockPos, yTowerBottomPos, 0.25);
  } 

  // Middle Bottom
  else if (towerArray[1][3] == 3) {
    xLargeBlockPos = lerp(xLargeBlockPos, xTowerMiddlePos, 0.25);
    yLargeBlockPos = lerp(yLargeBlockPos, yTowerBottomPos, 0.25);
  }  

  // Right Bottom
  else if (towerArray[2][3] == 3) {
    xLargeBlockPos = lerp(xLargeBlockPos, xTowerRightPos, 0.25);
    yLargeBlockPos = lerp(yLargeBlockPos, yTowerBottomPos, 0.25);
  } 

  // Higher Difficulty
  else if (levelSelector.equals("hard") || levelSelector.equals("random")) {
    // Left 4th Row
    if (towerArray[0][4] == 3) {
      xLargeBlockPos = lerp(xLargeBlockPos, xTowerLeftPos, 0.25);
      yLargeBlockPos = lerp(yLargeBlockPos, yTower4thPos, 0.25);
    } 

    // Middle 4th Row
    else if (towerArray[1][4] == 3) {
      xLargeBlockPos = lerp(xLargeBlockPos, xTowerMiddlePos, 0.25);
      yLargeBlockPos = lerp(yLargeBlockPos, yTower4thPos, 0.25);
    } 

    // Right 4th Row
    else if (towerArray[2][4] == 3) {
      xLargeBlockPos = lerp(xLargeBlockPos, xTowerRightPos, 0.25);
      yLargeBlockPos = lerp(yLargeBlockPos, yTower4thPos, 0.25);
    }
  }

  // Higher Difficulty
  if (levelSelector.equals("hard") || levelSelector.equals("random")) {
    // Highlights the 4th block if selected
    if (blockSelect == 4) {
      strokeWeight(4);
      stroke(0);
    }

    // 4th Block
    fill(255, 255, 0);
    rect(xXLargeBlockPos, yXLargeBlockPos, 175, 50, 15);
    noStroke();

    // Moves the block based on positions of the numbers in the Array (only 3 possible positions :
    // Left 4th Row
    if (towerArray[0][4] == 4) { 
      xXLargeBlockPos = lerp(xXLargeBlockPos, xTowerLeftPos, 0.25);
      yXLargeBlockPos = lerp(yXLargeBlockPos, yTower4thPos, 0.25);
    } 

    // Middle 4th Row
    else if (towerArray[1][4] == 4) {
      xXLargeBlockPos = lerp(xXLargeBlockPos, xTowerMiddlePos, 0.25);
      yXLargeBlockPos = lerp(yXLargeBlockPos, yTower4thPos, 0.25);
    }  
    // Right 4th Row
    else if (towerArray[2][4] == 4) {
      xXLargeBlockPos = lerp(xXLargeBlockPos, xTowerRightPos, 0.25);
      yXLargeBlockPos = lerp(yXLargeBlockPos, yTower4thPos, 0.25);
    }
  }

  // Move display
  textSize(64);
  fill(0);
  text("Moves: " + moveCounter, 400, 400);

  // Exit Button
  stroke(0);
  strokeWeight(2);
  fill(255, 0, 0);
  rect(725, 50, 100, 40, 15); 

  // Text "Exit"
  fill(0);
  textSize(35);
  text("Exit", 725, 45);

  // Victory Screen  
  if (towerArray[2][1] == 1 && towerArray[2][2] == 2 && towerArray[2][3] == 3) {
    stateSelector = "victory";
  }

  // Calling user input
  userInput();
}
void userInput() {
  // If the mouse is pressed
  if (mousePressed == true) {
    // If the mouse is around the small block
    if (mouseX <= xSmallBlockPos + 50 && mouseX >= xSmallBlockPos - 50 && mouseY >= ySmallBlockPos - 25 && mouseY <= ySmallBlockPos + 25) {
      // Block 1 Selection
      blockSelect = 1;
    } 
    // If the mouse is around the medium block
    else if (mouseX <= xMedBlockPos + 75 && mouseX >= xMedBlockPos - 75 && mouseY >= yMedBlockPos - 25 && mouseY <= yMedBlockPos + 25) {
      // Block 2 Selection
      blockSelect = 2;
    } 
    // If the mouse is around the large block
    else if (mouseX <= xLargeBlockPos + 75 && mouseX >= xLargeBlockPos - 75 && mouseY >= yLargeBlockPos - 25 && mouseY <= yLargeBlockPos + 25) {
      // Block 3 Selection
      blockSelect = 3;
    } 
    // Block 4 Selection (harder difficulty)
    else if (mouseX <= xXLargeBlockPos + 75 && mouseX >= xXLargeBlockPos - 75 && mouseY >= yXLargeBlockPos - 25 && mouseY <= yXLargeBlockPos + 25 && (levelSelector.equals("hard") || levelSelector.equals("random"))) {
      blockSelect = 4;
    } 
    // Exit Button
    else if (mouseX <= 775 && mouseX >= 675 && mouseY >= 30 && mouseY <= 70) {        
      stateSelector = "menu";
    } 
    // 
    else {
      blockSelect = 0;
    }
  }

  // Moving the blocks
  if (keyPressed == true) {
    // If the first block is selected
    if (blockSelect == 1) {
      // If the right key is pressed
      if (keyCode == RIGHT) 
        moveRight(round(xSmallBlockPos / 200 - 1), round(ySmallBlockPos / 50 -3));

      // If the left key is pressed
      if (keyCode == LEFT) 
        moveLeft(round(xSmallBlockPos / 200 - 1), round(ySmallBlockPos / 50 - 3));
    } 
    // If the medium block is selected
    else if (blockSelect == 2) {
      // If the right key is pressed
      if (keyCode == RIGHT) 
        moveRight(round(xMedBlockPos / 200 - 1), round(yMedBlockPos / 50 - 3));

      // If the left key is pressed
      if (keyCode == LEFT) 
        moveLeft(round(xMedBlockPos / 200 - 1), round(yMedBlockPos / 50 - 3));
    } 
    // If the third block is selected
    else if (blockSelect == 3) {
      // If the right key is pressed
      if (keyCode == RIGHT) 
        moveRight(round(xLargeBlockPos / 200 - 1), round(yLargeBlockPos / 50 - 3));

      // If the left key is pressed
      if (keyCode == LEFT) 
        moveLeft(round(xLargeBlockPos / 200 - 1), round(yLargeBlockPos / 50 - 3));
    } 
    // 4th block (hard)
    else if ((levelSelector.equals("hard") || levelSelector.equals("random")) && blockSelect == 4) {
      // If the right key is pressed
      if (keyCode == LEFT) 
        moveLeft(round(xXLargeBlockPos / 200 - 1), round(yXLargeBlockPos / 50 -3));

      // If the left key is pressed
      if (keyCode == RIGHT) 
        moveRight(round(xXLargeBlockPos / 200 - 1), round(yXLargeBlockPos / 50 -3));
    }
    keyPressed = false;
  }
} 

void victoryScreen() { 
  // Calling the main game screen
  display();
  blockSelect = 0;

  // COngratulations text
  textSize(64);
  fill(0);
  text("Congratulations!", 400, 25);

  // Return to the main menu
  textSize(30);
  text("Click anywhere to return to the menu", 400, 460);
  if (mousePressed) {
    stateSelector = "menu";
    mousePressed = false;
  }

  // Covering up the exit button
  noStroke();
  fill(255);
  rect(725, 50, 120, 50, 15);
}

void moveLeft(int col, int row) {
  // Preventing the user from moving left in the left column
  if (col == 0) {
    return;
  }

  // Firsts checks if the row above is empty
  if (towerArray[col][row - 1] == 5) {
    // Then checks if the 1st row, and one coloumn left is either empty, or contains a bigger block
    if ((towerArray[col - 1][1] == 5  || towerArray[col - 1][1] > towerArray[col][row]) 
      // Then checks if the 2nd row, and one coloumn left is either empty, or contains a bigger block
      && (towerArray[col - 1][2] == 5 || towerArray[col - 1][2] > towerArray[col][row]) 
      // Lastly checks if the 3rd row, and one coloumn left is either empty, or contains a bigger block
      && (towerArray[col - 1][3] == 5 || towerArray[col - 1][3] > towerArray[col][row]) 
      // Then Checks if the harder difficulty is selected, and the 4th row is either empty, or contains a bigger block, or the mode is easy
      && (((levelSelector.equals("hard")  || levelSelector.equals("random")) && (towerArray[col - 1][4] == 5 || towerArray[col - 1][4] > towerArray[col][row])) || levelSelector.equals("easy"))) {

      // If the block can be moved to the 4th row (hard & random)
      if ((levelSelector.equals("hard")  || levelSelector.equals("random")) && towerArray[col - 1][4] == 5) {
        towerArray[col - 1][4] = blockSelect;
        towerArray[col][row] = 5;
        moveCounter++;
        return;
      }

      // Looping through the rest of the rows checking which row to place the block
      for (int x = 3; x >= 1; x--) {
        if (towerArray[col - 1][x] == 5) {
          towerArray[col - 1][x] = blockSelect;
          towerArray[col][row] = 5;
          moveCounter++;
          return;
        }
      }
    } 

    // Checks if the 1st row, and two coloumns left is either empty, or contains a bigger block
    else if ((towerArray[0][1] == 5  || towerArray[0][1] > towerArray[col][row]) 
      // Then checks if the 2nd row, and two coloumns left is either empty, or contains a bigger block
      && (towerArray[0][2] == 5 || towerArray[0][2] > towerArray[col][row]) 
      // Then checks if the 3rd row, and two coloumn left is either empty, or contains a bigger block and the block is in the 2nd coloumn
      && (towerArray[0][3] == 5 || towerArray[0][3] > towerArray[col][row]) && (col == 2)
      // Lastly Checks if the harder difficulty is selected, and the 4th row is either empty, or contains a bigger block, or the mode is easy
      && (((levelSelector.equals("hard")  || levelSelector.equals("random")) && (towerArray[0][4] == 5 || towerArray[0][4] > towerArray[col][row])) || levelSelector.equals("easy"))) {

      // If the block can be moved to the 4th row (hard & random)
      if ((levelSelector.equals("hard")  || levelSelector.equals("random")) && towerArray[0][4] == 5) {
        towerArray[0][4] = blockSelect;
        towerArray[col][row] = 5;
        moveCounter++;
        return;
      }

      // Looping through the rest of the rows checking which row to place the block
      for (int x = 3; x >= 1; x--) {
        if (towerArray[0][x] == 5) {
          towerArray[0][x] = blockSelect;
          towerArray[col][row] = 5;
          moveCounter++;
          return;
        }
      }
    }
  }
}

void moveRight(int col, int row) {
  // Preventing the user from moving right in the right column
  if (col == 2) {
    return;
  }
  // First checks if the row above is empty
  if (towerArray[col][row - 1] == 5) {
    // Then checks if the 1st row, and two coloumns right is either empty, or contains a bigger block
    if ((towerArray[col + 1][1] == 5 || towerArray[col + 1][1] > towerArray[col][row])
      // Then checks if the 2nd row, and two coloumns right is either empty, or contains a bigger block
      && (towerArray[col + 1][2] == 5 || towerArray[col + 1][2] > towerArray[col][row]) 
      // Then checks if the 3rd row, and two coloumns right is either empty, or contains a bigger block
      && (towerArray[col + 1][3] == 5 || towerArray[col + 1][3] > towerArray[col][row])
      // Lastly Checks if the harder difficulty is selected, and the 4th row is either empty, or contains a bigger block, or the mode is easy
      && (((levelSelector.equals("hard")  || levelSelector.equals("random")) && (towerArray[col + 1][4] == 5 || towerArray[col + 1][4] > towerArray[col][row])) || levelSelector.equals("easy"))) {

      // If the block can be moved to the 4th row (hard & random)
      if ((levelSelector.equals("hard") || levelSelector.equals("random")) && towerArray[col + 1][4] == 5) {
        towerArray[col + 1][4] = blockSelect;
        towerArray[col][row] = 5;
        moveCounter++;
        return;
      }

      // Looping through the rest of the rows checking which row to place the block
      for (int x = 3; x >= 1; x--) {
        if (towerArray[col + 1][x] == 5) {
          towerArray[col + 1][x] = blockSelect;
          towerArray[col][row] = 5;
          moveCounter++;
          return;
        }
      }
    } 

    // Checks if the 1st row, and two coloumns right is either empty, or contains a bigger block
    else if ((towerArray[2][1] == 5 || towerArray[2][1] > towerArray[col][row])
      // Then checks if the 2nd row, and two coloumns right is either empty, or contains a bigger block
      && (towerArray[2][2] == 5 || towerArray[2][2] > towerArray[col][row]) 
      // Then checks if the 3rd row, and two coloumns right is either empty, or contains a bigger block and the block is in the 1st coloumn
      && (towerArray[2][3] == 5 || towerArray[2][3] > towerArray[col][row]) && (col == 0)
      // Lastly Checks if the harder difficulty is selected, and the 4th row is either empty, or contains a bigger block, or the mode is easy
      && (((levelSelector.equals("hard") || levelSelector.equals("random")) && (towerArray[2][4] == 5 || towerArray[2][4] > towerArray[col][row])) || levelSelector.equals("easy"))) {

      // If the block can be moved to the 4th row (hard & random)
      if ((levelSelector.equals("hard") || levelSelector.equals("random")) && towerArray[2][4] == 5) {
        towerArray[2][4] = blockSelect;
        towerArray[col][row] = 5;
        moveCounter++;
        return;
      }

      // Looping through the rest of the rows checking which row to place the block
      for (int x = 3; x >= 1; x--) {
        if (towerArray[2][x] == 5) {
          towerArray[2][x] = blockSelect;
          towerArray[col][row] = 5;
          moveCounter++;
          return;
        }
      }
    }
  }
}

void goodBye() {
  // Exit Screen
  background(0);
  fill(255);
  textSize(50);
  text("Are you sure you want to exit?", 400, 40);
  text("Program made by: Ishan Sethi", 400, 440);

  // Yes or No option
  textSize(100);
  text("Yes", 225, 250);
  text("No", 575, 250);

  if (mousePressed) {
    // Exit
    if (mouseX >= 140 && mouseX <= 310 && mouseY >= 220 && mouseY <= 320) {
      exit();
    }
    // Return to menu
    if (mouseX >= 510 && mouseX <= 640 && mouseY >= 220 && mouseY <= 320) {
      stateSelector = "menu";
    }
  }
}
