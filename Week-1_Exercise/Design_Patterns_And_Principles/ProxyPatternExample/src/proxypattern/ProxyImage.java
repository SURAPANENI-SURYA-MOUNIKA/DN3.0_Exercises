package proxypattern;
import java.util.HashMap;
import java.util.Map;

public class ProxyImage implements Image {
 private String fileName;
 private RealImage realImage;
 private static Map<String, RealImage> imageCache = new HashMap<>();

 public ProxyImage(String fileName) {
     this.fileName = fileName;
 }

 @Override
 public void display() {
     if (realImage == null) {
         realImage = imageCache.get(fileName);
         if (realImage == null) {
             realImage = new RealImage(fileName);
             imageCache.put(fileName, realImage);
         }
     }
     realImage.display();
 }
}
