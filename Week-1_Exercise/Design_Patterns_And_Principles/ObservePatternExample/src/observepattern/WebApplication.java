package observepattern;
public class WebApplication implements Observer {
    private String appName;

    public WebApplication(String appName) {
        this.appName = appName;
    }

    @Override
    public void update(double stockPrice) {
        System.out.println(appName + " received stock price update: " + stockPrice);
    }
}
