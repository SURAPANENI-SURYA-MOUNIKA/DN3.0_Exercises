package taskmanagement;

import java.util.Scanner;

public class TaskManagerMain {
    
    private final TaskList taskList;
    private final Scanner scanner;

    public TaskManagerMain() {
        taskList = new TaskList();
        scanner = new Scanner(System.in);
    }

    public void addTask() {
        System.out.print("Enter Task ID: ");
        int taskId = scanner.nextInt();
        scanner.nextLine(); 
        if (taskList.searchTask(taskId) != null) {
            System.out.println("Task with ID " + taskId + " already exists.");
            return;
        }
        System.out.print("Enter Task Name: ");
        String taskName = scanner.nextLine();
        System.out.print("Enter Task Status: ");
        String status = scanner.nextLine();
        Task task = new Task(taskId, taskName, status);
        taskList.addTask(task);
        System.out.println("Task added successfully.");
    }

    public void searchTask() {
        System.out.print("Enter Task ID to search: ");
        int taskId = scanner.nextInt();
        Task task = taskList.searchTask(taskId);
        if (task != null) {
            System.out.println("Task found: " + task);
        } else {
            System.out.println("Task not found.");
        }
    }

    public void traverseTasks() {
        taskList.traverseTasks();
    }

    public void deleteTask() {
        System.out.print("Enter Task ID to delete: ");
        int taskId = scanner.nextInt();
        boolean isDeleted = taskList.deleteTask(taskId);
        if (isDeleted) {
            System.out.println("Task deleted successfully.");
        } else {
            System.out.println("Task not found.");
        }
    }

    public void displayMenu() {
        System.out.println("1. Add Task");
        System.out.println("2. Search Task");
        System.out.println("3. Traverse Tasks");
        System.out.println("4. Delete Task");
        System.out.println("5. Display Menu");
        System.out.println("6. Exit");
    }

    public void start() {
        displayMenu();
        while (true) {
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); 

            switch (choice) {
                case 1:
                    addTask();
                    break;
                case 2:
                    searchTask();
                    break;
                case 3:
                    traverseTasks();
                    break;
                case 4:
                    deleteTask();
                    break;
                case 5:
                    displayMenu();
                    break;
                case 6:
                    System.out.println("Exiting...");
                    scanner.close();
                    System.exit(0);
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
                    break;
            }
        }
    }

    public static void main(String[] args) {
        TaskManagerMain taskManager = new TaskManagerMain();
        taskManager.start();
    }
}
