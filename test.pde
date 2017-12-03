
ProgramReader pr;

void setup() {
  size(320, 240);
  pr = new ProgramReader();
  pr.read("program.txt");
}

void draw() {
}

void keyPressed() {
  pr.currentKey = int(key); // pr.reg[0] = int(key);
}

/*/
void draw() {
  background(255);
} // */