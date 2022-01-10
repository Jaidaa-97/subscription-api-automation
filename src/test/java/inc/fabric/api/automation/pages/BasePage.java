package inc.fabric.api.automation.pages;

import com.google.gson.JsonObject;
import inc.fabric.api.automation.contstants.APIConstants;
import inc.fabric.api.automation.utility.FileHandler;
import io.cucumber.java.Scenario;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

public class BasePage {
    public static Scenario scenario;
    public String access_token;
    public String body;
    private Response response;
    public String endPoint;
    public static Map<String,String> savedValues = new HashMap<>();

    public String getEndPoint() {
        return endPoint;
    }

    public void setEndPoint(String endPoint) {
        this.endPoint = endPoint;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public void setResponse(Response response){
        this.response = response;
    }

    public Response getResponse(){
        return this.response;
    }

    public String getAccessToken(){
        String loginEndPoint = getBaseURL() + APIConstants.LOGIN_ENDPOINT_RESOURCE;
        RequestSpecification request;
        request = RestAssured.given().relaxedHTTPSValidation().header("x-site-context",get_xSiteContext());
        request.contentType(ContentType.JSON);
        request.body(getLoginRequestPayload());
        Response loginResponse = request.post(loginEndPoint);
        while(loginResponse.getStatusCode() == 502) {
            loginResponse = request.post(loginEndPoint);
        }
        access_token = loginResponse.jsonPath().get("accessToken").toString();
        scenario.write("access token : "+access_token);
        return access_token;
    }

    public String get_xSiteContext(){
        TimeZone timeZone = TimeZone.getTimeZone("UTC");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        dateFormat.setTimeZone(timeZone);
        String dateWithTimeInUTCZone = dateFormat.format(new Date());
        return getEnv().equalsIgnoreCase("sandbox")? "{\"date\":\""+dateWithTimeInUTCZone+"\",\"channel\":12,\"account\":\"6024fb5291bd9f0008b578ba\",\"stage\":\"sandbox\"}"
                :getEnv().equalsIgnoreCase("staging")? "{\"date\":\""+dateWithTimeInUTCZone+"\",\"channel\":12,\"account\":\"5f689caa4216e7000750d1ef\",\"stage\":\"stg02\"}"
                :"{\"date\":\""+dateWithTimeInUTCZone+"\",\"channel\":12}";
    }

    private String getLoginRequestPayload() {
        JsonObject loginPayload = new JsonObject();
        loginPayload.addProperty("username", getUserName());
        loginPayload.addProperty("password", getPassword());
        loginPayload.addProperty("accountId", getAccountID());
        return loginPayload.toString();
    }

    private String getUserName(){
        String env = getEnv();
        switch (env) {
            case "SANDBOX":
                return "jitendra.pisal@fabric.inc";
            default:
                return "ahmad.rauf@shopdev.co";
        }
    }

    private String getPassword() {
        String env = getEnv();
        switch (env) {
            case "SANDBOX":
                return "Fabric@123";
            default:
                return "Ahmad0306";
        }
    }

    private String getAccountID() {
        String env = getEnv();
        switch (env) {
            case "SANDBOX":
                return "4314183759";
            default:
                return "4781348886";
        }
    }

    private String getEnv() {
        String env = System.getProperty("env");
        if (null == env || env.equals("")) {
            return "STAGING";
        } else {
            return env.toUpperCase();
        }
    }

    public String getBaseURL() {
        return FileHandler.readPropertyFile("environment.properties",getEnv());
    }
}
