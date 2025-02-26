

import java.awt.*;
import javax.swing.*;

public class ShowFlowLayout {
    public static void main(String[] args) {
        JFrame frame = new JFrame();

        frame.setLayout(new FlowLayout(FlowLayout.LEFT,10,20));

        frame.setTitle("Show Flow Layout");
        frame.setSize(300, 150);
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        frame.add(new JLabel("First Name"));
        frame.add(new JTextField(8));
        frame.add(new JLabel("M.I."));
        frame.add(new JTextField(1));
        frame.add(new JLabel("Last Name"));
        frame.add(new JTextField(8));

        frame.setVisible(true);
    }
}

