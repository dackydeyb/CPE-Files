
import javax.swing.*;

public class cardpreviewsize {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Yellow Card");
        frame.setSize(800, 450);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
        frame.setIconImage(icon.getImage());

 

        frame.setVisible(true);
    }
}
