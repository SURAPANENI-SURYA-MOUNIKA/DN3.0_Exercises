package singletonpattern;
import java.util.Scanner;
public class LoggerMain {
	
	public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);
	        
	        Logger logger1 = Logger.getInstance();
	        Logger logger2 = Logger.getInstance();

	        while (true) {
	            System.out.print("Enter a log message (or type 'exit' to quit): ");
	            String message = scanner.nextLine();

	            if (message.equalsIgnoreCase("exit")) {
	                break;
	            }

	            logger1.log(message);
	        }

	        if (logger1 == logger2) {
	            System.out.println("logger1 and logger2 are in same instance.");
	        } else {
	            System.out.println("logger1 and logger2 are in different instances.");
	        }

	        scanner.close();
	        System.out.println("Logger test has completed.");
	    }
	}
