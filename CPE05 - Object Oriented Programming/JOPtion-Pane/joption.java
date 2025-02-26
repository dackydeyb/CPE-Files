
import javax.swing.*;

public class joption {
  public static void main(String[]args) {
    //new Act12();
    new act12numbertwo();
  }
}

/* class JOptionPaneExample {
  JOptionPaneExample() {
    JOptionPane.showMessageDialog(null, "This is my first java program");
    JOptionPane.showInputDialog(null, "Download Extra Ram", "Download now!!!", JOptionPane.PLAIN_MESSAGE);
  }
} 

class JOptionPaneExample2 {
  JOptionPaneExample2() {
    String inp = JOptionPane.showInputDialog(null,"Enter your name: ","Input",JOptionPane.PLAIN_MESSAGE);
    int num = Integer.parseInt(JOptionPane.showInputDialog(null, "Enter your favorite number: ", "input",JOptionPane.PLAIN_MESSAGE));
  }
} */



/* class Act12 {
  Act12() {
    Object[] options = {"Dog", "Cat", "Bird", "Fish"};
    Object selectedOption = JOptionPane.showInputDialog(null, "Choose your favorite pet:", "Pet", JOptionPane.QUESTION_MESSAGE, null, options, options[0]);
    if (selectedOption != null) {
      JOptionPane.showMessageDialog(null, "Your favorite pet is a " + selectedOption, "Info", JOptionPane.INFORMATION_MESSAGE);
    }
  }
} */

class act12numbertwo {
  act12numbertwo() {
    String speedStr = JOptionPane.showInputDialog(null, "Enter the automobile speed:", "State Police Radar", JOptionPane.QUESTION_MESSAGE);
    int speed = Integer.parseInt(speedStr);
    int penalty = 0;

    if (speed > 55) {
      if (speed <= 60) {
        penalty = 200;
      } else if (speed <= 70) {
        penalty = 250;
      } else if (speed <= 80) {
        penalty = 300;
      } else {
        penalty = 350; // Assuming a default penalty for speeds above 80
      }
      JOptionPane.showMessageDialog(null, "Speeding... Penalty is $" + penalty, "Penalty: " + speed + " mph", JOptionPane.INFORMATION_MESSAGE);
    } else {
      JOptionPane.showMessageDialog(null, "Your speed is within the limit.", "No Penalty", JOptionPane.INFORMATION_MESSAGE);
    }
  }
}