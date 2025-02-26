import javax.swing.*;
import java.awt.*;

public class another_layouttest {
    public static void main(String[] args) {
        JFrame frame = new JFrame("JToggleButton");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 300);
        frame.setLocationRelativeTo(null);

        // Create the main panel with padding
        JPanel leftPanel = new JPanel(new GridLayout(3,1, 0, 10));

        JToggleButton redButton = new JToggleButton("Red");
        JToggleButton greenButton = new JToggleButton("Green");
        JToggleButton blueButton = new JToggleButton("Blue");

        leftPanel.add(redButton);
        leftPanel.add(greenButton);
        leftPanel.add(blueButton);

        leftPanel.setBorder(BorderFactory.createEmptyBorder(50, 40, 50, 40));


        JPanel rightPanel = new JPanel (new GridLayout (1,1));
        rightPanel.setBackground(Color.BLACK);
        
        rightPanel.setBorder(BorderFactory.createEmptyBorder(20, 0, 10, 30));

        // Group the panel
        JPanel mainPanel = new JPanel(new BorderLayout());
        mainPanel.add(leftPanel, BorderLayout.WEST);
        mainPanel.add(rightPanel, BorderLayout.EAST);

        // Add the main panel to the frame
        frame.add(mainPanel, BorderLayout.CENTER);
        frame.setVisible(true);
    }
}