package inc.fabric.api.automation.utility;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.junit.Assert;
import java.util.Random;

import java.time.LocalDate;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;

public class CommonUtils {

    public static int getRandomNumber() {
        return (int) getRandomNumberInRange(1000, 50000) + (int) getRandomNumberInRange(51000, 90000);
    }
    private static String[] words = new String[] { "abcdd", //$NON-NLS-1$
            "posrt", //$NON-NLS-1$
            "nogqi", //$NON-NLS-1$
            "seaa", //$NON-NLS-1$
            "takqima", //$NON-NLS-1$
            "sanlct", //$NON-NLS-1$
            "estpg" }; //$NON-NLS-1$
    private static Random random = new Random();
    public static String getRandomWord() {
        return words[random.nextInt(words.length)];
    }
    public static String getRandomEmail() {
        final int num = 10000;
        String email = getRandomWord() + random.nextInt(num) + "-" + random.nextInt(num) + "@" + "random" + ".com"; //$NON-NLS-1$ //$NON-NLS-2$
        return email.toLowerCase();
    }
    public static int getRandomNumberFourDigit() {
        return (int) (int) getRandomNumberInRange(0000, 9999);
    }

    private static synchronized  <T extends Number> Number getRandomNumberInRange(T minimum, T maximum) {
        if (minimum instanceof Double) {
            return ThreadLocalRandom.current().nextDouble(minimum.doubleValue(), maximum.doubleValue());
        } else {
            return ThreadLocalRandom.current().nextInt(minimum.intValue(), maximum.intValue());
        }
    }

    public static void validateJsonResponse(JsonObject expectedResponse, JsonObject actualResponse, Set<String> dontCheckTheseKeys) {
        for (String key : actualResponse.keySet()) {
            if (actualResponse.get(key) instanceof JsonObject) {
                JsonObject expectedChildResponseObject = expectedResponse.getAsJsonObject(key);
                JsonObject childResponseObject = actualResponse.getAsJsonObject(key);
                validateJsonResponse(expectedChildResponseObject, childResponseObject, dontCheckTheseKeys);
            } else if (actualResponse.get(key) instanceof JsonArray) {
                JsonArray childResponseArray = actualResponse.getAsJsonArray(key);
                JsonArray expectedChildResponseArray = expectedResponse.getAsJsonArray(key);
                for (int i = 0; i < childResponseArray.size(); i++) {
                    if (childResponseArray.get(i) instanceof JsonObject) {
                        validateJsonResponse((JsonObject) expectedChildResponseArray.get(i), (JsonObject) childResponseArray.get(i), dontCheckTheseKeys);
                    } else {
                        if (!dontCheckTheseKeys.contains(key)) {
                            if (actualResponse.get(String.valueOf(childResponseArray.get(i))) == null) {
                                Assert.assertEquals(new Gson().fromJson(actualResponse.get(key), String[].class),
                                        new Gson().fromJson(expectedResponse.get(key), String[].class));
                            } else {
//                                Assert.assertEquals(childResponseArray.get(i),
//                                        expectedChildResponseArray.get(i),
//                                        "Failed while validating the response" +
//                                                actualResponse.get(key.toString()));
                            }
                        }
                    }
                }
            } else if (!dontCheckTheseKeys.contains(key)) {
                Assert.assertEquals(actualResponse.get(key).toString(), expectedResponse.get(key).toString(),
                        "Failed while validating the response : " + key);
            }
        }
    }

    public static LocalDate getLocalDate(String date){
        String[] dateArray = date.toString().split("T");
        int day = Integer.parseInt(dateArray[0].split("-")[2]);
        int month = Integer.parseInt(dateArray[0].split("-")[1]);
        int year = Integer.parseInt(dateArray[0].split("-")[0]);
        return LocalDate.of(year, month, day);
    }

    public static String getEnv() {
        String env = System.getProperty("env");
        if (null == env || env.equals("")) {
            return "STAGING";
        } else {
            return env.toUpperCase();
        }
    }

}
