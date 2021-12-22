package inc.fabric.api.automation.utility;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import inc.fabric.api.automation.pages.BasePage;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

public class FileHandler {
    static Properties OR;
    static JsonParser jsonParser;
    static InputStream is;
    static Reader reader;

    public static String readPropertyFile(String fileName, String parameter) {
        OR = new Properties();
        try {
            OR.load(new InputStreamReader(FileHandler.class.getResourceAsStream("/" + fileName), StandardCharsets.UTF_8));
        } catch (Exception e) {
            try {
                OR.load(new InputStreamReader(FileHandler.class.getResourceAsStream("/properties/" + fileName), StandardCharsets.UTF_8));
            } catch (Exception io){
                throw  new RuntimeException("File is not present in /resources/properties file");
            }
        }
        return OR.getProperty(parameter);
    }

    private static void setUpReadStream(String fileName) {
        is = FileHandler.class.getClassLoader().getResourceAsStream(fileName);
        reader = new InputStreamReader(is);
        getJsonParserInstance();
    }

    public static JsonObject getJsonObject(String jsonInString) {
        jsonParser = new JsonParser();
        return jsonParser.parse(jsonInString).getAsJsonObject();
    }

    public static JsonObject getDataFromJson(String fileName) {
        setUpReadStream(fileName);
        // getting the root element - the whole set of json data
        JsonElement rootElement = jsonParser.parse(reader);
        // covert it to the json object to access different child objects and arrays
        return rootElement.getAsJsonObject();
    }

    private static void getJsonParserInstance() {
        if (jsonParser == null) {
            jsonParser = new JsonParser();
        }
    }
}
