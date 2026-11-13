/*
Adham Nawar
 Final Processing project
 3-Level Clicking Game
 */

int score = 0;
String gameState = "HOME";
PImage sonicClicker;

// Level and Timer variables
int currentLevel = 1;
int startTime = 0;
int totalTime = 15; // 15 seconds per level
int targetScore = 50;

void setup() {
  size(500, 500);
  sonicClicker = loadImage("sonicclicker.jpg");
}

void draw() {
  background(65, 105, 225);

  // Switch between screens based on the game state
  if (gameState.equals("HOME")) {
    drawHomeScreen();
  } else if (gameState.equals("PLAYING")) {
    drawGameScreen();
  } else if (gameState.equals("LEVELCOMPLETE")) {
    drawLevelCompleteScreen();
  } else if (gameState.equals("GAMEOVER")) {
    drawGameOverScreen();
  } else if (gameState.equals("VICTORY")) {
    drawVictoryScreen();
  }
}

void drawHomeScreen() {
  // Game Title
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Clicking Game", width / 2, 100);

  // Instructions
  textSize(16);
  text("Beat the target score in 15 seconds across 3 levels!", width / 2, 160);
  text("Level 1 Target: 50 | Level 2: 75 | Level 3: 100", width / 2, 195);

  // Start Button
  rectMode(CENTER);
  fill(255);
  rect(width / 2, height / 2 + 30, 200, 60, 10);

  fill(0);
  textSize(22);
  text("Start Game", width / 2, height / 2 + 30);

  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

// --- GAME SCREEN DESIGN ---
void drawGameScreen() {
  // Calculate remaining time
  int elapsedTime = (millis() - startTime) / 1000;
  int timeLeft = totalTime - elapsedTime;
  
  // Check win/loss conditions
  if (score >= targetScore) {
    if (currentLevel == 3) {
      gameState = "VICTORY";
    } else {
      gameState = "LEVELCOMPLETE";
    }
    return;
  }
  
  if (timeLeft <= 0) {
    gameState = "GAMEOVER";
    return;
  }

  // Gameplay button
  image(sonicClicker, 150, 150, 200, 200);

  // Score & Level display
  fill(255);
  textSize(18);
  text("Level: " + currentLevel, 10, 30);
  text("Score: " + score + " / " + targetScore, 10, 55);

  // Timer display
  textAlign(RIGHT, TOP);
  text("Time: " + timeLeft + "s", width - 10, 15);
  textAlign(LEFT, BASELINE);
}

// --- LEVEL COMPLETE SCREEN ---
void drawLevelCompleteScreen() {
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Level " + currentLevel + " Complete!", width / 2, 140);

  textSize(20);
  text("Get ready for Level " + (currentLevel + 1), width / 2, 200);

  // Next Level Button
  rectMode(CENTER);
  fill(255);
  rect(width / 2, 300, 200, 60, 10);

  fill(0);
  textSize(20);
  text("Next Level", width / 2, 300);

  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

// --- GAMEOVER SCREEN DESIGN ---
void drawGameOverScreen() {
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Time's Up!", width / 2, 140);

  textSize(22);
  text("Failed on Level " + currentLevel + " | Score: " + score, width / 2, 200);

  // Try Again Button
  rectMode(CENTER);
  fill(255);
  rect(width / 2, 300, 200, 60, 10);

  fill(0);
  textSize(20);
  text("Try Again", width / 2, 300);

  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

// --- VICTORY SCREEN DESIGN ---
void drawVictoryScreen() {
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("You Win!", width / 2, 140);

  textSize(22);
  text("You beat all 3 levels successfully!", width / 2, 200);

  // Play Again Button
  rectMode(CENTER);
  fill(255);
  rect(width / 2, 300, 200, 60, 10);

  fill(0);
  textSize(20);
  text("Play Again", width / 2, 300);

  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

void mousePressed() {
  if (gameState.equals("HOME")) {
    float btnX = width / 2;
    float btnY = height / 2 + 30;
    float btnW = 200;
    float btnH = 60;

    if (mouseX >= btnX - btnW/2 && mouseX <= btnX + btnW/2 &&
      mouseY >= btnY - btnH/2 && mouseY <= btnY + btnH/2) {
      // Initialize Level 1
      currentLevel = 1;
      score = 0;
      targetScore = 50;
      gameState = "PLAYING";
      startTime = millis();
      println("Game started at Level 1!");
    }
  } else if (gameState.equals("PLAYING")) {
    int minX = 150;
    int maxX = minX + 200;
    int minY = 150;
    int maxY = minY + 200;

    if (mouseX >= minX && mouseX <= maxX && mouseY >= minY && mouseY <= maxY) {
      score = score + 1;
    }
  } else if (gameState.equals("LEVELCOMPLETE")) {
    float btnX = width / 2;
    float btnY = 300;
    float btnW = 200;
    float btnH = 60;

    if (mouseX >= btnX - btnW/2 && mouseX <= btnX + btnW/2 &&
      mouseY >= btnY - btnH/2 && mouseY <= btnY + btnH/2) {
      // Advance to next level
      currentLevel = currentLevel + 1;
      score = 0; // Reset score for the new level
      
      if (currentLevel == 2) {
        targetScore = 75;
      } else if (currentLevel == 3) {
        targetScore = 100;
      }
      
      gameState = "PLAYING";
      startTime = millis(); // Reset timer for the new level
      println("Advanced to Level " + currentLevel);
    }
  } else if (gameState.equals("GAMEOVER")) {
    float btnX = width / 2;
    float btnY = 300;
    float btnW = 200;
    float btnH = 60;

    if (mouseX >= btnX - btnW/2 && mouseX <= btnX + btnW/2 &&
      mouseY >= btnY - btnH/2 && mouseY <= btnY + btnH/2) {
      // Restart back at Level 1
      currentLevel = 1;
      score = 0;
      targetScore = 50;
      gameState = "PLAYING";
      startTime = millis();
      println("Game restarted from Level 1!");
    }
  } else if (gameState.equals("VICTORY")) {
    float btnX = width / 2;
    float btnY = 300;
    float btnW = 200;
    float btnH = 60;

    if (mouseX >= btnX - btnW/2 && mouseX <= btnX + btnW/2 &&
      mouseY >= btnY - btnH/2 && mouseY <= btnY + btnH/2) {
      // Restart full game from Level 1
      currentLevel = 1;
      score = 0;
      targetScore = 50;
      gameState = "PLAYING";
      startTime = millis();
      println("New game started!");
    }
  }
}
