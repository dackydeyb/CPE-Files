
import javax.swing.*;
import java.awt.*; 

public class GUIActivity_14_Calculator {

    public static void main(String[] args) {
        JFrame frame = new JFrame("Main Solver+");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(720, 900);
 
        //Change the icon of the frame
        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\March 7th_6.png");
        frame.setIconImage(icon.getImage());

        JPanel panel = new JPanel(new BorderLayout());

        // Display panel
        JPanel displayPanel = new JPanel(new BorderLayout());
        JTextField displayField = new JTextField(20);
        displayField.setBorder(BorderFactory.createLineBorder(Color.BLUE));
        displayField.setFont(new Font("Arial", Font.BOLD,30));
        displayField.setBackground(Color.GRAY);
        displayField.setForeground(Color.WHITE);
        displayField.setHorizontalAlignment(JTextField.RIGHT); // Align text to the right
        displayField.setPreferredSize(new Dimension(displayField.getPreferredSize().width, 80)); // Set the height of the display field

        displayPanel.setBorder(BorderFactory.createEmptyBorder(40, 30, 0, 30)); // add padding to the top
        displayPanel.setBackground(Color.BLACK);
        displayPanel.add(displayField, BorderLayout.NORTH);

        // Panel for arrow keys
        JPanel arrowPanel = new JPanel(new GridLayout(1, 2, 20, 5));
        arrowPanel.setBorder(BorderFactory.createEmptyBorder(40, 180, 0, 180));
        arrowPanel.setBackground(Color.BLACK);

        // Arrow keys
        JButton leftArrowButton = createButton("🢀");
        leftArrowButton.setBackground(Color.BLUE);
        arrowPanel.add(leftArrowButton);

        JButton rightArrowButton = createButton("🢂");
        rightArrowButton.setBackground(Color.BLUE);
        arrowPanel.add(rightArrowButton);

        displayPanel.add(arrowPanel, BorderLayout.CENTER);


        JPanel tyoeOfGiven = new JPanel(new GridLayout(1,2,50,5));
        tyoeOfGiven.setBorder(BorderFactory.createEmptyBorder(40, 20, 0, 20));
        tyoeOfGiven.setBackground(Color.BLACK);

        // 1 angle & 1 side button
        JRadioButton oneAngleOneSideButton = new JRadioButton("1 ∠ & 1 △");
        oneAngleOneSideButton.setFont(oneAngleOneSideButton.getFont().deriveFont(Font.BOLD, 30));
        oneAngleOneSideButton.setBackground(Color.BLACK);
        oneAngleOneSideButton.setForeground(Color.WHITE);
        tyoeOfGiven.add(oneAngleOneSideButton);

        // 2 sides button
        JRadioButton twoSidesButton = new JRadioButton("2 △ w/ or w/out ∠");
        twoSidesButton.setFont(twoSidesButton.getFont().deriveFont(Font.BOLD, 25));
        twoSidesButton.setBackground(Color.BLACK);
        twoSidesButton.setForeground(Color.WHITE);
        tyoeOfGiven.add(twoSidesButton);

        displayPanel.add(tyoeOfGiven, BorderLayout.SOUTH);

        /* JPanel arrowTop = new JPanel(new GridLayout(1, 1, 5, 5));
        arrowTop.setBorder(BorderFactory.createEmptyBorder(140, 260, 0, 260));
        arrowTop.setBackground(Color.BLACK);

        // Arrow keys
        JButton upArrowButton = createButton("↑");
        arrowTop.add(upArrowButton);
        displayPanel.add(arrowTop, BorderLayout.NORTH);

        JPanel arrowBottom = new JPanel(new GridLayout(1, 1, 5, 5));
        arrowBottom.setBorder(BorderFactory.createEmptyBorder(5, 260, 0, 260));
        arrowBottom.setBackground(Color.BLACK);

        // Arrow keys
        JButton downArrowButton = createButton("↓");
        arrowBottom.add(downArrowButton);
        displayPanel.add(arrowBottom, BorderLayout.SOUTH); */


        //2nd Panel for Save history, and type of given
        JPanel buttonPanel = new JPanel(new GridLayout(1, 2, 20, 3));
        buttonPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        buttonPanel.setBackground(Color.BLACK);

        JButton clearHistoryButton = createButton("CLEAR HISTORY");
        buttonPanel.add(clearHistoryButton);
        clearHistoryButton.setBackground(Color.RED);
        clearHistoryButton.setForeground(Color.LIGHT_GRAY);

        JButton viewHistoryButton = createButton("VIEW HISTORY");
        buttonPanel.add(viewHistoryButton);
        viewHistoryButton.setBackground(Color.ORANGE);
        viewHistoryButton.setForeground(Color.BLACK);

        // Save History button
        JButton saveHistoryButton = createButton("SAVE HISTORY");
        buttonPanel.add(saveHistoryButton);
        saveHistoryButton.setBackground(Color.GREEN);
        saveHistoryButton.setForeground(Color.BLACK);


        // Button Panels
        JPanel panel2 = new JPanel(new GridLayout(6, 6, 3, 3));
        panel2.setBorder(BorderFactory.createEmptyBorder(40, 20, 20, 20));
        panel2.setBackground(Color.BLACK);

        panel.add(displayPanel, BorderLayout.NORTH);
        panel.add(panel2, BorderLayout.CENTER);
        panel.add(buttonPanel, BorderLayout.SOUTH);

        // Buttons
        // First row
        panel2.add(createButton("∠A"));
        panel2.add(createButton("∠B"));
        panel2.add(createButton("△a"));
        panel2.add(createButton("△b"));
        panel2.add(createButton("△c"));
        

        //Second row
        panel2.add(createButton("C")).setForeground(Color.ORANGE);
        panel2.add(createButton("AC")).setForeground(Color.ORANGE);
        panel2.add(createButton("("));
        panel2.add(createButton(")"));
        panel2.add(createButton("π"));
    
        // third row
        panel2.add(createButton("7"));
        panel2.add(createButton("8"));
        panel2.add(createButton("9"));
        panel2.add(createButton("/"));
        panel2.add(createButton("√"));
        

        // fourth row
        panel2.add(createButton("4"));
        panel2.add(createButton("5"));
        panel2.add(createButton("6"));
        panel2.add(createButton("*"));
        panel2.add(createButton("x^2"));

        // fifth row
        panel2.add(createButton("1"));
        panel2.add(createButton("2"));
        panel2.add(createButton("3"));
        panel2.add(createButton("-"));
        panel2.add(createButton("%"));

        // sixth row
        panel2.add(createButton("00"));
        panel2.add(createButton("0"));
        panel2.add(createButton("."));
        panel2.add(createButton("+"));
        panel2.add(createButton("="));


        // Add panels to the main panel
        panel.add(displayPanel, BorderLayout.NORTH);
        panel.add(panel2, BorderLayout.CENTER);

        frame.add(panel);
        frame.setVisible(true);
    }

    private static JButton createButton(String text) {
        JButton button = new JButton(text);
        if (text.matches("[0-9]|00")) { // check if the text is a number or "00"
            button.setBackground(Color.GRAY); // Change to GRAY
            button.setFont(button.getFont().deriveFont(Font.BOLD, 35));
            button.setForeground(Color.WHITE); // set text color to white
        } else if (text.matches("[=]")) { // check if the text is an equal sign
            button.setBackground(Color.BLUE);
            button.setFont(button.getFont().deriveFont(Font.BOLD, 35));
            button.setForeground(Color.WHITE);
        } else {
            button.setBackground(Color.DARK_GRAY);
            button.setFont(button.getFont().deriveFont(Font.BOLD, 20));
            button.setForeground(Color.WHITE);
        }
        return button;
    }
}
