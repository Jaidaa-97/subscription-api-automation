package inc.fabric.api.automation.pages;

import com.google.gson.JsonObject;
import inc.fabric.api.automation.utility.FileHandler;
import inc.fabric.api.automation.utility.RestHttp;
import io.restassured.module.jsv.JsonSchemaValidator;
import io.restassured.specification.RequestSpecification;
import org.apache.poi.ss.formula.functions.T;
import org.junit.Assert;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class CommonPage {
    public BasePage basePage;

    public CommonPage(BasePage basePage) {
        this.basePage = basePage;
    }

    public void verifyPropertyValueIn(String propertyValue, boolean isContains, String property) {
        propertyValue = propertyValue.trim();
        if (!isContains) {
            if (propertyValue.contains("true") || propertyValue.contains("false")) {
                Assert.assertEquals(Boolean.parseBoolean(propertyValue), basePage.getResponse().then().extract().path(property));
            } else if(propertyValue.equals("null")){
                Assert.assertTrue(basePage.getResponse().then().extract().path(property) == null);
            }else {
                Assert.assertEquals(propertyValue, basePage.getResponse().then().extract().path(property));
            }
        } else {
            Assert.assertTrue(basePage.getResponse().then().extract().path(property).toString().contains(propertyValue));
        }
    }

    public void verifyPropertyValueIn(int propertyValue, String property) {
        Assert.assertEquals(propertyValue, (int) basePage.getResponse().then().extract().path(property));
    }

    public JsonObject updateParentProperty(JsonObject jsonObject, String fieldName, String fieldValue) {
        jsonObject.addProperty(fieldName, fieldValue);
        return jsonObject;
    }

    public JsonObject updateParentProperty(JsonObject jsonObject, String fieldName, int fieldValue) {
        jsonObject.addProperty(fieldName, fieldValue);
        return jsonObject;
    }

    public JsonObject updateParentProperty(JsonObject jsonObject, String fieldName, boolean fieldValue) {
        jsonObject.addProperty(fieldName, fieldValue);
        return jsonObject;
    }

    public void addProperty(String property, String propertyValue) {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        jsonObject = updateParentProperty(jsonObject, property, propertyValue);
        basePage.setBody(jsonObject.toString());
    }

    public void addProperty(String property, int propertyValue) {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        jsonObject = updateParentProperty(jsonObject, property, propertyValue);
        basePage.setBody(jsonObject.toString());
    }

    public void addProperty(String property, boolean propertyValue) {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        jsonObject = updateParentProperty(jsonObject, property, propertyValue);
        basePage.setBody(jsonObject.toString());
    }

    private JsonObject removeProperty(JsonObject jsonObject, String propertyName) {
        jsonObject.remove(propertyName);
        return jsonObject;
    }

    public void removeParentProperty(String propertyName) {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        jsonObject = removeProperty(jsonObject, propertyName);
        basePage.setBody(jsonObject.toString());
    }

    public void createRequestPayload(String payload) {
        basePage.setBody(payload);
    }

    public void runPostCall() {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());
        requestSpecification.header("x-site-context", basePage.get_xSiteContext());
        basePage.setResponse(RestHttp.postCall(basePage.getEndPoint(), basePage.getBody(), requestSpecification));
    }

    public void runDeleteCall() {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());
        requestSpecification.header("x-site-context", basePage.get_xSiteContext());
        basePage.setResponse(RestHttp.deleteCall(basePage.getEndPoint(), requestSpecification));
    }

    public void runPutCall() {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());
        //requestSpecification.header("x-site-context", basePage.get_xSiteContext());
        basePage.setResponse(RestHttp.putCall(basePage.getEndPoint(), basePage.getBody(), requestSpecification));
        basePage.getResponse().prettyPrint();
    }

    public void runUpdatePlanApi() {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());
        basePage.setResponse(RestHttp.putCall(basePage.getEndPoint(), basePage.getBody(), requestSpecification));
    }

    public void runGetCall(boolean isParam, List<Map<String, String>> list) {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());

        if (isParam) {
            for (Map<String, String> mp : list) {
                mp.keySet().forEach(key -> {
                    requestSpecification.queryParam(key, mp.get(key));
                });
            }
        }

        basePage.setResponse(RestHttp.getCall(basePage.getEndPoint(), requestSpecification));
    }

    public void requestPayload(String payload){
        basePage.setBody(payload);
    }

    public void verifyTotalRecordsIntTheResponse(int totalRecords, String property){
        ArrayList list = (ArrayList<T>) (basePage.getResponse().then().extract().path(property));
        Assert.assertEquals("all records are not showing in the response for property"+property,totalRecords,list.size());
    }

    public void verifyPropertiesValueInArray(String value, String propertyName, String propertyArray){
        ArrayList<String> list = (ArrayList<String>) (basePage.getResponse().then().extract().path(propertyArray));
        for (int i = 0; i < list.size(); i++) {
            Assert.assertTrue(basePage.getResponse().then().extract().path(propertyArray+"["+i+"]."+propertyName).toString().contains(value));
        }
    }

    public void validateSchema(String path){
        basePage.getResponse().then().body(JsonSchemaValidator.matchesJsonSchema(this.getClass().getResource("/schema/"+path+"")));
    }
}
