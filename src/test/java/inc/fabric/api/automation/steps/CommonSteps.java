package inc.fabric.api.automation.steps;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import inc.fabric.api.automation.pages.BasePage;
import inc.fabric.api.automation.pages.CommonPage;
import inc.fabric.api.automation.utility.FileHandler;
import inc.fabric.api.automation.utility.RestHttp;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class CommonSteps extends BasePage {
    public CommonPage commonPage;
    public BasePage basePage;

    public CommonSteps(CommonPage commonPage, BasePage basePage) {
        this.commonPage = commonPage;
        this.basePage = basePage;
    }

    @Before(order = 0)
    public void init(Scenario scenario) {
        this.scenario = scenario;
    }

    @Before(order = 1)
    public void deleteSubscription() {
        String [] products = {"productItem1","productItem2"};
        for (int i = 0; i < 2; i++) {
            String endPoint = getBaseURL() + "/data-subscription/subscriptions?itemID=" + FileHandler.getDataFromPropertyFile(products[i]);
            RequestSpecification requestSpecification = given().relaxedHTTPSValidation();
            requestSpecification.header("Authorization", getAccessToken());
            Response response = RestHttp.getCall(endPoint, requestSpecification);
            scenario.write(response.prettyPrint());
            response.then().assertThat().statusCode(200);
            List<Map<String, String>> listOfSubs = response.jsonPath().get("data.subscriptions");
            for (Map<String, String> map : listOfSubs) {
                RestHttp.deleteCall(getBaseURL() + "/data-subscription/subscriptions/" + map.get("_id"), requestSpecification);
            }
        }
    }

    @Before(order = 2)
    public void deletePlans() {
        JsonObject payload = new JsonObject();
        JsonArray jsonArray = new JsonArray();
        String itemId = FileHandler.getDataFromPropertyFile("productItem1");
        jsonArray.add(itemId);
        jsonArray.add(FileHandler.getDataFromPropertyFile("productItem2"));
        payload.add("itemIds", jsonArray);
        RequestSpecification requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", getAccessToken());
        requestSpecification.header("x-site-context", get_xSiteContext());
        Response response = RestHttp.postCall(getBaseURL() + "/data-subscription/plans/get-by-itemIds", payload.toString(), requestSpecification);
        scenario.write(response.prettyPrint());
        response.then().assertThat().statusCode(200);
        for (int i = 0; i < jsonArray.size(); i++) {
            List<Map<String, String>> obj = response.jsonPath().get("data." + jsonArray.get(i).getAsString() + "");
            if (obj.size() != 0) {
                for (Map<String, String> map1 : obj) {
                    RestHttp.deleteCall(getBaseURL() + "/data-subscription/plans/" + map1.get("_id"), requestSpecification);
                }
            }
        }
    }

    @Then("^I see property value \"([^\"]+)\" is (present|contains) in the response property \"([^\"]+)\"$")
    public void iSeePlanIsPresentInTheResponse(String propertyValue, String contains, String property) {
        commonPage.verifyPropertyValueIn(propertyValue, contains.equalsIgnoreCase("contains"),property);
    }

    @Then("I see property value {int} is present in the response property {string}")
    public void iSeePlanIsPresentInTheResponse(int propertyValue, String property) {
        commonPage.verifyPropertyValueIn(propertyValue, property);
    }

    @And("I see response code {int}")
    public void iSeeResponseCode(int statusCode) {
        basePage.getResponse().then().assertThat().statusCode(statusCode);
    }

    @Then("^I see following value for property \"([^\"]*)\" :$")
    public void iSeeFollowingValueForProperty(String property, String propertyValue) {
        commonPage.verifyPropertyValueIn(propertyValue, false, property);
    }

    @And("I have added property {string} as {string} value in payload")
    public void iHaveAddedPropertyAsInPayload(String property, String propertyValue) {
        if(propertyValue.contains("true") || propertyValue.contains("false")) {
            commonPage.addProperty(property, Boolean.parseBoolean(propertyValue));
        } else {
            commonPage.addProperty(property, propertyValue);
        }
    }

    @And("I have added property {string} as {int} value in payload")
    public void iHaveAddedPropertyAsInPayload(String property, int propertyValue) {
        commonPage.addProperty(property, propertyValue);
    }

    @When("I run put call")
    public void iRunPutCall() {
        commonPage.runPutCall();
    }

    @When("I run delete call")
    public void iRunDeleteCall() {
        commonPage.runDeleteCall();
    }

    @When("I run post call")
    public void iRunPostCall() {
        commonPage.runPostCall();
    }


    @And("I have following request payload :")
    public void iHaveFollowingRequestPayload(String payload) {
        commonPage.requestPayload(payload);
    }

    @Then("I verify {int} records are present in the response against the property {string}")
    public void iVerifyRecordsArePresentInTheResponseAgainstTheProperty(int records, String againstProperty) {
        commonPage.verifyTotalRecordsIntTheResponse(records,againstProperty);
    }

    @Then("^I see value \"([^\"]+)\" is contains in property \"([^\"]+)\" inside the property array \"([^\"]+)\"$")
    public void iSeeValueIsContainsInThePropertyArray(String value, String propertyName, String propertyHavingArray) {
        commonPage.verifyPropertiesValueInArray(value,propertyName,propertyHavingArray);
    }

    @And("I have added path parameter {string}")
    public void iHaveAddedPathParameter(String pathParam) {
        basePage.setEndPoint(basePage.getEndPoint()+pathParam);
    }

    @Then("validate schema {string}")
    public void validateSchema(String path) {
        //commonPage.validateSchema(path);
    }
}
