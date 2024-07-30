package customersorting;
import java.util.Arrays;
import java.util.Scanner;
public class SortOrdersMain {
	
	    public static void bubbleSort(Order[] orders) {
	        int n = orders.length;
	        for (int i = 0; i < n - 1; i++) {
	            for (int j = 0; j < n - i - 1; j++) {
	                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
	                    Order temp = orders[j];
	                    orders[j] = orders[j + 1];
	                    orders[j + 1] = temp;
	                }
	            }
	        }
	    }

	    public static void quickSort(Order[] orders, int low, int high) {
	        if (low < high) {
	            int pi = partition(orders, low, high);
	            quickSort(orders, low, pi - 1);
	            quickSort(orders, pi + 1, high);
	        }
	    }

	    private static int partition(Order[] orders, int low, int high) {
	        double pivot = orders[high].getTotalPrice();
	        int i = (low - 1);
	        for (int j = low; j < high; j++) {
	            if (orders[j].getTotalPrice() < pivot) {
	                i++;
	                Order temp = orders[i];
	                orders[i] = orders[j];
	                orders[j] = temp;
	            }
	        }
	        Order temp = orders[i + 1];
	        orders[i + 1] = orders[high];
	        orders[high] = temp;

	        return i + 1;
	    }

	    public static void main(String[] args) {
	        Order[] orders = {
	            new Order("1", "Alice", 250.0),
	            new Order("2", "Bob", 150.0),
	            new Order("3", "Charlie", 300.0),
	            new Order("4", "David", 200.0)
	        };

	        System.out.println("Original Orders:");
	        printOrders(orders);

	        Scanner scanner = new Scanner(System.in);
	        while (true) {
	            System.out.println("\nEnter 1 for Bubble Sort");
	            System.out.println("Enter 2 for Quick Sort");
	            System.out.println("Enter 3 to Exit");

	            if (scanner.hasNextInt()) {
	                int choice = scanner.nextInt();

	                switch (choice) {
	                    case 1:
	                        bubbleSort(orders);
	                        System.out.println("\nOrders sorted by Bubble Sort:");
	                        printOrders(orders);
	                        break;
	                    case 2:
	                        quickSort(orders, 0, orders.length - 1);
	                        System.out.println("\nOrders sorted by Quick Sort:");
	                        printOrders(orders);
	                        break;
	                    case 3:
	                        System.out.println("Exiting program.");
	                        scanner.close();
	                        System.exit(0); 
	                    default:
	                        System.out.println("Invalid choice. Please enter 1, 2, or 3.");
	                        break;
	                }
	            } else {
	                System.out.println("Invalid input. Please enter a number.");
	                scanner.next(); 
	            }
	        }
	    }

	    private static void printOrders(Order[] orders) {
	        for (Order order : orders) {
	            System.out.println(order);
	        }
	    }
	}
