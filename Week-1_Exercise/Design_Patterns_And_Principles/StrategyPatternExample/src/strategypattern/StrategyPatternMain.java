package strategypattern;
import java.util.Scanner;

public class StrategyPatternMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PaymentContext context = new PaymentContext();

        System.out.println("Select Payment Method: 1 for Credit Card, 2 for PayPal");
        int choice = scanner.nextInt();
        scanner.nextLine();

        switch (choice) {
            case 1:
                System.out.println("Enter Credit Card Number:");
                String cardNumber = scanner.nextLine();
                System.out.println("Enter Card Holder Name:");
                String cardHolderName = scanner.nextLine();
                context.setPaymentStrategy(new CreditCardPayment(cardNumber, cardHolderName));
                break;
            case 2:
                System.out.println("Enter PayPal Email:");
                String email = scanner.nextLine();
                context.setPaymentStrategy(new PayPalPayment(email));
                break;
            default:
                System.out.println("Invalid choice.");
                scanner.close();
                return;
        }

        System.out.println("Enter amount to pay:");
        double amount = scanner.nextDouble();

        context.executePayment(amount);
        scanner.close();
    }
}
