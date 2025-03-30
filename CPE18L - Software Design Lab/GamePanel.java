import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;

class GamePanel extends JPanel {
    private final int CELL_SIZE = 30;
    private final Color[] NUMBER_COLORS = {
        Color.BLUE, Color.GREEN, Color.RED, 
        new Color(0, 0, 128), Color.MAGENTA, 
        Color.CYAN, Color.BLACK, Color.GRAY
    };

    private int rows;
    private int cols;
    private int mineCount;
    private Cell[][] cells;
    private boolean gameActive;
    private boolean firstClick = true;
    
    private JLabel flagsLabel;
    private JLabel scoreLabel;
    private JLabel timerLabel;
    private Timer timer;
    private int seconds = 0;
    private int score = 0;
    private HighScoreManager highScoreManager;
    private int highScore;
    private Timer victoryTimer;
    private Color[] victoryColors = {Color.GREEN, Color.YELLOW, Color.PINK};
    private int colorIndex = 0;

    public GamePanel(int rows, int cols, int mineCount, HighScoreManager hsm) {
        this.rows = rows;
        this.cols = cols;
        this.mineCount = mineCount;
        this.highScoreManager = hsm;
        this.highScore = highScoreManager.getHighScore();
        initializePanel();
    }

    private void initializePanel() {
        setLayout(new BorderLayout());
        setBorder(new EmptyBorder(10, 3, 3, 3));

        // Top panel
        JPanel topPanel = new JPanel(new GridLayout(1, 3));
        flagsLabel = new JLabel("Flags: " + mineCount, SwingConstants.CENTER);
        flagsLabel.setFont(new Font("Arial", Font.BOLD, 16));
        
        scoreLabel = new JLabel("<html>Score: 0<br>High Score: " + highScore + "</html>", SwingConstants.CENTER);
        scoreLabel.setFont(new Font("Arial", Font.BOLD, 16));
        
        timerLabel = new JLabel("Time: 0", SwingConstants.CENTER);
        timerLabel.setFont(new Font("Arial", Font.BOLD, 16));

        topPanel.add(flagsLabel);
        topPanel.add(scoreLabel);
        topPanel.add(timerLabel);
        add(topPanel, BorderLayout.NORTH);

        initializeGrid();
        startTimer();
    }

