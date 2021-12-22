package inc.fabric.api.automation.utility;

import java.util.concurrent.ThreadLocalRandom;

public class CommonUtils {

    public static int getRandomNumber() {
        return (int) getRandomNumberInRange(1000, 50000) + (int) getRandomNumberInRange(51000, 90000);
    }

    private static synchronized  <T extends Number> Number getRandomNumberInRange(T minimum, T maximum) {
        if (minimum instanceof Double) {
            return ThreadLocalRandom.current().nextDouble(minimum.doubleValue(), maximum.doubleValue());
        } else {
            return ThreadLocalRandom.current().nextInt(minimum.intValue(), maximum.intValue());
        }
    }


}
