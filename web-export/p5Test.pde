void setup() {
  size(600, 400);
  frameRate(60);
}

void draw() {
  float osc = sin(millis() / 400.0);
  background(0);
  fill(0, 127, 255);
  noStroke();
  ellipse(width/2, height/2, osc*height, osc*height);
}

