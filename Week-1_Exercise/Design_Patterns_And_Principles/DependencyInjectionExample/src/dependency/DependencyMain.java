package dependency;
import java.util.Scanner;

public class DependencyMain {
    public static void main(String[] args) {
        CustomerRepository customerRepository = new CustomerRepositoryAppli();
        
        CustomerService customerService = new CustomerService(customerRepository);
        
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("1. Add Customer");
            System.out.println("2. Find Customer by ID");
            System.out.println("3. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            
            switch (choice) {
                case 1:
                    System.out.print("Enter Customer ID: ");
                    int id = scanner.nextInt();
                    if (customerService.customerExists(id)) {
                        System.out.println("Customer ID already exists!");
                        break;
                    }
                    scanner.nextLine();  
                    System.out.print("Enter Customer Name: ");
                    String name = scanner.nextLine();
                    Customer newCustomer = new Customer(id, name);
                    customerService.addCustomer(newCustomer);
                    System.out.println("Customer added successfully!");
                    break;
                case 2:
                    System.out.print("Enter Customer ID to find: ");
                    int searchId = scanner.nextInt();
                    Customer customer = customerService.getCustomerById(searchId);
                    if (customer != null) {
                        System.out.println("Customer ID: " + customer.getId());
                        System.out.println("Customer Name: " + customer.getName());
                    } else {
                        System.out.println("Customer not found!");
                    }
                    break;
                case 3:
                    System.out.println("Exiting...");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
}
