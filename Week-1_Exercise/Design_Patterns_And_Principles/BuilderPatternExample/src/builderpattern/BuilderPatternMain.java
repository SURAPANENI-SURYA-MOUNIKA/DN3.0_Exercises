package builderpattern;
import java.util.Scanner;

public class BuilderPatternMain {
	
	    public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);

	        System.out.println("Enter CPU: ");
	        String CPU = scanner.nextLine();

	        System.out.println("Enter RAM: ");
	        String RAM = scanner.nextLine();

	        System.out.println("Enter Storage: ");
	        String storage = scanner.nextLine();

	        System.out.println("Enable Graphics Card? (true/false): ");
	        boolean isGraphicsCardEnabled = scanner.nextBoolean();

	        System.out.println("Enable Bluetooth? (true/false): ");
	        boolean isBluetoothEnabled = scanner.nextBoolean();

	        Computer computer = new Computer.Builder(CPU, RAM, storage)
	                            .setGraphicsCardEnabled(isGraphicsCardEnabled)
	                            .setBluetoothEnabled(isBluetoothEnabled)
	                            .build();

	        System.out.println(computer);

	        scanner.close();
	    }
	}
