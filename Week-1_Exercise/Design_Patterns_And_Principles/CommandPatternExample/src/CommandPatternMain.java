package commandpattern;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class CommandPatternMain {
    public static void main(String[] args) throws IOException {
        Light livingRoomLight = new Light();

        LightOnCommand lightOn = new LightOnCommand(livingRoomLight);
        LightOffCommand lightOff = new LightOffCommand(livingRoomLight);

        RemoteControl remote = new RemoteControl();

        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("Press 'o' to turn on the light, 'f' to turn off the light, and 'q' to quit:");

        while (true) {
            char key = (char) reader.read();

            if (key == 'o') {
                remote.setCommand(lightOn);
                remote.pressButton();
            } else if (key == 'f') {
                remote.setCommand(lightOff);
                remote.pressButton();
            } else if (key == 'q') {
                break;
            }
        }

        System.out.println("Program terminated.");
    }
}
