import java.util.Scanner;

public class StringClass {
    public static void main(String[] args) {
        Verifyaccount meta = new Verifyaccount();
        meta.verifyaccountDetails();
    }
}

class Person {
    protected String name = "Dave Jhared G. Paduada";
    protected String birthday = "11-07-2003";
    protected String gender = "Male";
    protected String maritalstatus = "Single";
    protected String age = "20";
}

class Verifyaccount extends Person {
    private Scanner scanner = new Scanner(System.in);
    
    public void verifyaccountDetails() {
        System.out.print("-- Java Account Verification --\n\n");
        
        if (cName() && cBirthday() && cGender() && cMaritalstatus() && cAge()) {
            System.out.println("\n-- Account verified successfully!  --");
        }
    }
    
    private boolean cName() {
        return vDetail("What is your name? ", name);
    }
    
    private boolean cBirthday() {
        return vDetail("What is your birthday? (MM-DD-YYYY) ", birthday);
    }
    
    private boolean cGender() {
        return vDetail("What is your gender? ", gender);
    }
    
    private boolean cMaritalstatus() {
        return vDetail("What is your marital status? ", maritalstatus);
    }
    
    private boolean cAge() {
        return vDetail("What is your age? ", age);
    }
    
    private boolean vDetail(String question, String correct) {
        for (int attempts = 0; attempts < 3; attempts++) {
            System.out.print(question);
            
            String input = scanner.nextLine();
            if (input.equalsIgnoreCase(correct)) {
                return true;
            } else {
                if (attempts < 2) {
                    System.out.println("Incorrect, please try again.\n");
                }
            }
        }
        
        System.out.println("Failed. Try again after 30 minutes.");
        return false;
    }
}

