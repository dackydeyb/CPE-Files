import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.time.LocalDate;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;



public class YellowCard {
    private static JFrame yellowCardFrame;

    public static void main(String[] args) {
        showYellowCard();
    }

    public static void showYellowCard() {
        // Close the previous frame
        if (yellowCardFrame != null) {
            yellowCardFrame.dispose();
        }

        yellowCardFrame = new JFrame("Lucban Card Program");
        yellowCardFrame.setSize(1200, 650);
        yellowCardFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        yellowCardFrame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
        yellowCardFrame.setIconImage(icon.getImage());

        // Create the main panel with a background image
        JPanel mainPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanStart.png");
                g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        mainPanel.setLayout(new BorderLayout());
        yellowCardFrame.add(mainPanel);

        JPanel southDisplayPanel = new JPanel(new GridLayout(4, 1, 0, 10));
        southDisplayPanel.setOpaque(false); // Make it transparent
        southDisplayPanel.setBorder(BorderFactory.createEmptyBorder(0, 500, 40, 500));

        JButton startButton = new JButton("Start");
        JButton instButton = new JButton("Instructions");
        JButton creditsButton = new JButton("Credits");
        JButton exitButton = new JButton("Exit");

        southDisplayPanel.add(startButton);
        southDisplayPanel.add(instButton);
        southDisplayPanel.add(creditsButton);
        southDisplayPanel.add(exitButton);

        // Add action listeners
        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                yellowCardFrame.dispose();
                new LucbanCardProgram();
            }
        });

        instButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new Instructions();
            }
        });

        creditsButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(yellowCardFrame, "This program was created by Team Lucban", "Credits", JOptionPane.INFORMATION_MESSAGE);
            }
        });

        exitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        mainPanel.add(southDisplayPanel, BorderLayout.SOUTH);

        yellowCardFrame.setVisible(true);
    }
}

class LucbanCardProgram {
    LucbanCardProgram() {
        JFrame frame = new JFrame("Lucban Card Program");
        frame.setSize(1200, 650);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
        frame.setIconImage(icon.getImage());

        JPanel centerPanel = new JPanel(new GridLayout(1, 3, 0, 50)) {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\Lucban_Option.png");
                g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        centerPanel.setOpaque(false);
        centerPanel.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));

