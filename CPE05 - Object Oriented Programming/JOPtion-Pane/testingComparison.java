import javax.swing.JOptionPane;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;

public class testingComparison {
    public static void main(String [] args) {
        
        String s1 = "Hello";
        String s2 = "hello";

        int out = s1.compareTo(s2);
        System.out.println(out);

        // Display a message dialog box
        JOptionPane.showMessageDialog(null, "Java".equals("java"));

        // Create a JDesktopPane and JInternalFrame for the internal dialog
        JDesktopPane desktopPane = new JDesktopPane();
        JInternalFrame internalFrame = new JInternalFrame();

        // Add the internal frame to the desktop pane
        desktopPane.add(internalFrame);

        // Display an internal confirm dialog box
        int x = JOptionPane.showInternalConfirmDialog(internalFrame, s2, "Confirm", JOptionPane.YES_NO_OPTION);
        
        System.out.println(x);
    }
}