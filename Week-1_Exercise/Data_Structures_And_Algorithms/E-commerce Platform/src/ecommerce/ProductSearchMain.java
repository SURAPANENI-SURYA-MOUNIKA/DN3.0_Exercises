package ecommerce;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;
public class ProductSearchMain {
	

 // Linear Search
	    public static Product linearSearch(Product[] products, String targetName) {
	        for (Product product : products) {
	            if (product.getProductName().equalsIgnoreCase(targetName)) {
	                return product;
	            }
	        }
	        return null;
	    }

	    // Binary Search
	    public static Product binarySearch(Product[] products, String targetName) {
	        int low = 0;
	        int high = products.length - 1;
	        
	        while (low <= high) {
	            int mid = (low + high) / 2;
	            int comparison = products[mid].getProductName().compareToIgnoreCase(targetName);

	            if (comparison == 0) {
	                return products[mid];
	            } else if (comparison < 0) {
	                low = mid + 1;
	            } else {
	                high = mid - 1;
	            }
	        }
	        return null;
	    }

	    public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);

	        Product[] products = {
	            new Product(1, "Laptop", "Electronics"),
	            new Product(2, "Smartphone", "Electronics"),
	            new Product(3, "Refrigerator", "Appliances"),
	            new Product(4, "Headphones", "Accessories"),
	            new Product(5, "Shoes", "Fashion")
	        };

	        Arrays.sort(products, Comparator.comparing(Product::getProductName, String.CASE_INSENSITIVE_ORDER));

	        boolean continueSearch = true;

	        while (continueSearch) {
	          
	            System.out.println("Enter product name to search: ");
	            String targetName = scanner.nextLine();

	           
	            Product foundProductLinear = linearSearch(products, targetName);
	            System.out.println("Linear Search Result: " + (foundProductLinear != null ? foundProductLinear : "Product not found"));

	            
	            Product foundProductBinary = binarySearch(products, targetName);
	            System.out.println("Binary Search Result: " + (foundProductBinary != null ? foundProductBinary : "Product not found"));

	            
	            System.out.println("Do you want to search another product? (1. Yes, 2. No)");
	            int choice = scanner.nextInt();
	            scanner.nextLine(); 

	            switch (choice) {
	                case 1:
	                    continueSearch = true;
	                    break;
	                case 2:
	                    continueSearch = false;
	                    System.out.println("Exiting the program.");
	                    break;
	                default:
	                    System.out.println("Invalid choice. Exiting the program.");
	                    continueSearch = false;
	                    break;
	            }
	        }

	        scanner.close();
	    }
	}




