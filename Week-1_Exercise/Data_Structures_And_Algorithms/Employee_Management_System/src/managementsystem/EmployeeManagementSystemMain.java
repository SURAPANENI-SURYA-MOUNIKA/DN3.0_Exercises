package managementsystem;

import java.util.Arrays;
import java.util.Scanner;

public class EmployeeManagementSystemMain {

    private Employee[] employees;
    private int size;
    private static final int INITIAL_CAPACITY = 10;

    public EmployeeManagementSystemMain() {
        employees = new Employee[INITIAL_CAPACITY];
        size = 0;
    }

    public void addEmployee(Employee employee) {
        if (searchEmployee(employee.getEmployeeId()) != null) {
            System.out.println("Employee with ID " + employee.getEmployeeId() + " already exists.");
            return;
        }
        if (size == employees.length) {
            employees = Arrays.copyOf(employees, employees.length * 2);
        }
        employees[size++] = employee;
    }

    public Employee searchEmployee(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                return employees[i];
            }
        }
        return null;
    }

    public void traverseEmployees() {
        for (int i = 0; i < size; i++) {
            System.out.println(employees[i]);
        }
    }

    public boolean deleteEmployee(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                employees[i] = employees[size - 1];
                employees[size - 1] = null;
                size--;
                return true;
            }
        }
        return false;
    }

    public void displayAllEmployees() {
        if (size == 0) {
            System.out.println("No employees to display.");
        } else {
            for (int i = 0; i < size; i++) {
                System.out.println(employees[i]);
            }
        }
    }

    public static void main(String[] args) {
        EmployeeManagementSystemMain ems = new EmployeeManagementSystemMain();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("1. Add Employee");
            System.out.println("2. Search Employee");
            System.out.println("3. Traverse Employees");
            System.out.println("4. Delete Employee");
            System.out.println("5. Display All Employees");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter Employee ID: ");
                    int id = scanner.nextInt();
                    scanner.nextLine();  // consume newline
                    System.out.print("Enter Employee Name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter Employee Position: ");
                    String position = scanner.nextLine();
                    System.out.print("Enter Employee Salary: ");
                    double salary = scanner.nextDouble();
                    ems.addEmployee(new Employee(id, name, position, salary));
                    break;
                case 2:
                    System.out.print("Enter Employee ID to search: ");
                    int searchId = scanner.nextInt();
                    Employee employee = ems.searchEmployee(searchId);
                    if (employee != null) {
                        System.out.println("Employee Found: " + employee);
                    } else {
                        System.out.println("Employee Not Found.");
                    }
                    break;
                case 3:
                    ems.traverseEmployees();
                    break;
                case 4:
                    System.out.print("Enter Employee ID to delete: ");
                    int deleteId = scanner.nextInt();
                    boolean isDeleted = ems.deleteEmployee(deleteId);
                    if (isDeleted) {
                        System.out.println("Employee Deleted.");
                    } else {
                        System.out.println("Employee Not Found.");
                    }
                    break;
                case 5:
                    ems.displayAllEmployees();
                    break;
                case 6:
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
}
