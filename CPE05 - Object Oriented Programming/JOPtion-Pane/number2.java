import java.io.File;
import java.io.PrintWriter;
import java.util.Scanner;

public class number2 {
	public static void main(String[]args) throws Exception {
	
	  File firstFile = new File("stuff1.txt");
	    Scanner input = new Scanner(firstFile);
	      String operatingSysName = input.next();
	      String versionNumber = input.next();
	      String ownerNameFirst = input.next();
	      String ownerNameMiddle = input.next();
	      String ownerNameLast = input.next();
	      
	      input.close();
	    
	  
	  File secondFile = new File ("stuff2.txt");
	  
	  while (secondFile.exists()) {
	    System.out.print("File already exists");
      System.exit(0);
	  }
	      
	      PrintWriter output = new PrintWriter(secondFile);
          
          output.print(operatingSysName + "\n");
          output.print(versionNumber + "\n");
          output.print(ownerNameFirst + " \n");
          output.print(ownerNameMiddle + " \n");
          output.print(ownerNameLast + " \n");
          
          output.close();
	      }
	}
