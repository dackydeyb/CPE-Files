import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class MainPage {
    public static void main(String[] args) {
        JFrame frame = new JFrame("FocusMaster");
        frame.setSize(1200, 650);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        ImageIcon icon = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\9_Clara.png");
        frame.setIconImage(icon.getImage());

        // Create the main panel with a background image
        JPanel mainPanel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\background.png");
                g.drawImage(backgroundImage.getImage(), 0, 0, getWidth(), getHeight(), this);
            }
        };
        mainPanel.setLayout(new BorderLayout());
        frame.add(mainPanel);

        // North panel for the title
        JPanel northDisplayPanel = new JPanel(new GridLayout(1, 1));
        northDisplayPanel.setOpaque(false); // Make it transparent

        ImageIcon northBackgroundImage = new ImageIcon("CPE05 - Object Oriented Programming\\java-oop-finals-2023-2024\\Pictures\\title.png");
        JLabel northBackgroundLabel = new JLabel(northBackgroundImage);
        northDisplayPanel.setBorder(BorderFactory.createEmptyBorder(70, 0, 0, 0));
        northDisplayPanel.add(northBackgroundLabel);

        // Center panel for buttons
        JPanel centerDisplayPanel = new JPanel(new GridLayout(5, 1, 0, 10));
        centerDisplayPanel.setOpaque(false); // Make it transparent
        centerDisplayPanel.setBorder(BorderFactory.createEmptyBorder(90, 500, 90, 500));

        // Add buttons to center panel
        CustomButton startButton = new CustomButton("Start");
        CustomButton instButton = new CustomButton("Instructions");
        CustomButton howToButton = new CustomButton("How To");
        CustomButton creditsButton = new CustomButton("Credits");
        CustomButton exitButton = new CustomButton("Exit");

        centerDisplayPanel.add(startButton);
        centerDisplayPanel.add(instButton);
        centerDisplayPanel.add(howToButton);
        centerDisplayPanel.add(creditsButton);
        centerDisplayPanel.add(exitButton);

        // Add action listeners to buttons
        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new MainApplication().setVisible(true);
            }
        });


        exitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        mainPanel.add(northDisplayPanel, BorderLayout.NORTH);
        mainPanel.add(centerDisplayPanel, BorderLayout.CENTER);

        frame.setVisible(true);
    }
}

// Button Design
class CustomButton extends JButton {
    private static final Color EdgeColor = new Color(0, 100, 0); // Dark green
    private static final Color FillColor = new Color(0,216,58); // Grass green
    private static final Color HoverColor = new Color(173, 255, 47); // Light green glossy effect

    private boolean hovered = false;

    public CustomButton(String text) {
        super(text);
        setContentAreaFilled(false);
        setFocusPainted(false);
        setForeground(new Color(93,68,29));
        setFont(new Font("Arial", Font.BOLD, 16));

        addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                hovered = true;
                repaint();
            }

            @Override
            public void mouseExited(MouseEvent e) {
                hovered = false;
                repaint();
            }
        });
    }

    @Override
    protected void paintComponent(Graphics color) {
        Graphics2D buttonColor = (Graphics2D) color.create();
        int width = getWidth();
        int height = getHeight();

        // Draw the edges
        buttonColor.setColor(EdgeColor);
        buttonColor.fillRoundRect(0, 0, width, height, 20, 20);

        // Draw the fill
        if (hovered) {
            buttonColor.setColor(HoverColor);
        } else {
            buttonColor.setColor(FillColor);
        }
        buttonColor.fillRoundRect(2, 2, width - 4, height - 4, 18, 18);

        // Draw glossy effect when hovered
        if (hovered) {
            GradientPaint glossy = new GradientPaint(0, 0, new Color(255, 255, 255, 128), 0, height / 2, new Color(255, 255, 255, 0));
            buttonColor.setPaint(glossy);
            buttonColor.fillRoundRect(2, 2, width - 4, height / 2 - 2, 18, 18);
        }

        super.paintComponent(buttonColor);
        buttonColor.dispose();
    }

    @Override
    protected void paintBorder(Graphics g) {
        // Will not paint the border
    }
}



class MainApplication extends JFrame {

    public MainApplication() {
        setTitle("ADHD Management Application");
        setSize(1200, 650);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new GridLayout(4, 1, 10, 10));

        JButton taskReminderButton = new JButton("Task and Reminder System");
        JButton timerAlertsButton = new JButton("Timer and Alerts");
        JButton noteTakingButton = new JButton("Note-taking Interface");
        JButton habitTrackerButton = new JButton("Habit Tracker");

        mainPanel.add(taskReminderButton);
        mainPanel.add(timerAlertsButton);
        mainPanel.add(noteTakingButton);
        mainPanel.add(habitTrackerButton);

        add(mainPanel);

        // Action Listeners
        /* taskReminderButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new TaskReminderSystem().setVisible(true);
            }
        });

        timerAlertsButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new TimerAlerts().setVisible(true);
            }
        });

        noteTakingButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new NoteTakingInterface().setVisible(true);
            }
        });

        habitTrackerButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new HabitTracker().setVisible(true);
            }
        }); */
    }
}