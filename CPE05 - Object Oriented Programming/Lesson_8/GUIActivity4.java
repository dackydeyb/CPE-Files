// Menu and MenuItem Example

import javax.swing.*;

public class GUIActivity4 {
    public static void main(String[] args) {
        new MenuExample();
    }
}

class MenuExample {
    
        JMenu menu, submenu, subsubmenu;
        JMenuItem i1, i2, i3, i4, i5, i6, i7, sub1, sub2, sub3, sub4, sub5;

        MenuExample() {
            JFrame f = new JFrame ("Menu and MenuItem Example");
            f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            // Menu Bar
            JMenuBar mb = new JMenuBar();
            menu = new JMenu("Menu");
            subsubmenu = new JMenu ("Sub-Sub-Menu");

            i1 = new JMenuItem("M");
            i2 = new JMenuItem("I");
            i3 = new JMenuItem("L");
            submenu = new JMenu("F");
                i4 = new JMenuItem("Man");
                i5 = new JMenuItem("I");
                i6 = new JMenuItem("Love");
                i7 = new JMenuItem("Firefly");
            menu.add(i1);
            menu.add(i2);
            menu.add(i3);
            menu.add(submenu);
                submenu.add(i4);
                submenu.add(i5);
                submenu.add(i6);
                submenu.add(i7);

            subsubmenu = new JMenu("Sub-Sub-Menu");
            sub1 = new JMenu("Man");
            JMenu sub2 = new JMenu("I");
            JMenu sub3 = new JMenu("Love");
            JMenu sub4 = new JMenu("Firefly");
            sub5 = new JMenuItem("By Dave Jhared Paduada");

            subsubmenu.add(sub1);
            sub1.add(sub2);
            sub2.add(sub3);
            sub3.add(sub4);     
            sub4.add(sub5);

            // Add the Menu Bar
            mb.add(menu);
            mb.add(subsubmenu);

            f.setJMenuBar(mb);
            f.setSize(400, 200);
            f.setLayout(null);
            f.setVisible(true);
        }
}
