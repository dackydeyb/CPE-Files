import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.io.*;
import java.util.Scanner;

public class text_Calculator {
    private static JTextField textField1;
    private static JTextField textField2;
    private static StringBuilder currentExpression = new StringBuilder();
    
    public static void main(String[] args) {
        JFrame frame = new JFrame("Main Solver+");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 700);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/March 7th_6.png");
        frame.setIconImage(icon.getImage());

        // Create the Menu Bar
        JMenuBar menuBar = new JMenuBar();

        // Create the File menu
        JMenu fileMenu = new JMenu("File");
        fileMenu.setMnemonic(KeyEvent.VK_F);
        JMenuItem newWindowItem = new JMenuItem("          New Window     ");
        JMenuItem exItem = new JMenuItem("          Exit     ");



        newWindowItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, ActionEvent.CTRL_MASK));
        exItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4, KeyEvent.ALT_DOWN_MASK));

        fileMenu.add(newWindowItem);
        fileMenu.add(exItem);

        // Create the Edit menu
        JMenu editMenu = new JMenu("Edit");
        editMenu.setMnemonic(KeyEvent.VK_E);
        JMenuItem undoItem = new JMenuItem("          Undo     ");
        JMenuItem redoItem = new JMenuItem("          Redo     ");
        JMenuItem cutItem = new JMenuItem("          Cut     ");
        JMenuItem copyItem = new JMenuItem("          Copy     ");
        JMenuItem pasteItem = new JMenuItem("          Paste     ");

        undoItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Z, ActionEvent.CTRL_MASK));
        redoItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Y, ActionEvent.CTRL_MASK));
        cutItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X, ActionEvent.CTRL_MASK));
        copyItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, ActionEvent.CTRL_MASK));
        pasteItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_V, ActionEvent.CTRL_MASK));

        editMenu.add(undoItem);
        editMenu.add(redoItem);
        editMenu.addSeparator();
        editMenu.add(cutItem);
        editMenu.add(copyItem);
        editMenu.add(pasteItem);

        // Create the Help menu
        JMenu helpMenu = new JMenu("Help");
        helpMenu.setMnemonic(KeyEvent.VK_H);
        JMenuItem aboutItem = new JMenuItem("          About     ");
        JMenu subDonateMenu = new JMenu("          Donate Via...     ");
        JMenuItem donateGcash = new JMenuItem("          GCash     ");
        JMenuItem donatePaypal = new JMenuItem("          Paypal     ");
        JMenuItem donateLandbank = new JMenuItem("          Landbank     ");
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

        // Add menus to the menu bar
        menuBar.add(fileMenu);
        menuBar.add(editMenu);
        menuBar.add(helpMenu);

        menuBar.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
        fileMenu.setFont(new Font("Arial", Font.BOLD, 17));
        newWindowItem.setFont(new Font("Arial", Font.BOLD, 15));
        exItem.setFont(new Font("Arial", Font.BOLD, 15));
        editMenu.setFont(new Font("Arial", Font.BOLD, 17));
        undoItem.setFont(new Font("Arial", Font.BOLD, 15));
        redoItem.setFont(new Font("Arial", Font.BOLD, 15));
        cutItem.setFont(new Font("Arial", Font.BOLD, 15));
        copyItem.setFont(new Font("Arial", Font.BOLD, 15));
        pasteItem.setFont(new Font("Arial", Font.BOLD, 15));
        helpMenu.setFont(new Font("Arial", Font.BOLD, 17));
        aboutItem.setFont(new Font("Arial", Font.BOLD, 15));
        subDonateMenu.setFont(new Font("Arial", Font.BOLD, 15));
        donateGcash.setFont(new Font("Arial", Font.BOLD, 15));
        donatePaypal.setFont(new Font("Arial", Font.BOLD, 15));
        donateLandbank.setFont(new Font("Arial", Font.BOLD, 15));

        JPanel northDisplayPanel = new JPanel(new GridLayout(2, 1, 0, 5));
        textField1 = new JTextField();
        textField2 = new JTextField();
        textField1.setHorizontalAlignment(JTextField.LEFT);
        textField2.setHorizontalAlignment(JTextField.RIGHT);
        textField1.setBackground(Color.GRAY);
        textField2.setBackground(Color.BLUE);
        textField1.setForeground(Color.WHITE);
        textField2.setForeground(Color.WHITE);
        textField1.setFont(new Font("Arial", Font.BOLD, 20));
        textField2.setFont(new Font("Arial", Font.BOLD, 35));
        textField1.setEditable(false);
        textField2.setEditable(false);
        northDisplayPanel.setBackground(Color.BLACK);

        northDisplayPanel.add(textField1);
        northDisplayPanel.add(textField2);

        northDisplayPanel.setBorder(BorderFactory.createEmptyBorder(20, 30, 10, 30));
        textField1.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
        textField2.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));

        // Panel for arrow buttons keys
        JPanel arrowPanels = new JPanel(new GridLayout(1,2, 10, 0));
        JButton leftArrow = new JButton("<");
        JButton rightArrow = new JButton(">");
        leftArrow.setBackground(Color.BLUE);
        rightArrow.setBackground(Color.BLUE);
        leftArrow.setForeground(Color.WHITE);
        rightArrow.setForeground(Color.WHITE);
        leftArrow.setFont(new Font("Arial", Font.BOLD, 15));
        rightArrow.setFont(new Font("Arial", Font.BOLD, 15));
        arrowPanels.setBackground(Color.BLACK);

        arrowPanels.add(leftArrow);
        arrowPanels.add(rightArrow);
        
        arrowPanels.setBorder(BorderFactory.createEmptyBorder(10, 90, 10, 90));
        
        // Panel for radio buttons
        JPanel radioButtonsPanel = new JPanel(new GridLayout(1,3));
        JRadioButton OFF = new JRadioButton("OFF");
        JRadioButton oneAngleoneSide = new JRadioButton("1 ∠ & 1 △");
        JRadioButton twoAngles_With_Or_Without_Angles = new JRadioButton("2 ∠ &/or 1 △");
        OFF.setBackground(Color.BLACK);
        oneAngleoneSide.setBackground(Color.BLACK);
        twoAngles_With_Or_Without_Angles.setBackground(Color.BLACK);
        OFF.setForeground(Color.WHITE);
        oneAngleoneSide.setForeground(Color.WHITE);
        twoAngles_With_Or_Without_Angles.setForeground(Color.WHITE);
        OFF.setFont(new Font("Arial", Font.BOLD, 15));
        oneAngleoneSide.setFont(new Font("Arial", Font.BOLD, 15));
        twoAngles_With_Or_Without_Angles.setFont(new Font("Arial", Font.BOLD, 15));
        radioButtonsPanel.setBackground(Color.BLACK);


        radioButtonsPanel.add(OFF);
        radioButtonsPanel.add(oneAngleoneSide);
        radioButtonsPanel.add(twoAngles_With_Or_Without_Angles);

        // Group the radiobutton so it wont be selected at the same time
        ButtonGroup group = new ButtonGroup();
        group.add(OFF);
        group.add(oneAngleoneSide);
        group.add(twoAngles_With_Or_Without_Angles);

        // Set the OFF radio button to be selected by default
        OFF.setSelected(true);

        radioButtonsPanel.setBorder(BorderFactory.createEmptyBorder(10, 50, 20, 50));
        


        // Panel for number buttons and operation buttons
        JPanel buttonKeysPanel = new JPanel(new GridLayout(6, 5, 3, 3));
        buttonKeysPanel.setBackground(Color.BLACK);

        String[] buttonLabels = {
            "∠A", "∠B", "△a", "△b", "△c",
            "C", "AC", "(", ")", "x³", 
            "7", "8", "9", "/", "x²",
            "4", "5", "6", "*", "x^y",
            "1", "2", "3", "-", "\"?\"",
            "00", "0", ".", "+", "="
        };

        for (String label : buttonLabels) {
            JButton button = new JButton(label);
            button.setFont(new Font("Arial", Font.BOLD, 20));
            button.setForeground(Color.WHITE);
            button.addActionListener(new ButtonClickListener());
            
            if (label.equals("00") || label.matches("[0-9]")) {
            button.setBackground(Color.GRAY);
            } else if (label.equals("=")) {
            button.setBackground(Color.BLUE);
            } else {
            button.setBackground(Color.DARK_GRAY);
            }
            
            buttonKeysPanel.add(button);
        }

        buttonKeysPanel.setBorder(BorderFactory.createEmptyBorder(0, 20, 20, 20));

        JPanel panelHistoryPanel = new JPanel(new GridLayout(1,3, 10, 0));
        JButton clearHistoryButtton = new JButton("Clear History");
        JButton viewHitoryButton = new JButton("View History");
        JButton saveHistoryButton = new JButton("Save History");

        clearHistoryButtton.setBackground(Color.RED);
        clearHistoryButtton.setForeground(Color.WHITE);
        viewHitoryButton.setBackground(Color.YELLOW);
        saveHistoryButton.setBackground(Color.GREEN);
        panelHistoryPanel.setBackground(Color.BLACK);

        panelHistoryPanel.add(clearHistoryButtton);
        panelHistoryPanel.add(viewHitoryButton);
        panelHistoryPanel.add(saveHistoryButton);

        clearHistoryButtton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    File file = new File("Calculator History.txt");
                    FileWriter writer = new FileWriter(file);
                    writer.write("");
                    writer.close();
                    JOptionPane.showMessageDialog(null, "History cleared successfully", "Success", JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        });

        viewHitoryButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            try {
                File file = new File("Calculator History.txt");
                Scanner scanner = new Scanner(file);
                StringBuilder history = new StringBuilder();
                while (scanner.hasNextLine()) {
                history.append(scanner.nextLine()).append("\n");
                }
                JTextArea textArea = new JTextArea(history.toString());
                textArea.setEditable(false);
                JScrollPane scrollPane = new JScrollPane(textArea);
                scrollPane.setPreferredSize(new Dimension(400, 300));
                JOptionPane.showMessageDialog(null, scrollPane, "Calculator History", JOptionPane.INFORMATION_MESSAGE);
                scanner.close();
            } catch (FileNotFoundException ex) {
                ex.printStackTrace();
            }
            }
        });

        saveHistoryButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    File file = new File("Calculator History.txt");
                    FileWriter writer = new FileWriter(file, true);
                    writer.write(textField1.getText() + " = " + textField2.getText() + "\n");
                    writer.write("Last updated on: " + new java.util.Date() );
                    writer.write("\n\n");
                    writer.close();
                    JOptionPane.showMessageDialog(null, "History saved successfully", "Success", JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        });

        panelHistoryPanel.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));

        // Add the Menu Bar to the frame
        frame.setJMenuBar(menuBar);

        // Group the north display panel and arrow panel
        JPanel northPanel = new JPanel (new BorderLayout());
        northPanel.add(northDisplayPanel, BorderLayout.NORTH);
        northPanel.add(arrowPanels, BorderLayout.SOUTH);

        JPanel centerPanel = new JPanel(new BorderLayout());
        centerPanel.add(radioButtonsPanel, BorderLayout.NORTH);
        centerPanel.add(buttonKeysPanel, BorderLayout.CENTER);

        frame.add(northPanel, BorderLayout.NORTH);
        frame.add(centerPanel, BorderLayout.CENTER);
        frame.add(panelHistoryPanel, BorderLayout.SOUTH);

        // On startup, OFF radiobutton is checked, the buttons:"∠A", "∠B", "△a", "△b", "△c", and "?" will be disabled
        // If the rest of the radiobuttons are checked it will activitate it

        ActionListener radioListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (OFF.isSelected()) {
                    buttonKeysPanel.getComponent(0).setEnabled(false);
                    buttonKeysPanel.getComponent(1).setEnabled(false);
                    buttonKeysPanel.getComponent(2).setEnabled(false);
                    buttonKeysPanel.getComponent(3).setEnabled(false);
                    buttonKeysPanel.getComponent(4).setEnabled(false);
                    buttonKeysPanel.getComponent(24).setEnabled(false);
                } else {
                    buttonKeysPanel.getComponent(0).setEnabled(true);
                    buttonKeysPanel.getComponent(1).setEnabled(true);
                    buttonKeysPanel.getComponent(2).setEnabled(true);
                    buttonKeysPanel.getComponent(3).setEnabled(true);
                    buttonKeysPanel.getComponent(4).setEnabled(true);
                    buttonKeysPanel.getComponent(24).setEnabled(true);
                }
            }
        };

        // Initially disable the buttons
        if (OFF.isSelected()) {
            buttonKeysPanel.getComponent(0).setEnabled(false);
            buttonKeysPanel.getComponent(1).setEnabled(false);
            buttonKeysPanel.getComponent(2).setEnabled(false);
            buttonKeysPanel.getComponent(3).setEnabled(false);
            buttonKeysPanel.getComponent(4).setEnabled(false);
            buttonKeysPanel.getComponent(24).setEnabled(false);
        }

        OFF.addActionListener(radioListener);
        oneAngleoneSide.addActionListener(radioListener);
        twoAngles_With_Or_Without_Angles.addActionListener(radioListener);

        frame.setVisible(true);
    }

    

    private static class ButtonClickListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            String command = e.getActionCommand();

            if ("0123456789".contains(command) || "00".contains(command)) {
                currentExpression.append(command);
                textField2.setText(currentExpression.toString());
            } else if ("/*-+".contains(command)) {
                currentExpression.append(" ").append(command).append(" ");
                textField2.setText(currentExpression.toString());
            } else if ("x²".equals(command)) {
                currentExpression.append(" x² ");
                textField2.setText(currentExpression.toString());
            } else if ("√".equals(command)) {
                currentExpression.append(" √ ");
                textField2.setText(currentExpression.toString());
            } else if ("π".equals(command)) {
                currentExpression.append(" π ");
                textField2.setText(currentExpression.toString());
            } else if (".".equals(command)) {
                currentExpression.append(".");
                textField2.setText(currentExpression.toString());
            } else if ("(".equals(command)) {
                currentExpression.append(" ( ");
                textField2.setText(currentExpression.toString());
            } else if (")".equals(command)) {
                currentExpression.append(" ) ");
                textField2.setText(currentExpression.toString());
            } else if ("\"?\"".equals(command)) {
                currentExpression.append(" \"?\" ");
                textField2.setText(currentExpression.toString());
            } else if ("=".equals(command)) {
                try {
                    double result = evaluate(currentExpression.toString());
                    textField1.setText(currentExpression.toString());
                    textField2.setText(String.valueOf(result));
                    currentExpression.setLength(0);
                    currentExpression.append(result);
                } catch (Exception ex) {
                    textField2.setText("Error, try again.");
                    currentExpression.setLength(0);
                }
            } else if ("C".equals(command)) {
                currentExpression.setLength(0);
                textField2.setText("");
            } else if ("AC".equals(command)) {
                currentExpression.setLength(0);
                textField1.setText("");
                textField2.setText("");
            }
        }

        private double evaluate(String expression) {
            String[] tokens = expression.split(" ");
            double operand1 = Double.parseDouble(tokens[0]);
            String operator = tokens[1];
            double operand2 = Double.parseDouble(tokens[2]);

            switch (operator) {
                case "+":
                    return operand1 + operand2;
                case "-":
                    return operand1 - operand2;
                case "*":
                    return operand1 * operand2;
                case "/":
                    return operand1 / operand2;
                case "%":
                    return operand1 % operand2;
                case "x²":
                    return Math.pow(operand1, 2);
                case "√":
                    return Math.sqrt(operand2);
                case "π":
                    return Math.PI;
                case ".":
                    return Double.parseDouble(tokens[0] + "." + tokens[2]);
                case "(":
                    if (tokens[0].matches("\\d+") && tokens[2].matches("\\d+")) {
                        return Double.parseDouble(tokens[0]) * Double.parseDouble(tokens[2]);
                    } else {
                        throw new IllegalArgumentException("Invalid expression");
                    }
                case ")":
                    if (tokens[0].matches("\\d+") && tokens[2].matches("\\d+")) {
                        return Double.parseDouble(tokens[0]) * Double.parseDouble(tokens[2]);
                    } else {
                        throw new IllegalArgumentException("Invalid expression");
                    }
                
                default:
                    throw new IllegalArgumentException("Invalid operator");
            }
        }
    }
}


