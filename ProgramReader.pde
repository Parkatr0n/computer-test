
import java.util.HashMap;

class ProgramReader {
  HashMap<String, Integer> jumpList = new HashMap<String, Integer>();
  ArrayList<Variable> vars = new ArrayList<Variable>();
  int[] reg = {0, 0};
  
  void read(String file) {
    // Read and execute the file
    String[] File = loadStrings(file);
    
    // Adding to the jumplist
    for (int i = 0; i < File.length; i++) {
      String[] Split = File[i].split(" ");
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
      String[] Split = File[i].split(" ");
      
      /* Commands */
      if (Split[0].equals("set")) {
        vars.add(new Variable(Split[1], int(Split[2])));
      } else if (Split[0].equals("load")) {
        reg[int(Split[1])] = getVarByName(Split[2]).value;
      } else if (Split[0].equals("cot")) {
        if (Split.length > 2) {
          if (Split[2].equals("n")) {
            println(reg[int(Split[1])]);
          }
        }
        print(reg[int(Split[1])]);
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
      }
    }
  }
  
  Variable getVarByName(String name) {
    for (int i = 0; i < vars.size(); i++) {
      if (vars.get(i).name.equals(name)) {
        return vars.get(i);
      }
    }
    return new Variable("ERROR", -40000);
  }
}