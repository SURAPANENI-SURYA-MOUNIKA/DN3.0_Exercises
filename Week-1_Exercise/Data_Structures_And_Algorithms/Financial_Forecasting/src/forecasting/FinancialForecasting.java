package forecasting;
import java.util.Scanner;
public class FinancialForecasting {
	  
	
	    public static double calculateFutureValue(double initialValue, double growthRate, int years) {
	        if (years == 0) {
	            return initialValue;
	        }
	        return calculateFutureValue(initialValue * (1 + growthRate), growthRate, years - 1);
	    }

	    public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);

	        System.out.print("Enter the initial value: ");
	        double initialValue = scanner.nextDouble();

	        System.out.print("Enter the annual growth rate (e.g., 0.05 for 5%): ");
	        double growthRate = scanner.nextDouble();

	        System.out.print("Enter the number of years into the future to forecast: ");
	        int years = scanner.nextInt();

	        double futureValue = calculateFutureValue(initialValue, growthRate, years);
	        System.out.println("The future value after " + years + " years is: " + futureValue);

	        scanner.close();
	    }
	}




