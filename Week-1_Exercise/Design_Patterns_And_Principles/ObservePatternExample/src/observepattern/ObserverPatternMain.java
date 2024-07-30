package observepattern;
import java.util.Scanner;

public class ObserverPatternMain {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket();

        Observer mobileApp1 = new MobileApp("MobileApp1");
        Observer mobileApp2 = new MobileApp("MobileApp2");
        Observer webApp1 = new WebApplication("WebApplication1");

        stockMarket.registerObserver(mobileApp1);
        stockMarket.registerObserver(mobileApp2);
        stockMarket.registerObserver(webApp1);

        Scanner scanner = new Scanner(System.in);
        boolean exit = false;

        while (!exit) {
            System.out.println("Enter command (set/deregister/exit): ");
            String command = scanner.nextLine();

            switch (command) {
                case "set":
                    System.out.println("Enter new stock price: ");
                    double stockPrice = scanner.nextDouble();
                    scanner.nextLine(); 
                    stockMarket.setStockPrice(stockPrice);
                    break;
                case "deregister":
                    System.out.println("Enter observer to deregister (MobileApp1/MobileApp2/WebApplication1): ");
                    String observerName = scanner.nextLine();
                    switch (observerName) {
                        case "MobileApp1":
                            stockMarket.deregisterObserver(mobileApp1);
                            break;
                        case "MobileApp2":
                            stockMarket.deregisterObserver(mobileApp2);
                            break;
                        case "WebApplication1":
                            stockMarket.deregisterObserver(webApp1);
                            break;
                        default:
                            System.out.println("Observer not found.");
                            break;
                    }
                    break;
                case "exit":
                    exit = true;
                    break;
                default:
                    System.out.println("Invalid command.");
                    break;
            }
        }

        scanner.close();
    }
}
