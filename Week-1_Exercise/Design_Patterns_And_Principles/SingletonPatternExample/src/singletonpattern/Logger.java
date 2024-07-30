package singletonpattern;

public class Logger {

	private Logger() {
	    }

	    private static class LoggerHelper {
	        private static final Logger INSTANCE = new Logger();
	    }

	    public static Logger getInstance() {
	        return LoggerHelper.INSTANCE;
	    }

	    public void log(String message) {
	        System.out.println("Log: " + message);
	    }
	}
