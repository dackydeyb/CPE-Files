import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Scanner;


public class GUIACtivity_17_Java_Event_and_Action_Listener {

    private static JTextField angle_A_JTextField;
    private static JTextField angle_B_JTextField;
    private static JTextField side_a_JTextField;
    private static JTextField side_b_JTextField;
    private static JTextField side_c_JTextField;
    private static JTextField[] textFields;
    private static int currentIndex;

    public static void main(String[] args) {
        JFrame frame = new JFrame("Main Solver+");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 700);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\March 7th_6.png");
        frame.setIconImage(icon.getImage());

        // Menu Bar
        JMenuBar menuBar = new JMenuBar();

        // Create the File Menu
        JMenu fileMenu = new JMenu("File");
            fileMenu.setMnemonic(KeyEvent.VK_F);
        
        ImageIcon newIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\NewWindow.png");
        Image image = newIcon.getImage();
        Image resizedImage = image.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        newIcon = new ImageIcon(resizedImage);

        ImageIcon exitIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\close.png");
        Image exitImage = exitIcon.getImage();
        Image resizedExitImage = exitImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        exitIcon = new ImageIcon(resizedExitImage);
    
        JMenuItem newWindowItem = new JMenuItem("     New Window          ", newIcon);
        JMenuItem exItem = new JMenuItem("     Exit          ", exitIcon);
        
        newWindowItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, ActionEvent.CTRL_MASK));
        exItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4, KeyEvent.ALT_DOWN_MASK));

        fileMenu.add(newWindowItem);
        fileMenu.add(exItem);

        JMenu historyMenu = new JMenu("History");
        historyMenu.setMnemonic(KeyEvent.VK_I);

        ImageIcon historyIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\history.png");
        Image historyImage = historyIcon.getImage();
        Image resizedHistoryImage = historyImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        historyIcon = new ImageIcon(resizedHistoryImage);

        ImageIcon clearHistoryIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\broom.png");
        Image clearHistoryImage = clearHistoryIcon.getImage();
        Image resizedClearHistoryImage = clearHistoryImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        clearHistoryIcon = new ImageIcon(resizedClearHistoryImage);

        JMenuItem viewHistoryItem = new JMenuItem("     View History          ", historyIcon);
        JMenuItem clearHistoryItem = new JMenuItem("     Clear History          ", clearHistoryIcon);

        viewHistoryItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_H, ActionEvent.CTRL_MASK));
        clearHistoryItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, ActionEvent.CTRL_MASK));


        viewHistoryItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            try {
                File file = new File("Lesson_8/GUIActivity_17_Calculation_History.txt");
                Scanner scanner = new Scanner(file);
                StringBuilder history = new StringBuilder();
                while (scanner.hasNextLine()) {
                history.append(scanner.nextLine() + "\n");
                }

                JTextArea textArea = new JTextArea(history.toString());
                textArea.setEditable(false);
                textArea.setFont(new Font("Arial", Font.PLAIN, 17)); // Set font size to 17
                JScrollPane scrollPane = new JScrollPane(textArea);
                scrollPane.setPreferredSize(new Dimension(420, 500));
                JOptionPane.showMessageDialog(null, scrollPane, "Calculation History", JOptionPane.INFORMATION_MESSAGE);
                scanner.close();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, "Error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            }
            }
        });

        clearHistoryItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int confirmation = JOptionPane.showConfirmDialog(null, "Are you sure you want to clear the history?", "Confirmation", JOptionPane.YES_NO_OPTION);
                if (confirmation == JOptionPane.YES_OPTION) {
                    try {
                        File file = new File("Lesson_8/GUIActivity_17_Calculation_History.txt");
                        PrintWriter writer = new PrintWriter(file);
                        writer.print("");
                        writer.close();
                        JOptionPane.showMessageDialog(null, "History cleared successfully!", "Cleared", JOptionPane.INFORMATION_MESSAGE);
                    } catch (Exception ex) {
                        JOptionPane.showMessageDialog(null, "Error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });

        historyMenu.add(viewHistoryItem);
        historyMenu.add(clearHistoryItem);

        // Create the Help menu
        JMenu helpMenu = new JMenu("Help");
        helpMenu.setMnemonic(KeyEvent.VK_H);

        ImageIcon aboutIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\information.png");
        Image aboutImage = aboutIcon.getImage();
        Image resizedAboutImage = aboutImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        aboutIcon = new ImageIcon(resizedAboutImage);

        ImageIcon gCashIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\gcash.png");
        Image gCashImage = gCashIcon.getImage();
        Image resizedGCashImage = gCashImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        gCashIcon = new ImageIcon(resizedGCashImage);

        ImageIcon paypalIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\paypal.png");
        Image paypalImage = paypalIcon.getImage();
        Image resizedPaypalImage = paypalImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        paypalIcon = new ImageIcon(resizedPaypalImage);

        ImageIcon landbankIcon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\landbank.png");
        Image landbankImage = landbankIcon.getImage();
        Image resizedLandbankImage = landbankImage.getScaledInstance(27, 27, Image.SCALE_SMOOTH);
        landbankIcon = new ImageIcon(resizedLandbankImage);

        JMenuItem aboutItem = new JMenuItem("     About     ", aboutIcon);
            JMenu subDonateMenu = new JMenu("     Donate Via...     ");
            JMenuItem donateGcash = new JMenuItem("          GCash     ", gCashIcon);
            JMenuItem donatePaypal = new JMenuItem("          Paypal     ", paypalIcon);
            JMenuItem donateLandbank = new JMenuItem("          Landbank     ", landbankIcon);
            subDonateMenu.add(donateGcash);
            subDonateMenu.add(donatePaypal);
            subDonateMenu.add(donateLandbank);

        

        aboutItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F1, 0));
        subDonateMenu.setMnemonic(KeyEvent.VK_D);
        donateGcash.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_G, ActionEvent.CTRL_MASK));
        donatePaypal.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_P, ActionEvent.CTRL_MASK));
        donateLandbank.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_L, ActionEvent.CTRL_MASK));

        helpMenu.add(aboutItem);
        helpMenu.add(subDonateMenu);

        fileMenu.setFont(new Font("Arial", Font.BOLD, 17));
            newWindowItem.setFont(new Font("Arial", Font.BOLD, 17));
            exItem.setFont(new Font("Arial", Font.BOLD, 17));
        historyMenu.setFont(new Font("Arial", Font.BOLD, 17));
            viewHistoryItem.setFont(new Font("Arial", Font.BOLD, 17));
            clearHistoryItem.setFont(new Font("Arial", Font.BOLD, 17));
        helpMenu.setFont(new Font("Arial", Font.BOLD, 17));
            aboutItem.setFont(new Font("Arial", Font.BOLD, 17));
            subDonateMenu.setFont(new Font("Arial", Font.BOLD, 17));
                donateGcash.setFont(new Font("Arial", Font.BOLD, 17));
                donatePaypal.setFont(new Font("Arial", Font.BOLD, 17));
                donateLandbank.setFont(new Font("Arial", Font.BOLD, 17));

        // Add menus to the menu bar
        menuBar.add(fileMenu);
        menuBar.add(historyMenu);
        menuBar.add(helpMenu);

        JPanel northDisplayPanel = new JPanel(new GridLayout(1, 2, 20, 0));
        northDisplayPanel.setBackground(Color.BLACK);

        JPanel leftPanel = new JPanel(new GridLayout(1, 1));
        leftPanel.setBackground(Color.BLACK);
        JLabel type_of_givenJLabel = new JLabel("Type of Given: ");
        type_of_givenJLabel.setForeground(Color.WHITE);
        leftPanel.add(type_of_givenJLabel);

        JPanel rightPanel = new JPanel(new GridLayout(1, 1));
        JComboBox<String> type_of_givenJComboBox = new JComboBox<>();
        type_of_givenJComboBox.addItem("-- Please Select --");
        type_of_givenJComboBox.addItem("1 side and 1 Angle");
        type_of_givenJComboBox.addItem("2 sides w/ or w/out Angle");

        type_of_givenJComboBox.setBackground(Color.LIGHT_GRAY);

        rightPanel.add(type_of_givenJComboBox);

        type_of_givenJLabel.setFont(new Font("Arial", Font.PLAIN, 20));
        type_of_givenJComboBox.setFont(new Font("Arial", Font.PLAIN, 17));

        northDisplayPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        northDisplayPanel.add(leftPanel);
        northDisplayPanel.add(rightPanel);

        JPanel centerPanel = new JPanel(new GridLayout(10, 1));
        centerPanel.setBackground(Color.BLACK);

        JLabel angle_A = new JLabel("Angle A: ");
        angle_A_JTextField = new JTextField();

        JLabel angle_B = new JLabel("Angle B: ");
        angle_B_JTextField = new JTextField();

        JLabel side_a = new JLabel("Side a: ");
        side_a_JTextField = new JTextField();

        JLabel side_b = new JLabel("Side b: ");
        side_b_JTextField = new JTextField();

        JLabel side_c = new JLabel("Side c: ");
        side_c_JTextField = new JTextField();

        // Add the text fields to an array
        textFields = new JTextField[]{side_a_JTextField, side_b_JTextField, side_c_JTextField, angle_A_JTextField, angle_B_JTextField};
        currentIndex = 0;

        centerPanel.add(side_a);
        centerPanel.add(side_a_JTextField);
        centerPanel.add(side_b);
        centerPanel.add(side_b_JTextField);
        centerPanel.add(side_c);
        centerPanel.add(side_c_JTextField);
        centerPanel.add(angle_A);
        centerPanel.add(angle_A_JTextField);
        centerPanel.add(angle_B);
        centerPanel.add(angle_B_JTextField);
        

        angle_A.setFont(new Font("Arial", Font.PLAIN, 20));
        angle_A.setForeground(Color.WHITE);
        angle_A_JTextField.setFont(new Font("Arial", Font.BOLD, 17));
        angle_A_JTextField.setBackground(Color.LIGHT_GRAY);
        angle_A_JTextField.setForeground(Color.BLACK);

        angle_B.setFont(new Font("Arial", Font.PLAIN, 20));
        angle_B.setForeground(Color.WHITE);
        angle_B_JTextField.setFont(new Font("Arial", Font.BOLD, 17));
        angle_B_JTextField.setBackground(Color.LIGHT_GRAY);
        angle_B_JTextField.setForeground(Color.BLACK);

        side_a.setFont(new Font("Arial", Font.PLAIN, 20));
        side_a.setForeground(Color.WHITE);
        side_a_JTextField.setFont(new Font("Arial", Font.BOLD, 17));
        side_a_JTextField.setBackground(Color.LIGHT_GRAY);
        side_a_JTextField.setForeground(Color.BLACK);

        side_b.setFont(new Font("Arial", Font.PLAIN, 20));
        side_b.setForeground(Color.WHITE);
        side_b_JTextField.setFont(new Font("Arial", Font.BOLD, 17));
        side_b_JTextField.setBackground(Color.LIGHT_GRAY);
        side_b_JTextField.setForeground(Color.BLACK);

        side_c.setFont(new Font("Arial", Font.PLAIN, 20));
        side_c.setForeground(Color.WHITE);
        side_c_JTextField.setFont(new Font("Arial", Font.BOLD, 17));
        side_c_JTextField.setBackground(Color.LIGHT_GRAY);
        side_c_JTextField.setForeground(Color.BLACK);

        // Disable all text fields
        for (JTextField textField : textFields) {
            textField.setEnabled(false);
            textField.setDisabledTextColor(Color.DARK_GRAY);
        }

        // Add FocusListener to text fields
        // FocusListener is used to perform some action when a component gains or loses focus
        for (JTextField textField : textFields) {
            textField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
                textField.setBorder(BorderFactory.createLineBorder(Color.BLUE, 3));
            }

            @Override
            public void focusLost(FocusEvent e) {
                textField.setBorder(BorderFactory.createLineBorder(Color.BLACK));
            }
            });
        }

        centerPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        JPanel southPanel = new JPanel(new GridLayout(1, 2, 10, 0));
        southPanel.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));
        southPanel.setBackground(Color.BLACK);

        JPanel leftSouthPanel = new JPanel(new GridLayout(4, 3, 3, 3));
        String[] buttonLabels = {
            "7", "8", "9",
            "4", "5", "6",
            "1", "2", "3",
            "00", "0", "."
        };

        JButton[] numberButtons = new JButton[buttonLabels.length];
        for (int i = 0; i < buttonLabels.length; i++) {
            numberButtons[i] = new JButton(buttonLabels[i]);
            numberButtons[i].setFont(new Font("Arial", Font.BOLD, 20)); // Set font to Arial BOLD with size 20
            numberButtons[i].setForeground(Color.BLACK);
            numberButtons[i].setBackground(Color.LIGHT_GRAY);
            leftSouthPanel.add(numberButtons[i]);

            // Add ActionListener to each button
            numberButtons[i].addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    JButton source = (JButton) e.getSource();
                    textFields[currentIndex].setText(textFields[currentIndex].getText() + source.getText());
                }
            });
        }

        leftSouthPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        leftSouthPanel.setBackground(Color.DARK_GRAY);

        JPanel rightSouthPanel = new JPanel(new GridLayout(5, 1, 0, 10));
        JButton clearJButton = new JButton("C");
        JButton clearAllButton = new JButton("AC");
        JButton previousButton = new JButton("Previous");
        JButton nextButton = new JButton("Next");
        JButton solveJButton = new JButton("Solve");

        clearJButton.setFont(new Font("Arial", Font.BOLD, 17));
        clearAllButton.setFont(new Font("Arial", Font.BOLD, 17));
        previousButton.setFont(new Font("Arial", Font.BOLD, 17));
        nextButton.setFont(new Font("Arial", Font.BOLD, 17));
        solveJButton.setFont(new Font("Arial", Font.BOLD, 17));

        clearJButton.setForeground(Color.BLACK);
        clearAllButton.setForeground(Color.BLACK);
        clearJButton.setBackground(new Color(255, 140, 0));
        clearAllButton.setBackground(new Color(255, 140, 0));
        previousButton.setForeground(Color.WHITE);
        previousButton.setBackground(Color.DARK_GRAY);
        nextButton.setForeground(Color.WHITE);
        nextButton.setBackground(Color.DARK_GRAY);
        solveJButton.setForeground(Color.BLACK);
        solveJButton.setBackground(Color.GREEN);

        rightSouthPanel.add(clearJButton);
        rightSouthPanel.add(clearAllButton);
        rightSouthPanel.add(previousButton);
        rightSouthPanel.add(nextButton);
        rightSouthPanel.add(solveJButton);

        rightSouthPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        rightSouthPanel.setBackground(Color.DARK_GRAY);

        southPanel.add(leftSouthPanel);
        southPanel.add(rightSouthPanel);

        frame.setJMenuBar(menuBar);

        frame.add(northDisplayPanel, BorderLayout.NORTH);
        frame.add(centerPanel, BorderLayout.CENTER);
        frame.add(southPanel, BorderLayout.SOUTH);

        // When the user selects an item from the JComboBox, enable the appropriate text fields
        type_of_givenJComboBox.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            boolean enable = !type_of_givenJComboBox.getSelectedItem().equals("-- Please Select --");
            clearAllTextFields();
            currentIndex = 0;
            updateTextFieldState(enable);
            clearJButton.setEnabled(enable);
            clearAllButton.setEnabled(enable);
            nextButton.setEnabled(enable);
            previousButton.setEnabled(enable);
            solveJButton.setEnabled(enable);
            for (JButton button : numberButtons) {
                button.setEnabled(enable);
            }
            
            // If the user selects the first item, enable only the first text field
            if (type_of_givenJComboBox.getSelectedIndex() == 1 || type_of_givenJComboBox.getSelectedIndex() == 2) {
                side_a_JTextField.setBorder(BorderFactory.createLineBorder(Color.BLUE, 3));
            } else {
                side_a_JTextField.setBorder(BorderFactory.createEmptyBorder());
            }
            }
        });

        // When the user clicks the next button, it move to the next text field
        // and disable the previous text field
        nextButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            currentIndex++;
            if (currentIndex >= textFields.length) {
                currentIndex = 0;
            }
            textFields[currentIndex].requestFocus();
            side_a_JTextField.setBorder(BorderFactory.createEmptyBorder());
            }
        });

        // When the user clicks the previous button, it move to the previous text field
        previousButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            if (currentIndex > 0) {
                currentIndex--;
                updateTextFieldState(true);
                JTextField nextTextField = textFields[currentIndex];
                nextTextField.requestFocus();
                nextTextField.setBorder(BorderFactory.createLineBorder(Color.BLUE, 3));
            }
            }
        });


        // When the focus is gained on the angle A text field, change the border color to green
        angle_A_JTextField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
            angle_A_JTextField.setBorder(BorderFactory.createLineBorder(Color.GREEN, 3));
            }

            @Override
            public void focusLost(FocusEvent e) {
            angle_A_JTextField.setBorder(BorderFactory.createEmptyBorder());
            }
        });

        angle_B_JTextField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
            angle_B_JTextField.setBorder(BorderFactory.createLineBorder(Color.GREEN, 3));
            }

            @Override
            public void focusLost(FocusEvent e) {
            angle_B_JTextField.setBorder(BorderFactory.createEmptyBorder());
            }
        });
        
        // Clear button, clear the text field
        clearJButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                textFields[currentIndex].setText("");
            }
        });

        // C;ear all button, clear all text fields
        clearAllButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                clearAllTextFields();
            }
        
        });

        // Solve button, calculate the missing sides and angles
        solveJButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            try {
                if (type_of_givenJComboBox.getSelectedIndex() == 2) {
                twoSidesWithOrWithoutAngle();
                } else {
                oneSideWithAngle();
                }
                displayResults();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, "Error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            }
            }
        });

        // Initially select the first item in JComboBox
        type_of_givenJComboBox.setSelectedIndex(0);

        frame.setVisible(true);
    }

    // Enable or disable the text fields
    private static void updateTextFieldState(boolean enable) {
        for (int i = 0; i < textFields.length; i++) {
            textFields[i].setEnabled(i == currentIndex && enable);
        }
    }

    // Clear all text fields
    private static void clearAllTextFields() {
        for (JTextField textField : textFields) {
            textField.setText("");
            textField.setEnabled(false);
        }
    }

    // Calculations

    // One side and one angle
    private static void oneSideWithAngle() throws Exception {
        double angleA = parseField(angle_A_JTextField);
        double angleB = parseField(angle_B_JTextField);
        double sideA = parseField(side_a_JTextField);
        double sideB = parseField(side_b_JTextField);
        double sideC = parseField(side_c_JTextField);

        // Check if the sides form a valid right triangle
        if (sideC != -1 && (sideA > sideC || sideB > sideC)) {
            throw new Exception("The hypotenuse must be greater than the other sides.");
        }

        // Now use trigonometry to find missing sides:
        if (angleA == -1 && angleB != -1) {
            angleA = 90 - angleB;
        } else if (angleB == -1 && angleA != -1) {
            angleB = 90 - angleA;
        }

        if (sideC != -1) {
            if (sideA == -1 && angleA != -1) {
                sideA = Math.sin(Math.toRadians(angleA)) * sideC;
            }
            if (sideB == -1 && angleA != -1) {
                sideB = Math.cos(Math.toRadians(angleA)) * sideC;
            }
        }

        if (sideB != -1) {
            if (sideC == -1 && angleA != -1) {
                sideC = sideB / Math.cos(Math.toRadians(angleA));
            }
            if (sideA == -1 && angleA != -1) {
                sideA = Math.tan(Math.toRadians(angleA)) * sideB;
            }
        }

        if (sideA != -1) {
            if (sideC == -1 && angleA != -1) {
                sideC = sideA / Math.sin(Math.toRadians(angleA));
            }
            if (sideB == -1 && angleA != -1) {
                sideB = sideA / Math.tan(Math.toRadians(angleA));
            }
        }

        if (sideB != -1 && angleB != -1) {
            if (sideC == -1) {
                sideC = sideB / Math.sin(Math.toRadians(angleB));
            }
            if (sideA == -1) {
                sideA = Math.cos(Math.toRadians(angleB)) * sideB;
            }
        }

        sideA = Math.round(sideA * 100.0) / 100.0;
        sideB = Math.round(sideB * 100.0) / 100.0;
        sideC = Math.round(sideC * 100.0) / 100.0;
        angleA = Math.round(angleA * 100.0) / 100.0;
        angleB = Math.round(angleB * 100.0) / 100.0;

        if (angleA != -1 && angleB == -1) {
            angleB = 90 - angleA;
        } else if (angleB != -1 && angleA == -1) {
            angleA = 90 - angleB;
        }

        angle_A_JTextField.setText(String.valueOf(angleA));
        angle_B_JTextField.setText(String.valueOf(angleB));
        side_a_JTextField.setText(String.valueOf(sideA));
        side_b_JTextField.setText(String.valueOf(sideB));
        side_c_JTextField.setText(String.valueOf(sideC));
    }

    // Two sides with or without angles
    private static void twoSidesWithOrWithoutAngle() throws Exception{
        double angleA = parseField(angle_A_JTextField);
        double angleB = parseField(angle_B_JTextField);
        double sideA = parseField(side_a_JTextField);
        double sideB = parseField(side_b_JTextField);
        double sideC = parseField(side_c_JTextField);
        
         // Check if the sides form a valid right triangle
         if (sideC != -1 && (sideA > sideC || sideB > sideC)) {
            throw new Exception("The hypotenuse must be greater than the other sides.");
        }

        // Pythagorean theorem
        if (sideA == -1 && sideB != -1 && sideC != -1) {
            sideA = Math.round(Math.sqrt(Math.pow(sideC, 2) - Math.pow(sideB, 2)) * 100) / 100.0; // We use -(negative) here because we transposed the formula
        } else if (sideB == -1 && sideA != -1 && sideC != -1) {
            sideB = Math.round(Math.sqrt(Math.pow(sideC, 2) - Math.pow(sideA, 2)) * 100) / 100.0;
        } else if (sideC == -1 && sideA != -1 && sideB != -1) { 
             /* If side C is missing, Calculate sideC using the Pythagorean theorem
             By adding the calculation for side C as shown, the method now covers the case where 
             side C is missing and ensures that all sides and angles can be determined from just two known sides. */
            sideC = Math.round(Math.sqrt(Math.pow(sideA, 2) + Math.pow(sideB, 2)) * 100) / 100.0;// Standard a^2 + b^2 = c^2 then square root to get c
        }

        if (angleA == -1 && sideA != -1 && sideB != -1) { // If angle A is missing and side A and side B are present, we can calculate angle A
            angleA = Math.round(Math.toDegrees(Math.atan(sideA / sideB)) * 100) / 100.0;
            angleB = Math.round((90 - angleA) * 100) / 100.0;
        }
        if (angleB == -1 && sideA != -1 && sideB != -1) { // If angle B is missing and side A and side B are present, we can calculate angle B
            angleB = Math.round(Math.toDegrees(Math.atan(sideB / sideA)) * 100) / 100.0;
            angleA = Math.round((90 - angleB) * 100) / 100.0;
        }

        // If angle A or B is not present and angle B or A is present, we can calculate angle A or B using the formula:  90 - angle B or A
        if (angleA != -1 && angleB == -1) {
            angleB = 90 - angleA;
        } else if (angleB != -1 && angleA == -1) {
            angleA = 90 - angleB;
        }

        angle_A_JTextField.setText(String.valueOf(angleA));
        angle_B_JTextField.setText(String.valueOf(angleB));
        side_a_JTextField.setText(String.valueOf(sideA));
        side_b_JTextField.setText(String.valueOf(sideB));
        side_c_JTextField.setText(String.valueOf(sideC));
    }


    // Display the results
    private static void displayResults() throws Exception {
        double angleA = parseField(angle_A_JTextField);
        double angleB = parseField(angle_B_JTextField);
        double sideA = parseField(side_a_JTextField);
        double sideB = parseField(side_b_JTextField);
        double sideC = parseField(side_c_JTextField);

        String results = "Results:\n\n" +
            "Side a (opposite): " + sideA + "\n" +
            "Side b (adjacent): " + sideB + "\n" +
            "Side c (hypotenuse): " + sideC + "\n\n" +
            "Angle A: " + angleA + " degrees\n" +
            "Angle B: " + angleB + " degrees\n" +
            "Angle C: 90.0 degrees\n" +
            "Total Angle: " + (angleA + angleB + 90.0) + " degrees\n\n";

        Object[] options = { "OK", "SAVE" };
        int option = JOptionPane.showOptionDialog(null, results, "Results",
            JOptionPane.DEFAULT_OPTION, JOptionPane.INFORMATION_MESSAGE, null, options, options[0]);   
            
        if (option == 0) {
            return;
        } else if (option == 1) { // SAVE selected
            saveResultsOutside();
        }
    }

    private static double parseField(JTextField textField) {
        try {
            return Double.parseDouble(textField.getText());
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    // Save the results to a file
    private static void saveResultsOutside() throws Exception {
        File file = new File("CPE05 - Object Oriented Programming/Lesson_8/GUIActivity_17_Calculation_History.txt");

        PrintWriter writer = new PrintWriter(new FileWriter(file, true));
        writer.println("   Hypotenuse: " + side_c_JTextField.getText());
        writer.println("   Adjacent: " + side_b_JTextField.getText());
        writer.println("   Opposite: " + side_a_JTextField.getText() + "\n");
        writer.println("   Angle A: " + angle_A_JTextField.getText());
        writer.println("   Angle B: " + angle_B_JTextField.getText() + "\n");
        writer.println("   Total Angle: " + (parseField(angle_A_JTextField) + parseField(angle_B_JTextField) + 90.0) + " degrees\n");
        writer.println("   Last Updated on: " + new java.util.Date());
        writer.println();
        writer.println("---------------------------------------------------------------");
        writer.close();

        JOptionPane.showMessageDialog(null, "Results saved successfully!", "Saved", JOptionPane.INFORMATION_MESSAGE);
    }
}
 