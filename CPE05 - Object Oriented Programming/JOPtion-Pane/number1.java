import java.io.File;
/* import java.io.PrintWriter; */

public class number1 {
	public static void main(String[]args) {
		File file = new File("/home/deyb/Documents/Activity");
		
		System.out.println("Does it exist? " + file.exists());
		System.out.println("Can it be read? " + file.canRead());
		System.out.println("Can it be written? " + file.canWrite());
		System.out.println("Is it a directory? " + file.isDirectory());
		System.out.println("Is it a file? " + file.isFile());
		System.out.println("Is it absolute? " + file.isAbsolute());
		System.out.println("Is it hidden? " + file.isHidden());
		System.out.println("What is its absolute path?" + file.getAbsolutePath());
		System.out.println("What is its name? " + file.getName());
		System.out.println("When was it last modified? " + new java.util.Date(file.lastModified()));
		System.out.println("What is it's length? " + file.length()+ " Gb");
	}
}
