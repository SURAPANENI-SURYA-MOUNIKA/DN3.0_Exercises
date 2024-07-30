package mvcpatterns;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class MVCPatternMain {
 private static Map<String, Student> studentDatabase = new HashMap<>();
 private static StudentView view = new StudentView();
 private static StudentController controller;

 public static void main(String[] args) {
     Scanner scanner = new Scanner(System.in);
     int choice;

     do {
         System.out.println("1. Create Student");
         System.out.println("2. Update Student");
         System.out.println("3. Display All Students");
         System.out.println("4. Exit");
         System.out.print("Enter your choice: ");
         choice = scanner.nextInt();
         scanner.nextLine(); 

         switch (choice) {
             case 1:
                 System.out.println("Enter Student ID: ");
                 String studentId = scanner.nextLine();

                 if (studentDatabase.containsKey(studentId)) {
                     System.out.println("Student ID already exists. Please use a different ID.");
                     break;
                 }

                 System.out.println("Enter Student Name: ");
                 String studentName = scanner.nextLine();

                 System.out.println("Enter Student Grade: ");
                 String studentGrade = scanner.nextLine();

                 Student student = new Student(studentId, studentName, studentGrade);
                 studentDatabase.put(studentId, student);
                 System.out.println("Student created successfully.");
                 break;

             case 2:
                 System.out.println("Enter Student ID to update: ");
                 String updateId = scanner.nextLine();

                 if (!studentDatabase.containsKey(updateId)) {
                     System.out.println("Student ID not found. Please create the student first.");
                     break;
                 }

                 Student updateStudent = studentDatabase.get(updateId);
                 controller = new StudentController(updateStudent, view);

                 System.out.println("Enter new Student Name (leave blank to keep current): ");
                 String newName = scanner.nextLine();
                 if (!newName.isEmpty()) {
                     controller.setStudentName(newName);
                 }

                 System.out.println("Enter new Student Grade (leave blank to keep current): ");
                 String newGrade = scanner.nextLine();
                 if (!newGrade.isEmpty()) {
                     controller.setStudentGrade(newGrade);
                 }

                 studentDatabase.put(updateId, updateStudent); 
                 System.out.println("Student details updated successfully.");
                 break;

             case 3:
                 if (studentDatabase.isEmpty()) {
                     System.out.println("No students to display.");
                 } else {
                     System.out.println("Student Details:");
                     for (Student s : studentDatabase.values()) {
                         controller = new StudentController(s, view);
                         controller.updateView();
                         System.out.println(); 
                     }
                 }
                 break;

             case 4:
                 System.out.println("Exiting the application.");
                 break;

             default:
                 System.out.println("Invalid choice. Please try again.");
         }
     } while (choice != 4);

     scanner.close();
 }
}
