// Key Events

// Smaple Program 1

import java.awt.event.*;
import javax.swing.*;
import java.awt.*;

public class GUIActivity5 {
    public static void main (String [] args) {
        new MenuSample();
    }
}

class MenuSample extends JFrame {

    private JLabel statusbar;

    public MenuSample() {
        setTitle("Menu and Submennu");
        JMenuBar menubar = new JMenuBar();

        JMenu file = new JMenu("File");
        file.setMnemonic(KeyEvent.VK_F);

        JMenu imp = new JMenu ("Import");
        imp.setMnemonic(KeyEvent.VK_M);

        JMenuItem newf = new JMenuItem ("Import newsfeed list...");
        JMenuItem bookm = new JMenuItem ("Import bookmarks...");
        JMenuItem mail = new JMenuItem ("Import mail...");

        imp.add(newf);
        imp.add(bookm);
        imp.add(mail);

        /* JMenuItem fileNew = new JMenuItem("New", KeyEvent.VK_N); */
        JMenuItem fileNew = new JMenuItem("New");
        fileNew.setMnemonic(KeyEvent.VK_N);
        JMenuItem fileOpen = new JMenuItem ("Open");
        fileNew.setMnemonic(KeyEvent.VK_O);
        JMenuItem fileSave = new JMenuItem ("Save");
        fileNew.setMnemonic(KeyEvent.VK_S);
        JMenuItem fileClose = new JMenuItem("Close");
        fileClose.setMnemonic(KeyEvent.VK_C);
        fileClose.setToolTipText ("Exit Application");

        fileClose.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_W, ActionEvent.CTRL_MASK));
        fileClose.addActionListener(new ActionListener () {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        JMenu view = new JMenu ("View");
        view.setMnemonic(KeyEvent.VK_V);

        JCheckBoxMenuItem sbar = new JCheckBoxMenuItem("Show StatusBar");
        sbar.setState(true);
        sbar.addActionListener (new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                if (statusbar.isVisible()) {
                    statusbar.setVisible(false);
                } else {
                    statusbar.setVisible(true);
                }
            }
        });

        file.add(fileNew);
        file.add(fileOpen);
        file.add(fileSave);
        file.addSeparator();
        file.add(imp);
        file.addSeparator();
        file.add(fileClose);
        menubar.add(file);
        view.add(sbar);
        menubar.add(file);
        menubar.add(view);
        setJMenuBar(menubar);
        statusbar = new JLabel("Statusbar");
        statusbar.setBorder(BorderFactory.createEtchedBorder());
        add(statusbar, BorderLayout.SOUTH);
        setSize(360, 250);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setVisible(true);
    }
}