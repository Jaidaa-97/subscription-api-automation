package inc.fabric.api.automation.pages;

import inc.fabric.api.automation.utility.RestHttp;
import io.restassured.specification.RequestSpecification;
import org.junit.Assert;

import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class CommonPage {
    public BasePage basePage;

    public CommonPage(BasePage basePage) {
        this.basePage = basePage;
    }

    public void verifyPropertyValueIn(String propertyValue, String property) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        Assert.assertEquals(propertyValue, basePage.getResponse().then().extract().path(property));
    }

    public void runPostCall() {
        RequestSpecification requestSpecification;
        requestSpecification = given().relaxedHTTPSValidation();
        requestSpecification.header("Authorization", basePage.getAccessToken());
        requestSpecification.header("x-site-context", basePage.get_xSiteContext());
        basePage.setResponse(RestHttp.postCall(basePage.getEndPoint(), basePage.getBody(), requestSpecification));
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
}
