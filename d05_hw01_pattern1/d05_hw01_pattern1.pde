
int columns;
int rows;

int cellWidth;
int cellHeight;

void setup() {
  size(640, 640);
  colorMode(HSB, 360, 100, 100);
  blendMode(SCREEN);
  columns = 8;
  rows = 8;

  cellWidth = int(width/float(columns));
  cellHeight = int(height/float(rows));
}

void draw() {
  background(0);

  for (int col = 0; col < columns; col++) {
    for (int row = 0; row < rows; row++) {
      makeSquiggle(col, row);
    }
  }
}

void makeSquiggle(int col, int row) {
  float hue = random(360);
  float saturation = random(50) + 50;
  float brightness = random(50) + 50;
  stroke(hue, saturation, brightness);

  noFill();
  //    strokeWeight(int(random(12)));

  pushMatrix();
  int posX = col*cellWidth;
  int posY = row*cellHeight;
  int cellCenterX = posX + 0.5*cellWidth;
  int cellCenterY = posY + 0.5*cellHeight;
  translate(cellCenterX, cellCenterY);
  
  beginShape();
  int initialOffsetX = 0;
  int initialOffsetY = 0;
  vertex(posX + initialOffsetX, posY + initialOffsetY);
  quadraticVertex(80, 20, 50, 50);
  quadraticVertex(20, 80, 80, 80);
  endShape();
  popMatrix();
}

