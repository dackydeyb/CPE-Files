// Sample program 2

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class GUIActivity6 {
    public static void main (String [] args) {
        new BMICompute();
    }
}

class BMICompute implements ActionListener {
    private JFrame frame;
    private JTextField heightField, weightField;
    private JLabel BMILabel;
    private JButton ComputeButton;

    public BMICompute () {
        heightField = new JTextField(5);
        weightField = new JTextField(5);
        BMILabel = new JLabel("Type in your height and weight");
        ComputeButton = new JButton("Compute BMI");
        ComputeButton.addActionListener(this);

        JPanel north = new JPanel (new GridLayout(2,2));
        north.add (new JLabel ("Height (in Feet): "));
        north.add (heightField);
        north.add (new JLabel ("Weight (in Pounds): "));
        north.add (weightField);

        frame = new JFrame ("BMI Calculator");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new BorderLayout());
        frame.add(BMILabel,BorderLayout.NORTH);
        frame.add(north, BorderLayout.CENTER);
        frame.add(ComputeButton, BorderLayout.SOUTH);

        frame.pack();
        frame.setVisible(true);
    }

    public void actionPerformed(ActionEvent e) {
        String heightText = heightField.getText();
        double height = Double.parseDouble(heightText);
        String weightText = weightField.getText();
        double weight = Double.parseDouble(weightText);

        double BMI = weight / (height * height) * 703;

        BMILabel.setText("BMI: " + BMI);
        JOptionPane.showMessageDialog(null, "BMI: " + BMI, "Result", JOptionPane.INFORMATION_MESSAGE);
    }
}