        // Panel for Pay Bill
        JPanel leftCenterPanel = new JPanel(new GridLayout(1, 1)); 
        leftCenterPanel.setOpaque(false);
        JButton PayBillButton = new JButton();
        PayBillButton.setIcon(new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\PayBill-Button.png"));
        PayBillButton.setContentAreaFilled(false); // Make the button transparent
        PayBillButton.setBorderPainted(false); // Remove the button border
        PayBillButton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
            PayBillButton.setBorderPainted(true);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
            PayBillButton.setBorderPainted(false);
            }
        });
        leftCenterPanel.setBorder(BorderFactory.createEmptyBorder(180, 40, 160, 60));


        leftCenterPanel.add(PayBillButton);


        // Panel for Yellow and Blue Card
        JPanel middleCenterPanel = new JPanel(new GridLayout(2, 1,0,30));
        middleCenterPanel.setOpaque(false);
        JButton YellowCardButton = new JButton();
        YellowCardButton.setBorderPainted(false);
        YellowCardButton.setIcon(new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\Button_YellowCard.png"));
        // Mouse listeners to the YellowCardButton
        YellowCardButton.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                YellowCardButton.setBorderPainted(true);
                YellowCardButton.setBorder(BorderFactory.createLineBorder(Color.YELLOW, 2));
            }

            @Override
            public void mouseExited(MouseEvent e) {
                YellowCardButton.setBorderPainted(false);
            }
        });

        YellowCardButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                frame.dispose();
                YellowCard();
            }
        });

        JButton BlueCardButton = new JButton();
        BlueCardButton.setBorderPainted(false);
        BlueCardButton.setIcon(new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\Button_BlueCard.png"));
        // Mouse listeners to the BlueCardButton
        BlueCardButton.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                BlueCardButton.setBorderPainted(true);
                BlueCardButton.setBorder(BorderFactory.createLineBorder(new Color(0,79,152), 2));
            }

            @Override
            public void mouseExited(MouseEvent e) {
                BlueCardButton.setBorderPainted(false);
            }

            @Override
            public void mouseClicked(MouseEvent e) {
                BlueCard();
            }
        });
        middleCenterPanel.setBorder(BorderFactory.createEmptyBorder(160, 40, 60, 40));

        middleCenterPanel.add(YellowCardButton);
        middleCenterPanel.add(BlueCardButton);


        // Panel for Check Card
        JPanel rightCenterPanel = new JPanel(new GridLayout(2, 1, 0, -170));
        rightCenterPanel.setOpaque(false);
        rightCenterPanel.setBorder(BorderFactory.createEmptyBorder(290, 70, 0, 70));

        JPanel textFieldPanel = new JPanel();
        textFieldPanel.setOpaque(false);
        JTextField checkCardField = new JTextField();
        checkCardField.setPreferredSize(new Dimension(200, 30));
        checkCardField.setHorizontalAlignment(JTextField.CENTER);
        checkCardField.setFont(new Font("Arial", Font.BOLD, 20));
        textFieldPanel.add(checkCardField);

        JPanel buttonPanel = new JPanel();
        buttonPanel.setOpaque(false);
        JButton checkCardButton = new JButton("Check Card");
        buttonPanel.add(checkCardButton);

        checkCardButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String enteredID = checkCardField.getText().trim();
                boolean found = false;
                String filePath = "CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024/Saved_Details/YellowCard.txt";

                try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        if (line.startsWith("ID No.:")) {
                            String idNo = line.substring("ID No.:".length()).trim();
                            if (idNo.equals(enteredID)) {
                                found = true;
                                break;
                            }
                        }
                    }
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

                if (found) {
                    // Load the original image
                    ImageIcon originalIcon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\march-7th-cheer.gif");
                    // Resize the image
                    Image scaledImage = originalIcon.getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT);
                    ImageIcon scaledIcon = new ImageIcon(scaledImage);
                    Font boldFont = new Font("Arial", Font.BOLD, 20);
                    UIManager.put("OptionPane.messageFont", boldFont);
                    JOptionPane.showMessageDialog(frame, "ID No.: " + enteredID + " is registered.", "Success", JOptionPane.INFORMATION_MESSAGE, scaledIcon);
                } else {
                    ImageIcon originalIcon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\march-7th-cry.gif");
                    Image scaledImage = originalIcon.getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT);
                    ImageIcon scaledIcon = new ImageIcon(scaledImage);
                    Font boldFont = new Font("Arial", Font.BOLD, 20);
                    UIManager.put("OptionPane.messageFont", boldFont);
                    JOptionPane.showMessageDialog(frame, "ID No.: " + enteredID + " is not registered.", "Error", JOptionPane.ERROR_MESSAGE, scaledIcon);
                }
            }
        });

        rightCenterPanel.add(textFieldPanel);
        rightCenterPanel.add(buttonPanel);

        centerPanel.add(leftCenterPanel);
        centerPanel.add(middleCenterPanel);
        centerPanel.add(rightCenterPanel);

        frame.add(centerPanel, BorderLayout.CENTER);

        frame.setVisible(true);
    }

   /*  private void PayBills() {
        // Add code here
    } */

    private void YellowCard() {
        JFrame frame = new JFrame("Apply for Yellow Card");
        frame.setSize(1200, 650);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
        frame.setIconImage(icon.getImage());
        
        JPanel mainPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\YellowCard_Form.png");
                g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        mainPanel.setLayout(new BorderLayout());
        frame.add(mainPanel);

        // Panel for JLabel and textfields
        JPanel formPanel = new JPanel(new GridLayout(0, 2, 10, 5));
        formPanel.setBorder(BorderFactory.createEmptyBorder(100, 300, 50, 300));
        formPanel.setOpaque(false);

        JLabel nameLabel = new JLabel("Name:");
        JTextField nameField = new JTextField();

        JLabel genderLabel = new JLabel("Gender:");
        JRadioButton maleRadioButton = new JRadioButton("Male");
        JRadioButton femaleRadioButton = new JRadioButton("Female");

        ButtonGroup genderGroup = new ButtonGroup();
        genderGroup.add(maleRadioButton);
        genderGroup.add(femaleRadioButton);
        
        JLabel addressLabel = new JLabel("Address:");
        JTextArea addressArea = new JTextArea(200, 20); // Make the text area taller

        // Add the JTextArea to a JScrollPane
        JScrollPane addressScrollPane = new JScrollPane(addressArea);
        addressScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        addressScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        addressArea.setLineWrap(true); // Wrap lines
        addressArea.setWrapStyleWord(true); // Wrap at word boundaries

        JLabel birthDateLabel = new JLabel("Birth Date:");
        JTextField birthDateField = new JTextField();

        JLabel bloodTypeLabel = new JLabel("Blood Type:");
        String[] bloodTypes = {"-- Please Select --","A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
        JComboBox<String> bloodTypeComboBox = new JComboBox<>(bloodTypes);
        
        JLabel dateIssuedLabel = new JLabel("Date Issued:");
        JTextField dateIssuedField = new JTextField();
        dateIssuedField.setEditable(false);

        JLabel expirydate = new JLabel("Expiry Date:");
        JTextField expirydateField = new JTextField();
        expirydateField.setEditable(false);
        
        nameLabel.setFont(new Font("Arial", Font.BOLD, 20));
        nameLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        genderLabel.setFont(new Font("Arial", Font.BOLD, 20));
        genderLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        addressLabel.setFont(new Font("Arial", Font.BOLD, 20));
        addressLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        birthDateLabel.setFont(new Font("Arial", Font.BOLD, 20));
        birthDateLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        bloodTypeLabel.setFont(new Font("Arial", Font.BOLD, 20));
        bloodTypeLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        dateIssuedLabel.setFont(new Font("Arial", Font.BOLD, 20));
        dateIssuedLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        expirydate.setFont(new Font("Arial", Font.BOLD, 20));
        expirydate.setHorizontalAlignment(SwingConstants.RIGHT);

        nameField.setFont(new Font("Arial", Font.PLAIN, 20));
        addressArea.setFont(new Font("Arial", Font.PLAIN, 15));
        birthDateField.setFont(new Font("Arial", Font.PLAIN, 20));
        bloodTypeComboBox.setFont(new Font("Arial", Font.PLAIN, 17));
        dateIssuedField.setFont(new Font("Arial", Font.PLAIN, 20));
        expirydateField.setFont(new Font("Arial", Font.PLAIN, 20));

        maleRadioButton.setFont(new Font("Arial", Font.PLAIN, 20));
        femaleRadioButton.setFont(new Font("Arial", Font.PLAIN, 20));
        
        

        
        // Panel for back button
        JPanel southPanel = new JPanel(new GridLayout(1, 4, 30, 00));
        southPanel.setOpaque(false);
        southPanel.setBorder(BorderFactory.createEmptyBorder(10, 300, 20, 300));
        JButton backButton = new JButton("Back");
        JButton clearButton = new JButton("Clear");
        JButton applyButton = new JButton("Apply");
        JButton previewButton = new JButton("Preview Card");

        backButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            frame.dispose();
            new LucbanCardProgram();
            }
        });

        clearButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                nameField.setText("");
                genderGroup.clearSelection();
                addressArea.setText("");
                birthDateField.setText("");
                bloodTypeComboBox.setSelectedIndex(0);
                dateIssuedField.setText("");
                expirydateField.setText("");

                previewButton.setEnabled(false);
            }
        });

        applyButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            // Check if any of the required fields are empty
            if (nameField.getText().isEmpty() || addressArea.getText().isEmpty() || birthDateField.getText().isEmpty() || bloodTypeComboBox.getSelectedIndex() == 0 || (!maleRadioButton.isSelected() && !femaleRadioButton.isSelected())) {
                // Display an error message
                JOptionPane.showMessageDialog(frame, "Please fill out all the required fields", "Error", JOptionPane.ERROR_MESSAGE);
            } else {
                // Get the current date
                LocalDate currentDate = LocalDate.now();
        
                // Set the dateIssuedField to the current date
                dateIssuedField.setText(currentDate.toString());
        
                LocalDate expiryDate = currentDate.plusMonths(4);
        
                expirydateField.setText(expiryDate.toString());
        
                /* JOptionPane.showMessageDialog(frame, "Yellow Card Application Submitted" , "Application Status", JOptionPane.INFORMATION_MESSAGE); */
        
                File file = new File("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024/Saved_Details/YellowCard.txt");
        
                try {
                int lastIdNumber = 0;
                
                if (file.exists()) {
                    // Read the file to find the highest existing ID number
                    BufferedReader reader = new BufferedReader(new FileReader(file));
                    String line;
                    while ((line = reader.readLine()) != null) {
                    if (line.startsWith("ID No.: 2024-")) {
                        String[] parts = line.split("-");
                        int idNumber = Integer.parseInt(parts[1]);
                        if (idNumber > lastIdNumber) {
                        lastIdNumber = idNumber;
                        }
                    }
                    }
                    reader.close();
                }
                
                // Increment the last ID number for the new entry
                int newIdNumber = lastIdNumber + 1;
        
                PrintWriter writer = new PrintWriter(new FileWriter(file, true));
                
                // Write the new entry with the incremented ID number
                writer.println("ID No.: 2024-" + String.format("%06d", newIdNumber));
                writer.println("Name: " + nameField.getText());
                writer.println("Gender: " + (maleRadioButton.isSelected() ? "Male" : "Female"));
                writer.println("Address: " + addressArea.getText());
                writer.println("Birth Date: " + birthDateField.getText());
                writer.println("Blood Type: " + bloodTypeComboBox.getSelectedItem());
                writer.println("Date Issued: " + dateIssuedField.getText());
                writer.println("Expiry Date: " + expirydateField.getText());
                writer.println();
        
                writer.close();
                
                // Display the latest ID number in the JOptionPane
                JOptionPane.showMessageDialog(frame, "Yellow Card Application Submitted\nYour ID No.: 2024-" + String.format("%06d", newIdNumber), "Application Status", JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException ex) {
                ex.printStackTrace();
                }
            }
            previewButton.setEnabled(true);
            }
        });


        // The preview button is turned off, it will turn on after the apply button is clicked
        previewButton.setEnabled(false);

        previewButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFrame frame = new JFrame("Apply for Yellow Card");
                frame.setSize(1200, 650);
                frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
                frame.setLocationRelativeTo(null);
        
                ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
                frame.setIconImage(icon.getImage());
                
                JPanel mainPanel = new JPanel() {
                    @Override
                    protected void paintComponent(Graphics g) {
                        super.paintComponent(g);
                        ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanPlainBG.png");
                        g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
                    }
                };
                mainPanel.setLayout(new BorderLayout());
        
                JPanel leftPanel = new JPanel();
                leftPanel.setLayout(new GridBagLayout());
                JLabel idLabel = new JLabel(getLatestID("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt"));
                leftPanel.add(idLabel);
        
                JPanel rightPanel = new JPanel();
                rightPanel.setLayout(new GridLayout(5, 2, 10, 10));
                
                rightPanel.add(new JLabel("Name:"));
                rightPanel.add(new JLabel(getDetail("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt", "Name")));
                
                rightPanel.add(new JLabel("Address:"));
                rightPanel.add(new JLabel(getDetail("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt", "Address")));
                
                rightPanel.add(new JLabel("Blood Type:"));
                rightPanel.add(new JLabel(getDetail("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt", "Blood Type")));
                
                rightPanel.add(new JLabel("Date Issued:"));
                rightPanel.add(new JLabel(getDetail("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt", "Date Issued")));
                
                rightPanel.add(new JLabel("Expiry Date:"));
                rightPanel.add(new JLabel(getDetail("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Saved_Details\\YellowCard.txt", "Expiry Date")));
                
                mainPanel.add(leftPanel, BorderLayout.WEST);
                mainPanel.add(rightPanel, BorderLayout.CENTER);
        
                frame.add(mainPanel);
                frame.setVisible(true);
            }
            
            // Method to get the latest line in a file
            private String getLatestLine(String filePath) {
                try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
                    String line, lastLine = "";
                    while ((line = br.readLine()) != null) {
                        lastLine = line;
                    }
                    return lastLine;
                } catch (IOException ex) {
                    ex.printStackTrace();
                    return "Error loading data";
                }
            }
            
            // Method to get the latest ID number in a file
            private String getLatestID(String filePath) {
                String latestLine = getLatestLine(filePath);
                return latestLine.split(",")[0];
            }
        
            private String getDetail(String filePath, String detailType) {
                String latestLine = getLatestLine(filePath);
                String[] details = latestLine.split(",");
                switch (detailType) {
                    case "Name":
                        return details[1]; // Assuming Name is the second value in the line
                    case "Address":
                        return details[2]; 
                    case "Blood Type":
                        return details[3]; 
                    case "Date Issued":
                        return details[4]; 
                    case "Expiry Date":
                        return details[5];
                    default:
                        return "Unknown detail";
                }
            }
        });
        


        mainPanel.add(formPanel, BorderLayout.CENTER);

        formPanel.add(nameLabel);
        formPanel.add(nameField);
        formPanel.add(genderLabel);
        formPanel.add(maleRadioButton);
        formPanel.add(new JLabel()); // Empty label to align radio buttons
        formPanel.add(femaleRadioButton);
        formPanel.add(addressLabel);
        formPanel.add(addressScrollPane); // Add scroll pane instead of text area
        formPanel.add(birthDateLabel);
        formPanel.add(birthDateField);
        formPanel.add(bloodTypeLabel);
        formPanel.add(bloodTypeComboBox);
        formPanel.add(dateIssuedLabel);
        formPanel.add(dateIssuedField);
        formPanel.add(expirydate);
        formPanel.add(expirydateField);

        southPanel.add(backButton);
        southPanel.add(clearButton);
        southPanel.add(applyButton);
        southPanel.add(previewButton);
        mainPanel.add(southPanel, BorderLayout.SOUTH);

        frame.setVisible(true);
    }

    private void BlueCard() {
        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\march-7th.gif");
        Image scaleIcon = icon.getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT);
        ImageIcon scaledIcon = new ImageIcon(scaleIcon);
        // Using HTML tags to set the message text to bold and font size 20
        String message = "<html><body><b style='font-size:20px;'>Sorry, the company ran out of budget.<br>(I need money)</b></body></html>";
    
        JOptionPane.showMessageDialog(null, message, "Senior Citizen's Blue Card", JOptionPane.INFORMATION_MESSAGE, scaledIcon);
    }
    
}

class Instructions {
    Instructions() {
        CardInstructions();
    }

    private void CardInstructions() {
        JFrame frame = new JFrame("Instructions");
        frame.setSize(800, 500);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanLogo.png");
        frame.setIconImage(icon.getImage());

        JPanel mainPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\LucbanInstructions.png");
                g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        mainPanel.setLayout(new BorderLayout());
        frame.add(mainPanel);

        frame.setVisible(true);
    }
}
 