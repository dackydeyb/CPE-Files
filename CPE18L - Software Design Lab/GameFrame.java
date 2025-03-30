import javax.swing.*;
import java.awt.*;

class GameFrame extends JFrame {
    private GamePanel gamePanel;
    private HighScoreManager highScoreManager;

    public GameFrame() {
        setTitle("Minesweeper v2");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        highScoreManager = new HighScoreManager();
        initializeUI();
        pack();
        setLocationRelativeTo(null);
    }

    private void initializeUI() {
        JMenuBar menuBar = new JMenuBar();
        JMenu gameMenu = new JMenu("Game");
        
        JMenuItem newGameItem = new JMenuItem("New Game");
        newGameItem.addActionListener(e -> restartGame());
        
        JMenuItem beginnerItem = new JMenuItem("Beginner");
        beginnerItem.addActionListener(e -> setDifficulty(8, 8, 10));
        
        JMenuItem intermediateItem = new JMenuItem("Intermediate");
        intermediateItem.addActionListener(e -> setDifficulty(16, 16, 40));
        
        JMenuItem expertItem = new JMenuItem("Expert");
        expertItem.addActionListener(e -> setDifficulty(24, 24, 99));

        gameMenu.add(newGameItem);
        gameMenu.addSeparator();
        gameMenu.add(beginnerItem);
        gameMenu.add(intermediateItem);
        gameMenu.add(expertItem);
        menuBar.add(gameMenu);
        setJMenuBar(menuBar);

        gamePanel = new GamePanel(16, 16, 40, highScoreManager);
        add(gamePanel);
    }

    private void setDifficulty(int rows, int cols, int mines) {
        getContentPane().removeAll();
        gamePanel = new GamePanel(rows, cols, mines, highScoreManager);
        add(gamePanel);
        restartGame();
    }

    private void restartGame() {
        gamePanel.startNewGame();
        revalidate();
        repaint();
    }
}