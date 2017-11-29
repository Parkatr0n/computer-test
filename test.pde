
ProgramReader pr;

void setup() {
  size(320, 240);
  pr = new ProgramReader();
  pr.read("program.txt");
}