package inc.fabric.api.automation.steps;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import inc.fabric.api.automation.pages.BasePage;
import inc.fabric.api.automation.pages.CommonPage;
import inc.fabric.api.automation.utility.FileHandler;
import inc.fabric.api.automation.utility.RestHttp;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class CommonSteps extends BasePage {
    public CommonPage commonPage;

    public CommonSteps(CommonPage commonPage){
        this.commonPage = commonPage;
    }

    @Before(order = 0)
    public void init(Scenario scenario){
        this.scenario = scenario;
    }

    @Before(order = 1)
    public void deleteSubscription(){
        String endPoint = getBaseURL() + "/data-subscription/subscriptions?customerID=&pageSize=15&pageNumber=1&search=&itemID=1000011327";
        RequestSpecification requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", getAccessToken());
        requestSpecification.header("x-site-context", get_xSiteContext());
        Response response = RestHttp.getCall(endPoint,requestSpecification);
        response.prettyPrint();
        List<Map<String, String>> listOfSubs = response.jsonPath().get("data.subscriptions");
        for(Map<String, String> map : listOfSubs) {
           RestHttp.deleteCall(getBaseURL()+"/data-subscription/subscriptions/"+map.get("_id"),requestSpecification);
        }

        System.out.println("a");
    }

    @Before(order = 2)
    public void deletePlans() {
        JsonObject payload = new JsonObject();
        JsonArray jsonArray = new JsonArray();
        String itemId = FileHandler.readPropertyFile("data.properties", "productItem1");
        jsonArray.add(itemId);
        jsonArray.add(FileHandler.readPropertyFile("data.properties", "productItem2"));
        payload.add("itemIds", jsonArray);
        RequestSpecification requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", getAccessToken());
        requestSpecification.header("x-site-context", get_xSiteContext());
        Response response = RestHttp.postCall(getBaseURL() + "/data-subscription/plans/get-by-itemIds", payload.toString(), requestSpecification);
        for(int i = 0 ; i < jsonArray.size(); i++){
            List<Map<String, String>> obj = response.jsonPath().get("data." + jsonArray.get(i).getAsString() + "");
            if (obj.size() != 0) {
                for (Map<String, String> map1 : obj) {
                    RestHttp.deleteCall(getBaseURL() + "/data-subscription/v3/plans/" + map1.get("planGroup"), requestSpecification);
                }
            }
        }
    }
    @Then("^I see property value \"([^\"]+)\" is present in the response property \"([^\"]+)\"$")
    public void iSeePlanIsPresentInTheResponse(String propertyValue, String property) {
        commonPage.verifyPropertyValueIn(propertyValue,property);
    }
}
