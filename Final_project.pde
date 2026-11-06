/*
Adham Nawar
 Final Processing project
 TODO: add brief description of final project here
 */

int score = 0;

String gameState = "HOME";
PImage sonicClicker;

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
  }
}

void drawHomeScreen() {
  // Game Title
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Clicking Game", width / 2, 120);

  // Instructions
  textSize(16);
  text("Click the button below to begin!", width / 2, 180);

  // Start Button
  rectMode(CENTER);
  fill(255);
  rect(width / 2, height / 2, 200, 60, 10); // rounded corners

  fill(0);
  textSize(22);
  text("Start Game", width / 2, height / 2);

  // Reset rectMode and textAlign back to default for the rest of the program
  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

// --- GAME SCREEN DESIGN ---
void drawGameScreen() {
  // Gameplay button
  fill(255);
  //rect(150, 150, 200, 200);
  image(sonicClicker, 150, 150, 200, 200);


  // Score display
  fill(255);
  textSize(18);
  text("Score: " + score, 10, 30);
}

void mousePressed() {
  if (gameState.equals("HOME")) {
    // Coordinates for the centered "Start Game" button
    float btnX = width / 2;
    float btnY = height / 2;
    float btnW = 200;
    float btnH = 60;

    // Check if the mouse is inside the Start button
    if (mouseX >= btnX - btnW/2 && mouseX <= btnX + btnW/2 &&
      mouseY >= btnY - btnH/2 && mouseY <= btnY + btnH/2) {
      gameState = "PLAYING";
      println("Game started!");
    }
  } else if (gameState.equals("PLAYING")) {
    // Your original game click logic
    int minX = 150;
    int maxX = minX + 200;
    int minY = 150;
    int maxY = minY + 200;

    if (mouseX >= minX && mouseX <= maxX && mouseY >= minY && mouseY <= maxY) {
      println("The button was clicked");
      score = score + 1;
    }
  }
}
