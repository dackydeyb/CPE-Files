
import java.awt.*;
import javax.swing.*;

public class GUIActivity3 {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Composite Layout");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(350,900);
        frame.setLayout(new BorderLayout());

        JPanel northPanel = new JPanel(new FlowLayout());
        northPanel.add(new JLabel("BINGO!"));
        frame.add(northPanel, BorderLayout.NORTH);
        
        JPanel centerPanel = new JPanel(new GridLayout(16,5,5,5));

        String[] buttons = {
            "B", "I", "N", "G", "O",
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
            "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
            "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
            "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
            "51", "52", "53", "54", "55", "56", "57", "58", "59", "60",
            "61", "62", "63", "64", "65", "66", "67", "68", "69", "70",
            "71", "72", "73", "74", "75", "90"
        };

        for (int i = 0; i < buttons.length; i++) {
            centerPanel.add(new JButton(buttons[i]));
        }
        frame.add(centerPanel, BorderLayout.CENTER);
        frame.setVisible(true);
    }
}
