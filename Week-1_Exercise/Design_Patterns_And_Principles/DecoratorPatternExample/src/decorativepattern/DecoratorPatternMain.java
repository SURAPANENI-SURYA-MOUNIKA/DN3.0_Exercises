package decorativepattern;

import java.util.Scanner;

public class DecoratorPatternMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Enter your message: ");
        String message = scanner.nextLine();

        Notifier notifier = new EmailNotifier();

        while (true) {
            System.out.println("Select notification option (enter number): ");
            System.out.println("1. Email");
            System.out.println("2. SMS");
            System.out.println("3. Slack");
            System.out.println("4. Done");

            int choice = scanner.nextInt();

            if (choice == 1) {
                System.out.println("Email notifier selected.");
            } else if (choice == 2) {
                notifier = new SMSNotifierDecorator(notifier);
                System.out.println("SMS notifier added.");
            } else if (choice == 3) {
                notifier = new SlackNotifierDecorator(notifier);
                System.out.println("Slack notifier added.");
            } else if (choice == 4) {
                break;
            } else {
                System.out.println("Invalid choice. Please select again.");
            }
        }

        notifier.send(message);

        scanner.close();
    }
}
