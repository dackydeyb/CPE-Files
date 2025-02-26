// Custom Icons and buttons

import javax.swing.*;
import java.awt.image.*;
import java.awt.*;

public class GUIActivity7 {
    public static void main (String []aStrings){

        JFrame frame = new JFrame(); // Creation of frame

        frame.setLayout (new FlowLayout()); // layout manager (flow layout)
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // close operation
        frame.setLocation (10,50); // location of the frame
        frame.setSize (300,1500); // size of the frame
        frame.setTitle ("Frame Name"); // title of the frame

        JButton button1 = new JButton ("Button 1"); // Creation of button
        button1.setIcon (new ImageIcon("C:\\Users\\padua\\Desktop\\Java OOP\\Pictures\\March 7th_6.png"));
        
        // Resize image because the default image is too big
        Image img = new ImageIcon ("C:\\Users\\padua\\Desktop\\Java OOP\\Pictures\\March 7th_6.png").getImage();
        Image newimg = img.getScaledInstance (50, 50,  java.awt.Image.SCALE_SMOOTH);
        button1.setIcon (new ImageIcon(newimg));

        button1.setBackground(Color.YELLOW);
        frame.add (button1); // adding button to the frame


        JButton button2 = new JButton ("Button 2"); // Creation of button
        BufferedImage image = new BufferedImage(100,100,BufferedImage.TYPE_INT_ARGB);
        Graphics g = image.getGraphics();
        g.setColor (Color.YELLOW);
        g.fillRect (10, 20, 90, 70);
        g.setColor (Color.RED);
        g.fillOval (40, 40, 25, 25);
        ImageIcon icon = new ImageIcon (image);
        button2.setIcon (icon);
        button2.setBackground(Color.GREEN);
        frame.add (button2); // adding button to the frame


        frame.pack();
        frame.setVisible(true);
    }
}
