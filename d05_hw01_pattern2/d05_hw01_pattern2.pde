
int columns;
int rows;

int cellWidth;
int cellHeight;

void setup() {
  size(640, 640, P2D);
  colorMode(HSB, 360, 100, 100);
  blendMode(SCREEN);
  columns = 16;
  rows = 16;

  cellWidth = int(width/float(columns));
  cellHeight = int(height/float(rows));

  background(0);

  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < columns; col++) {
      makePoly(col, row);
    }
  }
}

void draw() {
}

void makePoly(int col, int row) {
  float hue = random(360);
  float saturation = random(50) + 50;
  float brightness = random(75) + 25;
  fill(hue, saturation, brightness);

  noStroke();

  pushMatrix();
  int posX = col*cellWidth;
  int posY = row*cellHeight;
  translate(posX + 0.5*cellWidth, posY + 0.5*cellHeight);
  rotate(360 * sin(col*rows + col));
  rect(-0.5*cellWidth, -0.5*cellHeight, 1.5*cellWidth, 1.5*cellHeight);
  popMatrix();
}

