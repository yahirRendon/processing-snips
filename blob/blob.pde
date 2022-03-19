Blob blob;
Blob blob2;
Blob blob3;

void setup() {
  size(900, 900);

  blob = new Blob(250, 450, 100, 0.7);
  blob2 = new Blob(450, 450, 100, 1.1);
  blob3 = new Blob(650, 450, 100, 1.8);
}

void draw() {
  background(255);

  fill(100);
  strokeWeight(5);
  blob.display();

  fill(0);
  noStroke();
  blob2.display();

  stroke(0);
  noFill();
  blob3.display();
}

class Blob {
  PVector org;
  float noiseMax;
  int angleOffset;
  int sizeMax;
  int sizeMin;

  Blob(int _x, int _y, int _s, float _n) {
    org = new PVector(_x, _y);
    sizeMax = _s;
    sizeMin =  sizeMax - 50;
    noiseMax = _n;
    angleOffset = int(random(0, 720));
  }

  void display() {
    beginShape();
    for (float a = angleOffset; a < angleOffset + 360; a += 1) {
      float xoff = map(cos(radians(a)), -1, 1, 0, noiseMax);
      float yoff = map(sin(radians(a)), -1, 1, 0, noiseMax);
      float r = map(noise(xoff, yoff), 0, 1, sizeMin, sizeMax);
      float x = org.x + cos(radians(a)) * r;
      float y = org.y + sin(radians(a)) * r;
      vertex(x, y);
    }
    endShape(CLOSE);
  }
}
