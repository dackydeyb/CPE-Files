

import java.awt.*;
import javax.swing.*;

public class GUIActivity2 {
    public static void main(String [] args) {
        JFrame frame = new JFrame();

        frame.setLayout(new FlowLayout());
        
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocation(10,50);
        frame.setSize(900, 800);
        frame.setTitle("Frame Name");

        JCheckBox checkbox = new JCheckBox("Mora");
        frame.add(checkbox);

        JRadioButton radiobutton = new JRadioButton("Sun");
        frame.add(radiobutton);

        List fruitlist = new List(4,true);
        fruitlist.add("Apple");
        fruitlist.add("Banana");
        fruitlist.add("Cherry");
        fruitlist.add("Guyabano");
        frame.add(fruitlist);

        Choice fruitchoice = new Choice();
        fruitchoice.add("-- PLease Select --");
        fruitchoice.add("Banana");
        fruitchoice.add("Cherry");
        fruitchoice.add("Guyabano");
        frame.add(fruitchoice);

        JButton button1 = new JButton("Button1");
        button1.setBackground(Color.RED);
        frame.add(button1);

        JButton button2 = new JButton("Button2");
        button2.setBackground(Color.GREEN);
        frame.add(button2);

        JLabel label = new JLabel("User Name:");
        frame.add(label);

        JTextField textfield = new JTextField(10);
        frame.add(textfield);

        Label label2 = new Label("Password:");
        frame.add(label2);

        TextField passwordfField = new TextField(10);
        passwordfField.setEchoChar('*');
        frame.add(passwordfField);

        JTextArea textArea = new JTextArea(5,50);
        frame.add(textArea);
        frame.add(new JScrollPane(textArea));
        textArea.setFont(new Font("Times New Roman", Font.BOLD, 18));

        JColorChooser colorChooser = new JColorChooser(); // Declare a JColorChooser component
        frame.add(colorChooser); // Add the colorChooser component to the frame

        frame.setVisible(true);
        frame.pack();
    }
}