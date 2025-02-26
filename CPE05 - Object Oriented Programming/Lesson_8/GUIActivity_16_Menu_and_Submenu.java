// Activity 16: Menu and Submenu

// Write a program of Layyout f a Notepad, all 
// of it's menu, sub menu and a text area with scroll.
import javax.swing.*;

public class GUIActivity_16_Menu_and_Submenu {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Notepad");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 300);
        frame.setLocationRelativeTo(null);

        // Create the menu bar
        JMenuBar menuBar = new JMenuBar();

        // Create the File menu
        JMenu fileMenu = new JMenu("File");
        JMenuItem newMenuItem = new JMenuItem("          New                                Crtl+N     ");
        JMenuItem newWindodowMenuItem = new JMenuItem("          New Window     Crtl+Shift+N     ");
        JMenuItem openMenuItem = new JMenuItem("          Open...                           Crtl+O     ");
        JMenuItem saveMenuItem = new JMenuItem("          Save                              Crtl+S     ");
        JMenuItem saveAsMenuItem = new JMenuItem("          Save As...          Crtl+Shift+S     ");
        JMenuItem pageSetUpMenuItem = new JMenuItem("          Page Setup...");
        JMenuItem printMenuItem = new JMenuItem("          Print...                         Crtl+P     ");
        JMenuItem exitMenuItem = new JMenuItem("          Exit");
        fileMenu.add(newMenuItem);
        fileMenu.add(newWindodowMenuItem);
        fileMenu.add(openMenuItem);
        fileMenu.add(saveMenuItem);
        fileMenu.add(saveAsMenuItem);
        fileMenu.addSeparator();
        fileMenu.add(pageSetUpMenuItem);
        fileMenu.add(printMenuItem);
        fileMenu.addSeparator();
        fileMenu.add(exitMenuItem);

        // Create the Edit menu
        JMenu editMenu = new JMenu("Edit");
        JMenuItem undoMenuItem = new JMenuItem("          Undo                                         Crtl+Z     ");
        JMenuItem cutMenuItem = new JMenuItem("          Cut                                            Crtl+X     ");
        JMenuItem copyMenuItem = new JMenuItem("          Copy                                         Crtl+C     ");
        JMenuItem pasteMenuItem = new JMenuItem("          Paste                                       Crtl+V     ");
        JMenuItem deleteMenuItem = new JMenuItem("          Delete                                           Del     ");
        JMenuItem searchWithBingMenuItem = new JMenuItem("          Search with Bing...               Crtl+E     ");
        JMenuItem findMenuItem = new JMenuItem("          Find...                                       Crtl+F     ");
        JMenuItem findNextMenuItem = new JMenuItem("          Find Next                                       F3     ");
        JMenuItem findPreviousMenuItem = new JMenuItem("          Find Previous                    Shift+F3     ");
        JMenuItem replaceMenuItem = new JMenuItem("          Replace...                              Crtl+H     ");
        JMenuItem goToMenuItem = new JMenuItem("          Go To...                                   Crtl+G     ");
        JMenuItem selectAllMenuItem = new JMenuItem("          Select All                               Crtl+A     ");
        JMenuItem timeDateMenuItem = new JMenuItem("          Time/Date                                     F5     ");

        editMenu.add(undoMenuItem);
        editMenu.addSeparator();
        editMenu.add(cutMenuItem);
        editMenu.add(copyMenuItem);
        editMenu.add(pasteMenuItem);
        editMenu.add(deleteMenuItem);
        editMenu.addSeparator();
        editMenu.add(searchWithBingMenuItem);
        editMenu.add(findMenuItem);
        editMenu.add(findNextMenuItem);
        editMenu.add(findPreviousMenuItem);
        editMenu.add(replaceMenuItem);
        editMenu.add(goToMenuItem);
        editMenu.addSeparator();
        editMenu.add(selectAllMenuItem);
        editMenu.add(timeDateMenuItem);

        // Create the Format menu
        JMenu formatMenu = new JMenu("Format");
        JMenuItem wordWrapMenuItem = new JMenuItem("          Word Wrap          ");
        JMenuItem fontMenuItem = new JMenuItem("          Font          ");
        formatMenu.add(wordWrapMenuItem);
        formatMenu.add(fontMenuItem);

        // Create the View menu
        JMenu view = new JMenu("View");
        JMenu zoomSubMenu = new JMenu("     Zoom          ");
            JMenuItem zoomInMenuItem = new JMenuItem("          Zoom In                                        Crtl+Plus     ");
            JMenuItem zoomOutMenuItem = new JMenuItem("          Zoom Out                                  Crtl+Minus     ");
            JMenuItem restoreDefaultZoomMenuItem = new JMenuItem("          Restore Default Zoom                    Crtl+0     ");
            zoomSubMenu.add(zoomInMenuItem);
            zoomSubMenu.add(zoomOutMenuItem);
            zoomSubMenu.add(restoreDefaultZoomMenuItem);
        JCheckBoxMenuItem statusBarMenuItem = new JCheckBoxMenuItem("    Status Bar          ");
        statusBarMenuItem.setSelected(true); // Set the status bar to be checked by default
        view.add(zoomSubMenu);
        view.add(statusBarMenuItem);

        // Add Help menu
        JMenu helpMenu = new JMenu("Help");
        JMenuItem viewHelpMenuItem = new JMenuItem("          View Help          ");
        JMenuItem sendFeedbackMenuItem = new JMenuItem("          Send Feedback          ");
        JMenuItem aboutNotepadMenuItem = new JMenuItem("          About Notepad          ");
        helpMenu.add(viewHelpMenuItem);
        helpMenu.add(sendFeedbackMenuItem);
        helpMenu.addSeparator();
        helpMenu.add(aboutNotepadMenuItem);

        // Add menus to the menu bar
        menuBar.add(fileMenu);
        menuBar.add(editMenu);
        menuBar.add(formatMenu);
        menuBar.add(view);
        menuBar.add(helpMenu);

        // Create the text area with scroll
        JTextArea textArea = new JTextArea();
        JScrollPane scrollPane = new JScrollPane(textArea);

        // Add the menu bar and text area to the frame
        frame.setJMenuBar(menuBar);
        frame.add(scrollPane);

        // Display the frame
        frame.setVisible(true);
    }
}
