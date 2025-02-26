
// Activity 15: Images (Image Icon and Buffer Image)

// Write a program of a layout of any Microsoft Office Application. Create the 
// MenuBar "File" only and incorporate images for different Menu and MenuItem. Use text 
// area with scroll for the body. (Note: you can crop images from the application menu)

import javax.swing.*;
import java.awt.image.*;
import java.awt.*;

public class GUIActivity_15_Images {
    public static void main(String[] args) {
        // Set the frame icon
        ImageIcon icon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/MS_Publisher_(2019).png");
        JFrame frame = new JFrame();
        frame.setTitle("Microsoft Publisher 2007");
        frame.setIconImage(icon.getImage());
        frame.setSize(800, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        // Create the menu bar
        JMenuBar menuBar = new JMenuBar();

        // Create the "File" menu
        JMenu fileMenu = new JMenu("File");

        // Create the menu items with images
        ImageIcon newIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_NEW.png");
        JMenuItem newItem = new JMenuItem("   New...                                                        Crtl + N", newIcon);

        ImageIcon openIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_OPEN.png");
        JMenuItem openItem = new JMenuItem("   Open...                                                      Ctrl + O", openIcon);

        ImageIcon closeIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_CLOSE.png");
        JMenuItem closeItem = new JMenuItem("   Close...                                                    Ctrl + F4", closeIcon);

        JMenuItem importItem = new JMenuItem("   Import Word Document...");

        ImageIcon saveIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_SAVE.png");
        JMenuItem saveItem = new JMenuItem("   Save                                                          Ctrl + S", saveIcon);

        ImageIcon saveAsIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_SAVE_AS.png");
        JMenuItem saveAsItem = new JMenuItem("   Save As...", saveAsIcon);

        ImageIcon publishToWeb = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_WEB.png");
        JMenuItem publishToWebItem = new JMenuItem("   Publish to tge Web...", publishToWeb);

        JMenu subPackAndGoSub = new JMenu("   Pack and Go");
            JMenuItem takeToAnotherComputer = new JMenuItem("   Take to Another Computer...");
            JMenuItem takeToACommercialPrintingService = new JMenuItem("   Take to a Commercial Printing Service...");
            subPackAndGoSub.add(takeToAnotherComputer);
            subPackAndGoSub.add(takeToACommercialPrintingService);

        JMenuItem convertItem = new JMenuItem("   Convert to Web Publication...");

        ImageIcon findAddInsIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_ADDINS.png");
        JMenuItem findAddInsItem = new JMenuItem("   Find add-ins for other file formats...", findAddInsIcon);
        
        ImageIcon webPagePreviewIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_WEBPREVIEW.png");
        JMenuItem webPagePreviewItem = new JMenuItem("   Web Page Preview", webPagePreviewIcon);

        JMenuItem pageSetUpItem = new JMenuItem("   Page Setup...");

        ImageIcon printSetUpIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_PRINTSETUP.png");
        JMenuItem printSetUpItem = new JMenuItem("   Print Setup...", printSetUpIcon);

        ImageIcon printPreviewIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_PRINTPREVIEW.png");
        JMenuItem printPreviewItem = new JMenuItem("   Print Preview", printPreviewIcon);

        ImageIcon printIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_PRINT.png");
        JMenuItem printItem = new JMenuItem("   Print...                                                        Ctrl + P", printIcon);

        JMenu subEmail = new JMenu("   Send E-mail");
            ImageIcon sendPublicationAsAttachmentIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_EMAIL.png");
            JMenuItem sendPublicationAsAttachmentItem = new JMenuItem("   Send Publication as Attachment", sendPublicationAsAttachmentIcon);
            subEmail.add(sendPublicationAsAttachmentItem);

        BufferedImage propertiesImage = new BufferedImage(16, 16, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = propertiesImage.createGraphics();
        g2d.setColor(Color.YELLOW);
        int[] xPoints = {8, 0, 16};
        int[] yPoints = {0, 16, 16};
        Polygon triangle = new Polygon(xPoints, yPoints, 3);
        g2d.fill(triangle);
        g2d.dispose();
        JMenuItem propertiesItem = new JMenuItem("   Properties", new ImageIcon(propertiesImage));

        ImageIcon exitIcon = new ImageIcon("/home/deyb/Documents/Java OOP/Pictures/Publisher_EXIT.png");
        JMenuItem exitItem = new JMenuItem("   Exit                                                            Alt + F4", exitIcon);

        // Add the menu items to the "File" menu
        fileMenu.add(newItem);
        fileMenu.add(openItem);
        fileMenu.add(closeItem);
        fileMenu.add(importItem);
        fileMenu.addSeparator();
        fileMenu.add(saveItem);
        fileMenu.add(saveAsItem);
        fileMenu.add(publishToWebItem);
        fileMenu.add(subPackAndGoSub);
        fileMenu.addSeparator();
        fileMenu.add(convertItem);
        fileMenu.add(findAddInsItem);
        fileMenu.addSeparator();
        fileMenu.add(webPagePreviewItem);
        fileMenu.addSeparator();
        fileMenu.add(pageSetUpItem);
        fileMenu.add(printSetUpItem);
        fileMenu.add(printPreviewItem);
        fileMenu.add(printItem);
        fileMenu.addSeparator();
        fileMenu.add(subEmail);
        fileMenu.add(propertiesItem);
        fileMenu.addSeparator();
        fileMenu.add(exitItem);

        // Add the "File" menu to the menu bar
        menuBar.add(fileMenu);

        // Create the text area with scroll
        JTextArea textArea = new JTextArea();
        JScrollPane scrollPane = new JScrollPane(textArea);

        // Add the scroll pane to the frame
        frame.getContentPane().add(scrollPane);

        // Set the menu bar for the frame
        frame.setJMenuBar(menuBar);

        // Make the frame visible
        frame.setVisible(true);
    }
}
