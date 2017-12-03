
import java.util.Map;

class ProgramReader {
  HashMap<String, Integer> jumpList = new HashMap<String, Integer>();
  HashMap<String, Integer> vars = new HashMap<String, Integer>();
  // ArrayList<Variable> vars = new ArrayList<Variable>();
  int[] reg = {0, 0};
  
  int keyPress = 0;
  int currentKey = 0;
  
  int rectStartX;
  int rectStartY;
  
  void setKeyPress(int _keyPress) {
    keyPress = _keyPress;
  }
  
  void read(String file) {
    // Read and execute the file
    String[] File = loadStrings(file);
    
    // Adding to the jumplist
    for (int i = 0; i < File.length; i++) {
      String[] Split = trim(File[i]).split(" ");
      
      if (Split[0].equals(";")) {
        // This is a comment, skip to next line
        i++;
      }
      
      //println(File[i]);
      if (File[i].length() > 0) {
        // println(File[i].length(), File[i]);
        if (Split[0].charAt(0) == '.') {
          // Add this to the jumplist
          jumpList.put(Split[0].substring(1, Split[0].length()), i);
        }
      }
    }
    
    /* Actual Program Execution */
    for (int i = 0; i < File.length; i++) {
      String[] Split = trim(File[i]).split(" ");
      
      /* Commands */
      if (Split[0].equals("set")) {
        vars.put(Split[1], int(Split[2]));
      } else if (Split[0].equals("reset")) {
        vars.put(Split[1], reg[int(Split[2])]);
      } else if (Split[0].equals("load")) {
        reg[int(Split[1])] = vars.get(Split[2]);
      } else if (Split[0].equals("cot")) {
        boolean newLine = false;
        if (Split.length > 2) {
          if (Split[2].equals("n")) {
            println(reg[int(Split[1])]);
            newLine = true;
          }
        }
        if (!newLine) {
          print(reg[int(Split[1])]);
        }
      } else if (Split[0].equals("jmp")) {
        i = jumpList.get(Split[1]);
      } else if (Split[0].equals("sum")) {
        reg[0] += reg[1];
      } else if (Split[0].equals("sub")) {
        reg[0] -= reg[1];
      } else if (Split[0].equals("div")) {
        reg[0] /= reg[1];
      } else if (Split[0].equals("mlt")) {
        reg[0] *= reg[1];
      } else if (Split[0].equals("cmp")) {
        // Compare instruction
        // First argument is what type of compare
        // Second argument is the jump position IF THE COMPARE RETURNS TRUE
        String cmpType = Split[1];
        String jumpPos = Split[2];
        boolean jump = false;
        if (cmpType.equals("eq")) { if (reg[0] == reg[1]) { jump = true; }
        } else if (cmpType.equals("neq")) { if (reg[0] != reg[1]) { jump = true; }
        } else if (cmpType.equals("ls")) { if (reg[0] < reg[1]) { jump = true; }
        } else if (cmpType.equals("gr")) { if (reg[0] > reg[1]) { jump = true; }
        } else if (cmpType.equals("lse")) { if (reg[0] <= reg[1]) { jump = true; }
        } else if (cmpType.equals("gre")) { if (reg[0] >= reg[1]) { jump = true; } }
        if (jump) { i = jumpList.get(jumpPos); }
      } else if (Split[0].equals("getKey")) {
        // Variable var = getVarByName(Split[1]);
        
        // Set that variable to whatever the most recent keypress was
        // var.value = keyPress;
        reg[0] = keyCode;
        print(reg[0]);
        // print(keyCode);
      } else if (Split[0].equals(";")) {
        // This is a comment, skip to next line
        i++;
      } else if (Split[0].equals("point")) {
        int x = reg[0];
        int y = reg[1];
        
        stroke(0);
        point(x, y);
      } else if (Split[0].equals("st_rect")) {
        rectStartX = reg[0];
        rectStartY = reg[1];
      } else if (Split[0].equals("fn_rect")) {
        noStroke();
        fill(0);
        rectMode(CORNERS);
        rect(rectStartX, rectStartY, reg[0], reg[1]);
      }
    }
  }
  
  /* Variable getVarByName(String name) {
    for (int i = 0; i < vars.size(); i++) {
      if (vars.get(i).name.equals(name)) {
        return vars.get(i);
      }
    }
    return new Variable("ERROR", -40000);
  } */
}