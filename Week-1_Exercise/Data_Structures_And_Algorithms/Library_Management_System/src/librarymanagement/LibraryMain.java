package librarymanagement;

import java.util.Scanner;

public class LibraryMain {

    public static void main(String[] args) {
        Library library = new Library();
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.println("Library Management System:");
            System.out.println("1. Add Book");
            System.out.println("2. Linear Search by Title");
            System.out.println("3. Binary Search by Title");
            System.out.println("4. Exit");
            System.out.print("Choose an option: ");
            int option = scanner.nextInt();
            scanner.nextLine();  

            switch (option) {
                case 1:
                    System.out.print("Enter Book ID: ");
                    int bookId = scanner.nextInt();
                    scanner.nextLine();  
                    System.out.print("Enter Book Title: ");
                    String title = scanner.nextLine();
                    System.out.print("Enter Book Author: ");
                    String author = scanner.nextLine();
                    library.addBook(new Book(bookId, title, author));
                    break;
                case 2:
                    System.out.print("Enter title to search (Linear Search): ");
                    String linearSearchTitle = scanner.nextLine();
                    Book linearSearchResult = library.linearSearchByTitle(linearSearchTitle);
                    if (linearSearchResult != null) {
                        System.out.println("Book found: " + linearSearchResult);
                    } else {
                        System.out.println("Book not found.");
                    }
                    break;
                case 3:
                    System.out.print("Enter title to search (Binary Search): ");
                    String binarySearchTitle = scanner.nextLine();
                    Book binarySearchResult = library.binarySearchByTitle(binarySearchTitle);
                    if (binarySearchResult != null) {
                        System.out.println("Book found: " + binarySearchResult);
                    } else {
                        System.out.println("Book not found.");
                    }
                    break;
                case 4:
                    running = false;
                    System.out.println("Exiting the system.");
                    break;
                default:
                    System.out.println("Invalid option. Please try again.");
            }
        }
        scanner.close();
    }
}
