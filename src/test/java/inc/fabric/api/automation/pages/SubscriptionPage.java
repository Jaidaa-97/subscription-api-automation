package inc.fabric.api.automation.pages;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import inc.fabric.api.automation.contstants.APIConstants;
import inc.fabric.api.automation.utility.CommonUtils;
import inc.fabric.api.automation.utility.FileHandler;
import org.junit.Assert;

import java.time.LocalDate;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class SubscriptionPage extends BasePage {
    private String subEndPoint;
    public BasePage basePage;
    public PlansPage plansPage;
    public CommonPage commonPage;
    public String subscriptionId;

    public SubscriptionPage(BasePage basePage, PlansPage plansPage, CommonPage commonPage) {
        this.basePage = basePage;
        this.plansPage = plansPage;
        this.commonPage = commonPage;
    }

    public String getSubscriptionId() {
        return subscriptionId;
    }

    public void setSubscriptionId(String subscriptionId) {
        this.subscriptionId = subscriptionId;
    }

    public String getOrderId() {
        String order1 = "6803-5058-";
        Random r = new Random(System.currentTimeMillis());
        return order1 + (10000 + r.nextInt(20000));
    }

    public void getSubEndPoint(String endPoint) {
        endPoint = endPoint.toLowerCase();
        switch (endPoint) {
            case "create":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION;
                break;
            case "update":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION+"/"+getSubscriptionId();
                break;
            case "skip subscription":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION+"/"+APIConstants.SKIP_SUBSCRIPTION+"/"+getSubscriptionId();
                break;
            default :
                throw new RuntimeException(endPoint +"is not added in the method getSubEndPoint(String endPoint)");

        }
        basePage.setEndPoint(subEndPoint);
        scenario.write("End Point : " + subEndPoint);
    }

    public void getRequestPayloadForSubscriptionAPI(String status) {
        JsonObject requestPayload = null;
        if (status.equalsIgnoreCase("active")) {
            requestPayload = FileHandler.getDataFromJson("request-payload/createSubscription.json");
        } else {
            requestPayload = FileHandler.getDataFromJson("request-payload/createSubscriptionInactive.json");
        }

        String body = requestPayload.toString().replace("{{order}}", getOrderId());
        body = body.replace("{{itemId}}", FileHandler.getDataFromPropertyFile("productItem1"));
        body = body.replace("{{planID}}", plansPage.getPlanId());
        basePage.setBody(body);
    }

    public void verifySubscriptionCreation(String status) {
        String subId = basePage.getResponse().then().extract().path("data._id");
        setSubscriptionId(subId);
        Set<String> skipToTest = Stream.of(
                "id",
                "_id",
                "planID",
                "customerID",
                "merchantAccount",
                "lastOrderReferenceId",
                "lastPaymentDate",
                "nextPaymentDate",
                "nextShipDate",
                "createdAt",
                "updatedAt",
                "priceListID",
                "expireDate"
        ).collect(Collectors.toSet());

        JsonObject expectedResponse;

        if (status.equalsIgnoreCase("active")) {
            expectedResponse = FileHandler.getDataFromJson("response/createSubscriptionResponse.json");
        } else {
            expectedResponse = FileHandler.getDataFromJson("response/createInactiveSubscriptionResponse.json");
        }

        JsonObject actualResponse = FileHandler.getJsonObject(basePage.getResponse().asString());
        //CommonUtils.validateJsonResponse(expectedResponse, actualResponse, skipToTest);
    }

    public void updateSubscriptionProperty(String property, String propertyValue) {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        JsonObject updatedJsonObject = commonPage.updateParentProperty(jsonObject, property, propertyValue);
        basePage.setBody(updatedJsonObject.toString());
    }

    public void addChildItems() {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        JsonObject quantity1 = new JsonObject();
        JsonObject quantity2 = new JsonObject();
        JsonArray childItems = new JsonArray();

        quantity1.addProperty("itemID", "1000000047");
        quantity1.addProperty("quantity", 3);
        quantity2.addProperty("itemID", "1000000094");
        quantity2.addProperty("quantity", 4);

        childItems.add(quantity1);
        childItems.add(quantity2);

        jsonObject.add("childItems", childItems);
        basePage.setBody(jsonObject.toString());
    }

    public void addGifSettings(boolean isEmpty) {
        JsonObject giftSettings = new JsonObject();
        if (!isEmpty) {
            giftSettings.addProperty("recipientName", "Jitendra Pisal");
            giftSettings.addProperty("recipientEmail", "ar1@shopdev.co");
        } else {
            giftSettings.addProperty("recipientName", "");
            giftSettings.addProperty("recipientEmail", "");
        }
        JsonObject actualPayload = FileHandler.getJsonObject(basePage.getBody());
        actualPayload.add("giftSettings",giftSettings);
        basePage.setBody(actualPayload.toString());
    }

    public void savePropertyValue(String property, String key){
        savedValues.put(key,basePage.getResponse().then().extract().path(property));
    }

    public void verifyDatesOf(String propertyPath, String noOf, String type){
        String[] date = savedValues.get("lastPaymentDate").split("T");
        int day = Integer.parseInt(date[0].split("-")[2]);
        int month = Integer.parseInt(date[0].split("-")[1]);
        int year = Integer.parseInt(date[0].split("-")[0]);
        LocalDate date1 = LocalDate.of(year, month, day);
        if (type.equals("weeks")){
            Assert.assertTrue(basePage.getResponse().then().extract().path(propertyPath).toString().contains(date1.plusWeeks(Integer.parseInt(noOf)).toString()));
        } else if (type.equals("months")){
            Assert.assertTrue(basePage.getResponse().then().extract().path(propertyPath).toString().contains(date1.plusMonths(Integer.parseInt(noOf)).toString()));
        } else if(type.equals("days")){
            Assert.assertTrue(basePage.getResponse().then().extract().path(propertyPath).toString().contains(date1.plusDays(Integer.parseInt(noOf)).toString()));
        } else {
            Assert.assertTrue(basePage.getResponse().then().extract().path(propertyPath).toString().contains(date1.plusYears(Integer.parseInt(noOf)).toString()));
        }
    }

    public void setNextPaymentDate(String name, int days){
        LocalDate ld = CommonUtils.getLocalDate(savedValues.get("nextPaymentDate"));
        savedValues.put(name,ld.plusDays(days).toString());
    }
}
