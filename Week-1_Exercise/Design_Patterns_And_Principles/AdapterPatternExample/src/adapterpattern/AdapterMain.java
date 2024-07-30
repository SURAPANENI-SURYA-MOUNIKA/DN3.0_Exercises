package adapterpattern;

import java.util.Scanner;

public class AdapterMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.println("Enter payment amount: ");
            double amount = scanner.nextDouble();

            System.out.println("Choose payment gateway (1- PayPal, 2- Stripe, 3- Square): ");
            int choice = scanner.nextInt();

            PaymentProcessor paymentProcessor = null;

            switch (choice) {
                case 1:
                    paymentProcessor = new PayPalAdapter(new PayPalGateway());
                    break;
                case 2:
                    paymentProcessor = new StripeAdapter(new StripeGateway());
                    break;
                case 3:
                    paymentProcessor = new SquareAdapter(new SquareGateway());
                    break;
                default:
                    System.out.println("Invalid choice.");
                    continue;
            }

            paymentProcessor.processPayment(amount);

            System.out.println("Do you want to process another payment? (yes/no): ");
            String userChoice = scanner.next();

            if (!userChoice.equalsIgnoreCase("yes")) {
                running = false;
            }
        }

        System.out.println("Exiting the payment processing system. Thank you!");
        scanner.close();
    }
}