    private void initializeGrid() {
        JPanel gridPanel = new JPanel(new GridLayout(rows, cols));
        cells = new Cell[rows][cols];
        
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                cells[r][c] = new Cell(r, c);
                gridPanel.add(cells[r][c]);
            }
        }
        add(gridPanel, BorderLayout.CENTER);
    }

    private void initializeMines(int safeRow, int safeCol) {
        Random random = new Random();
        int minesPlaced = 0;
        
        while (minesPlaced < mineCount) {
            int r = random.nextInt(rows);
            int c = random.nextInt(cols);
            
            if ((r == safeRow && c == safeCol) || cells[r][c].isMine) 
                continue;
            
            cells[r][c].isMine = true;
            minesPlaced++;
        }
        
        calculateAdjacentMines();
    }

    private void calculateAdjacentMines() {
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (!cells[r][c].isMine) {
                    cells[r][c].adjacentMines = countAdjacentMines(r, c);
                }
            }
        }
    }

    private int countAdjacentMines(int row, int col) {
        int count = 0;
        for (int r = -1; r <= 1; r++) {
            for (int c = -1; c <= 1; c++) {
                if (r == 0 && c == 0) continue;
                if (isValidCell(row + r, col + c) && cells[row + r][col + c].isMine) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isValidCell(int row, int col) {
        return row >= 0 && row < rows && col >= 0 && col < cols;
    }

    private void startTimer() {
        if (timer != null && timer.isRunning()) {
            timer.stop();
        }
        timer = new Timer(1000, e -> {
            seconds++;
            timerLabel.setText("Time: " + seconds);
        });
        timer.start();
    }

    private void gameOver() {
        gameActive = false;
        timer.stop();
        if (victoryTimer != null) victoryTimer.stop();
        revealAllMines();
        JOptionPane.showMessageDialog(this, "Game Over! Final Score: " + score);
    }

    private void revealAllMines() {
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (cells[r][c].isMine) {
                    cells[r][c].setBackground(Color.RED);
                    cells[r][c].setText("💣");
                    cells[r][c].isRevealed = true;
                }
            }
        }
    }

    private void checkWinCondition() {
        int revealedSafeCells = 0;
        int totalSafeCells = rows * cols - mineCount;
        
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (cells[r][c].isRevealed && !cells[r][c].isMine) {
                    revealedSafeCells++;
                }
            }
        }
        
        if (revealedSafeCells == totalSafeCells) {
            gameActive = false;
            timer.stop();
            score += calculateScore();
            
            if (score > highScore) {
                highScore = score;
                highScoreManager.saveHighScore(highScore);
                scoreLabel.setText("<html>Score: " + score + "<br>High Score: " + highScore + "</html>");
            }
            
            startVictoryAnimation();
            JOptionPane.showMessageDialog(this, 
                "<html>You Win!<br>Score: " + score + 
                "<br>High Score: " + highScore + 
                "<br>Time: " + seconds + "s</html>");
            victoryTimer.stop();
        }
    }

    private void startVictoryAnimation() {
        victoryTimer = new Timer(200, e -> {
            for (int r = 0; r < rows; r++) {
                for (int c = 0; c < cols; c++) {
                    if (!cells[r][c].isMine) {
                        cells[r][c].setBackground(victoryColors[colorIndex]);
                    }
                }
            }
            colorIndex = (colorIndex + 1) % victoryColors.length;
        });
        victoryTimer.start();
    }

    private int calculateScore() {
        int timeBonus = Math.max(0, 1000 - seconds * 10);
        int flagBonus = mineCount * 5;
        return timeBonus + flagBonus + (rows * cols);
    }

    public void startNewGame() {
        gameActive = true;
        firstClick = true;
        seconds = 0;
        score = 0;
        highScore = highScoreManager.getHighScore();
        
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                cells[r][c].reset();
            }
        }
        
        flagsLabel.setText("Flags: " + mineCount);
        scoreLabel.setText("<html>Score: 0<br>High Score: " + highScore + "</html>");
        timerLabel.setText("Time: 0");
        startTimer();
    }

    private class Cell extends JButton {
        int row;
        int col;
        boolean isMine;
        boolean isRevealed;
        boolean isFlagged;
        int adjacentMines;
        private Color defaultBackground;

        public Cell(int row, int col) {
            this.row = row;
            this.col = col;
            setPreferredSize(new Dimension(CELL_SIZE, CELL_SIZE));
            setFont(new Font("Arial", Font.BOLD, 16));
            setOpaque(true);
            setBorder(BorderFactory.createLineBorder(Color.DARK_GRAY));
            setRolloverEnabled(false);
            defaultBackground = getBackground();
            
            addMouseListener(new MouseAdapter() {
                @Override
                public void mousePressed(MouseEvent e) {
                    if (!gameActive) return;
                    
                    if (SwingUtilities.isRightMouseButton(e)) {
                        toggleFlag();
                    } else if (!isFlagged) {
                        reveal();
                    }
                }

                @Override
                public void mouseEntered(MouseEvent e) {
                    if (!isRevealed && !isFlagged) {
                        setBackground(defaultBackground.brighter());
                    }
                }

                @Override
                public void mouseExited(MouseEvent e) {
                    if (!isRevealed && !isFlagged) {
                        setBackground(defaultBackground);
                    }
                }
            });
        }

        public void reset() {
            isMine = false;
            isRevealed = false;
            isFlagged = false;
            adjacentMines = 0;
            setText("");
            setEnabled(true);
            setBackground(defaultBackground);
        }

        private void toggleFlag() {
            if (!isRevealed) {
                int currentFlags = Integer.parseInt(flagsLabel.getText().split(": ")[1]);
                if (isFlagged) {
                    isFlagged = false;
                    setText("");
                    flagsLabel.setText("Flags: " + (currentFlags + 1));
                } else if (currentFlags > 0) {
                    isFlagged = true;
                    setText("Bomba For Sure");
                    flagsLabel.setText("Flags: " + (currentFlags - 1));
                }
            }
        }

        private void reveal() {
            if (isRevealed || isFlagged) return;
            
            if (firstClick) {
                firstClick = false;
                initializeMines(row, col);
                if (isMine) {
                    moveMine();
                    calculateAdjacentMines();
                }
            }
            
            isRevealed = true;
            setEnabled(false);
            
            if (isMine) {
                gameOver();
                return;
            }
            
            if (adjacentMines > 0) {
                setText(String.valueOf(adjacentMines));
                setForeground(NUMBER_COLORS[adjacentMines - 1]);
            } else {
                revealAdjacentCells();
            }
            
            checkWinCondition();
        }

        private void moveMine() {
            Random rand = new Random();
            while (true) {
                int r = rand.nextInt(rows);
                int c = rand.nextInt(cols);
                if (!cells[r][c].isMine && (r != row || c != col)) {
                    cells[r][c].isMine = true;
                    this.isMine = false;
                    break;
                }
            }
        }

        private void revealAdjacentCells() {
            for (int r = -1; r <= 1; r++) {
                for (int c = -1; c <= 1; c++) {
                    if (r == 0 && c == 0) continue;
                    if (isValidCell(row + r, col + c)) {
                        Cell neighbor = cells[row + r][col + c];
                        if (!neighbor.isRevealed && !neighbor.isFlagged) {
                            neighbor.reveal();
                        }
                    }
                }
            }
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            if (isRevealed) {
                setBackground(Color.LIGHT_GRAY);
            } else {
                setBackground(defaultBackground);
            }
        }
    }
}