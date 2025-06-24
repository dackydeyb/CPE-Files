

import javax.swing.*;
import java.awt.*;

public class GUIActivity_13_RegistrationRegistration_Form {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Registration Form");
        frame.setSize(900, 900);
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //change the image of the frame
        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\Pictures\\March 7th_6.png");
        frame.setIconImage(icon.getImage());

        JPanel panel = new JPanel(new BorderLayout());

        JPanel labelPanel = new JPanel(new GridLayout(5, 1)); // 4 rows, 1 column
        labelPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // Add some padding
        labelPanel.setBackground(new Color(144, 238, 144));

        JLabel titleLabel = new JLabel("Registration Form");
        titleLabel.setHorizontalAlignment(JLabel.CENTER); 
        titleLabel.setFont(new Font("Arial", Font.BOLD, 15));
        labelPanel.add(titleLabel);

        JLabel subTitleLabel = new JLabel("Souther Luzon State University");
        subTitleLabel.setHorizontalAlignment(JLabel.CENTER); 
        subTitleLabel.setFont(new Font("Arial", Font.BOLD, 15));
        labelPanel.add(subTitleLabel);

        JLabel subTitleLabel2 = new JLabel("College of Engineering");
        subTitleLabel2.setHorizontalAlignment(JLabel.CENTER); 
        subTitleLabel2.setFont(new Font("Arial", Font.BOLD, 15));
        labelPanel.add(subTitleLabel2);

        JLabel subTitleLabel3 = new JLabel("Computer Engineering Department");
        subTitleLabel3.setHorizontalAlignment(JLabel.CENTER); 
        subTitleLabel3.setFont(new Font("Arial", Font.BOLD, 15));
        labelPanel.add(subTitleLabel3);

        JLabel subTitleLabel4 = new JLabel("Student Account Creation");
        subTitleLabel4.setHorizontalAlignment(JLabel.CENTER); 
        subTitleLabel4.setFont(new Font("Arial", Font.BOLD, 30));
        labelPanel.add(subTitleLabel4);

        JPanel formPanel = new JPanel(new GridLayout(8, 2, -90, 25));
        formPanel.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
        formPanel.setBackground(new Color(144, 238, 144));
        JPanel formPanel2 = new JPanel(new GridLayout(8, 2, -90, 25));
        formPanel2.setBorder(BorderFactory.createEmptyBorder(0, 40, 0, 0));
        formPanel2.setBackground(new Color(144, 238, 144));
        
        formPanel.add(new JLabel("User Name:"));
        formPanel.add(new JTextField(20));
        
        formPanel.add(new JLabel("Password:"));
        formPanel.add(new JPasswordField(20));
        
        formPanel.add(new JLabel("Confirm Password:"));
        formPanel.add(new JPasswordField(20));
        
        formPanel.add(new JLabel("Name:"));
        formPanel.add(new JTextField(20));
        
        JPanel yearCourseSectionPanel = new JPanel(new FlowLayout(0,11,6));
        yearCourseSectionPanel.setBorder(BorderFactory.createEmptyBorder(-4, -4, 0, 0));
        yearCourseSectionPanel.setBackground(new Color(144, 238, 144));
        String[] options = {"-- --","1st Year", "2nd Year", "3rd Year", "4th Year"};
        String[] options2 = {"-- --","CPE","ME","EE","CE"};
        String[] options3 = {"-- --","GE","GF"};
        JComboBox<String> yearCourseSectionComboBox = new JComboBox<>(options);
        JComboBox<String> yearCourseSectionComboBox2 = new JComboBox<>(options2);
        JComboBox<String> yearCourseSectionComboBox3 = new JComboBox<>(options3);
        yearCourseSectionPanel.add(yearCourseSectionComboBox);
        yearCourseSectionPanel.add(yearCourseSectionComboBox2);
        yearCourseSectionPanel.add(yearCourseSectionComboBox3);

        formPanel.add(new JLabel("Year, Course and Section"));
        formPanel.add(yearCourseSectionPanel);
        formPanel.add(new JLabel("Date of Birth:"));
        formPanel.add(new JTextField(20));
        
        formPanel.add(new JLabel("Age:"));
        formPanel.add(new JTextField(20));
        
        formPanel.add(new JLabel("Gender:"));
        JPanel genderPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JRadioButton maleRadioButton = new JRadioButton("Male");
        JRadioButton femaleRadioButton = new JRadioButton("Female");
        ButtonGroup genderGroup = new ButtonGroup();
        genderGroup.add(maleRadioButton);
        genderGroup.add(femaleRadioButton);
        genderPanel.add(maleRadioButton);
        genderPanel.add(femaleRadioButton);
        formPanel.add(genderPanel);

        formPanel2.add(new JLabel("Citizenship:"));
        formPanel2.add(new JTextField(20));
        
        formPanel2.add(new JLabel("Religion:"));
        formPanel2.add(new JTextField(20));
        
        formPanel2.add(new JLabel("Contact Number:"));
        formPanel2.add(new JTextField(20));
        
        formPanel2.add(new JLabel("Father's Name:"));
        formPanel2.add(new JTextField(20));
        
        formPanel2.add(new JLabel("Mother's Name:"));
        formPanel2.add(new JTextField(20));
    
        formPanel2.add(new JLabel("Motto:"));
        formPanel2.add(new JTextArea());
        
        formPanel2.add(new JLabel("Skills:"));
        formPanel2.add(new JTextArea());
        
        
        formPanel2.add(new JLabel("Seminars Attended:"));
        JTextArea seminarsTextArea = new JTextArea(5, 20);
        seminarsTextArea.setLineWrap(true);
        seminarsTextArea.setWrapStyleWord(true);
        JScrollPane scrollPane = new JScrollPane(seminarsTextArea);
        formPanel2.add(scrollPane);

        JPanel formContainer = new JPanel(new GridLayout(1,2,50,0));
        formContainer.setBorder(BorderFactory.createEmptyBorder(40, 50, 0, 50));
        formContainer.setBackground(new Color(144, 238, 144));
        formContainer.add(formPanel);

        formContainer.add(formPanel2);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        buttonPanel.setBorder(BorderFactory.createEmptyBorder(30, 50, 20, 50));
        buttonPanel.setBackground(new Color(144, 238, 144));
        JButton button1 = new JButton("Submit");
        JButton button2 = new JButton("Reset");
        JButton button3 = new JButton("Validate");
 
        button1.setBackground(Color.GREEN);
        button2.setBackground(Color.RED);
        button3.setBackground(Color.ORANGE);
        button1.setForeground(Color.BLACK);
        button2.setForeground(Color.BLACK);
        button3.setForeground(Color.BLACK);

        button1.setFont(new Font("Arial", Font.BOLD, 15));
        button2.setFont(new Font("Arial", Font.BOLD, 15));
        button3.setFont(new Font("Arial", Font.BOLD, 15));

        buttonPanel.add(button1);
        buttonPanel.add(button2);
        buttonPanel.add(button3);

        panel.add(labelPanel, BorderLayout.NORTH);
        panel.add(formContainer, BorderLayout.CENTER);
        panel.add(buttonPanel, BorderLayout.SOUTH);

        frame.add(panel);

        frame.setVisible(true);
    }
}