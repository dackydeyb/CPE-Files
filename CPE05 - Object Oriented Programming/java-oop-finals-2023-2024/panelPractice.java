import javax.swing.*;
import java.awt.*;

public class panelPractice {
    public static void main(String[] args) {
        JFrame frame = new JFrame();
        frame.setSize(1200, 650);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        // Create the main panel with a background image
        JPanel mainPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\Male_Preview_YellowCard.png");
            g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        mainPanel.setLayout(new BorderLayout());
        frame.setContentPane(mainPanel);

        JPanel leftPanel = new JPanel(new GridLayout(1, 2));
        leftPanel.setOpaque(false); 
        leftPanel.setBorder(BorderFactory.createEmptyBorder(480, 270, 0, 30));
        JLabel IDNoLabel = new JLabel("ID No: ");
        IDNoLabel.setFont(new Font("Arial", Font.BOLD, 20));
        leftPanel.add(IDNoLabel);

        JPanel rightPanel = new JPanel(new GridLayout(6, 1));
        rightPanel.setOpaque(false); 
        rightPanel.setBorder(BorderFactory.createEmptyBorder(200, 30, 100, 270));

        JLabel nameLabel = new JLabel("Name: ");
        nameLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField nameTextField = new JTextField();
        nameTextField.setOpaque(false); // Ensure the text field is transparent

        JLabel addressLabel = new JLabel("Address: ");
        addressLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField addressTextField = new JTextField();
        addressTextField.setOpaque(false); // Ensure the text field is transparent

        JLabel birthdateLabel = new JLabel("Birthdate: ");
        birthdateLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField birthdateTextField = new JTextField();
        birthdateTextField.setOpaque(false); // Ensure the text field is transparent

        JLabel bloodtypeLabel = new JLabel("Blood Type: ");
        bloodtypeLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField bloodtypeTextField = new JTextField();
        bloodtypeTextField.setOpaque(false); // Ensure the text field is transparent

        JLabel dateIssuedLabel = new JLabel("Date Issued: ");
        dateIssuedLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField dateIssuedTextField = new JTextField();
        dateIssuedTextField.setOpaque(false); // Ensure the text field is transparent

        JLabel dateExpiryLabel = new JLabel("Date Expiry: ");
        dateExpiryLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        JTextField dateExpiryTextField = new JTextField();
        dateExpiryTextField.setOpaque(false); // Ensure the text field is transparent

        rightPanel.add(nameLabel);
        rightPanel.add(nameTextField);
        rightPanel.add(addressLabel);
        rightPanel.add(addressTextField);
        rightPanel.add(birthdateLabel);
        rightPanel.add(birthdateTextField);
        rightPanel.add(bloodtypeLabel);
        rightPanel.add(bloodtypeTextField);
        rightPanel.add(dateIssuedLabel);
        rightPanel.add(dateIssuedTextField);
        rightPanel.add(dateExpiryLabel);
        rightPanel.add(dateExpiryTextField);

        // Group the left and right Panel
        JPanel centerPanel = new JPanel(new GridLayout(1, 2));
        centerPanel.setOpaque(false); // Ensure the panel is transparent
        centerPanel.add(leftPanel);
        centerPanel.add(rightPanel);

        mainPanel.add(centerPanel, BorderLayout.CENTER);

        frame.setVisible(true);
    }
}
 