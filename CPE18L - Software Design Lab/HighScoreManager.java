import java.io.*;

public class HighScoreManager {
    private static final String HIGH_SCORE_FILE = "highscore.dat";

    public void saveHighScore(int score) {
        try (DataOutputStream dos = new DataOutputStream(new FileOutputStream(HIGH_SCORE_FILE))) {
            dos.writeInt(score);
        } catch (IOException e) {
            System.err.println("Error saving high score: " + e.getMessage());
        }
    }

    public int getHighScore() {
        File file = new File(HIGH_SCORE_FILE);
        if (!file.exists()) return 0;
        
        try (DataInputStream dis = new DataInputStream(new FileInputStream(HIGH_SCORE_FILE))) {
            return dis.readInt();
        } catch (IOException e) {
            System.err.println("Error reading high score: " + e.getMessage());
            return 0;
        }
    }
}