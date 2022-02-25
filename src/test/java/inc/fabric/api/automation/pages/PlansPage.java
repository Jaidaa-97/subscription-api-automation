package inc.fabric.api.automation.pages;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import inc.fabric.api.automation.contstants.APIConstants;
import inc.fabric.api.automation.utility.FileHandler;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.junit.Assert;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class PlansPage extends BasePage {
    private String planEndPoint;
    public String planId;
    private String planGroup;
    public BasePage basePage;

    public PlansPage(BasePage basePage){
        this.basePage = basePage;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getPlanGroup() {
        return planGroup;
    }

    public void setPlanGroup(String planGroup) {
        this.planGroup = planGroup;
    }

    public void getPlanEndPoint(String endPoint) {
        endPoint = endPoint.toLowerCase();
        switch (endPoint) {
            case "create plan":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_PLAN_RESOURCE;
                break;
            case "update plan":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.UPDATE_PLAN;
                break;
            case "get plan count":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.GET_COUNT;
                break;
            case "get by itemid":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.GET_BY_ITEM_ID;
                break;
            case "get plan v3":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.GET_PLAN_V3;
                break;
            case "get plan by id":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_PLAN_RESOURCE+"/"+getPlanId();
                break;
            case "get plan by groupid":
                planEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.GET_PLAN_V3+"/"+getPlanGroup();
                break;
        }
        basePage.setEndPoint(planEndPoint);
        scenario.write("End Point : "+planEndPoint);
    }

    public void addIncorrectPlanIdInEndPoint(){
        basePage.setEndPoint(basePage.getEndPoint()+"a");
    }

    public void copyPlanId() {
        Map<String, String> map = basePage.getResponse().jsonPath().get("data");
        planGroup = map.get("planGroup");
    }

    public void requestBodyForCreatePlanAPI() {
        JsonObject requestPayload = FileHandler.getDataFromJson("request-payload/plan.json");
        requestPayload = updatePropertyValueInArray(requestPayload, "products", "itemId", FileHandler.getDataFromPropertyFile("productItem1"));
        basePage.setBody(requestPayload.toString());
    }

    public void requestBodyWithMultipleProductsForCreatePlanAPI() {
        JsonObject requestPayload = FileHandler.getDataFromJson("request-payload/plan.json");
        JsonObject jsonObject1 = new JsonObject();
        JsonObject jsonObject2 = new JsonObject();
        jsonObject1.addProperty("itemId",FileHandler.getDataFromPropertyFile("productItem1"));
        jsonObject2.addProperty("itemId",FileHandler.getDataFromPropertyFile("productItem2"));
        JsonArray ja = new JsonArray();
        ja.add(jsonObject1);
        ja.add(jsonObject2);

        requestPayload.add("products",ja);
        basePage.setBody(requestPayload.toString());
    }

    public void requestBodyForUpdatePlanAPI(boolean isFrequency) {
        JsonObject requestPayload = null;
        if (isFrequency){
            requestPayload = FileHandler.getDataFromJson("request-payload/addNewFrequencyPlan.json");
            requestPayload = FileHandler.getJsonObject(requestPayload.toString().replace("{{planGroupUnderFrequencySettings}}",getPlanGroup()));
            requestPayload = FileHandler.getJsonObject(requestPayload.toString().replace("{{_id}}",getPlanId()));

        } else {
            requestPayload = FileHandler.getDataFromJson("request-payload/updatePlan.json");
            requestPayload = updatePropertyValueInArray(requestPayload, "frequencySettings", "_id", getPlanId());
            requestPayload = updatePropertyValueInArray(requestPayload,"frequencySettings","planGroup",getPlanGroup());
            requestPayload = updateParentProperty(requestPayload,"_id",getPlanGroup());
        }


        requestPayload = FileHandler.getJsonObject(requestPayload.toString().replace("{{itemId}}",FileHandler.getDataFromPropertyFile("productItem1")));
        basePage.setBody(requestPayload.toString().replace("{{planGroupUnderPlan}}",getPlanGroup()));

    }

    public void updateShippingCost(int cost) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        payload = updateParentProperty(payload, "shippingCost", cost);
        basePage.setBody(payload.toString());
    }

    public void updateFrequency(int frequency) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        payload = updateParentProperty(payload, "frequency", frequency);
        basePage.setBody(payload.toString());
    }

    public void updatePlanStatus(String status) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        payload = updateParentProperty(payload, "status", status.toUpperCase());
        basePage.setBody(payload.toString());
    }

    public void payloadForGetByItemID(String itemId) {
        String body = "{\n" +
                "    \"itemIds\":[\"" + FileHandler.getDataFromPropertyFile(itemId) + "\"]\n" +
                "}";
        basePage.setBody(body);
    }

    public void updateStatusInPlanUpdatePayload(String status) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        JsonObject plansStatus = (JsonObject) payload.get("plan");
        plansStatus.addProperty("status", status);
        payload.add("plan", plansStatus);
        basePage.setBody(payload.toString());
    }

    public void updatePlanTitleOrDescription(boolean isTitle, String planTitleOrDescription) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        if (isTitle) {
            payload = updateParentProperty(payload, "title", planTitleOrDescription);
        } else {
            payload = updateParentProperty(payload, "description", planTitleOrDescription);
        }
        basePage.setBody(payload.toString());
    }

    public void updatePlanDiscount(int discount) {
        JsonObject payload = FileHandler.getJsonObject(basePage.getBody());
        payload = updateParentProperty(payload, "discount", discount);
        basePage.setBody(payload.toString());
    }

    public void updateProductInUpdatePlanPayload() {
        JsonObject requestPayload = FileHandler.getJsonObject(basePage.getBody());
        requestPayload = updatePropertyValueInArray(requestPayload, "planProducts", "itemId", FileHandler.getDataFromPropertyFile("productItem2"));
        basePage.setBody(requestPayload.toString());
    }

    private JsonObject updatePropertyValueInArray(JsonObject jsonObject, String parentProperty, String childFieldName, String childFieldValue) {
        JsonObject attributes = (JsonObject) jsonObject.get(parentProperty).getAsJsonArray().get(0);
        attributes.addProperty(childFieldName, childFieldValue);
        JsonArray jsonArray = new JsonArray();
        jsonArray.add(attributes);
        jsonObject.add(parentProperty, jsonArray);
        return jsonObject;
    }

    public void addNewAttributeProperty() {
        JsonObject jsonObject = FileHandler.getJsonObject(basePage.getBody());
        JsonArray jsonArray = new JsonArray();
        JsonObject child = new JsonObject();
        child.addProperty("title", "abc");
        child.addProperty("fieldType", "NUMBER");
        child.addProperty("value", 1);
        jsonArray.add(child);
        jsonObject.add("attributes", jsonArray);
        basePage.setBody(jsonObject.toString());
    }

    private JsonObject updateParentProperty(JsonObject jsonObject, String fieldName, String fieldValue) {
        jsonObject.addProperty(fieldName, fieldValue);
        return jsonObject;
    }

    private JsonObject updateParentProperty(JsonObject jsonObject, String fieldName, int fieldValue) {
        jsonObject.addProperty(fieldName, fieldValue);
        return jsonObject;
    }

    private JsonObject removeProperty(JsonObject jsonObject, String propertyName) {
        jsonObject.remove(propertyName);
        return jsonObject;
    }

    //*********************************************** Validation methods *************************************************************//

    public void verifyPlanCreation(String status) {
        Response response = basePage.getResponse();
        Assert.assertEquals(200, response.getStatusCode());
        Map<String, String> map = response.jsonPath().get("data");
        setPlanGroup(map.get("planGroup"));
        setPlanId(map.get("_id"));
        Assert.assertEquals(map.get("frequency"), 1);
        Assert.assertEquals(map.get("frequencyType"), "Weekly");
        Assert.assertEquals(map.get("status"), status);
        Assert.assertEquals(map.get("discount"), 10);
        Assert.assertEquals(map.get("shippingCost"), 20);
        Assert.assertEquals(map.get("isDeleted"), false);
        Assert.assertEquals(map.get("title"), "Automation Subscription Plan");
        Assert.assertEquals(map.get("description"), "Automation Subscription Plan");
    }

    public void verifyDuplicateFrequencyErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"),
                "Subscriptions with same frequency type already exist. Please try a different variation!");
    }

    public void verifyShippingCostErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"shippingCost\" must be greater than -1");
    }

    public void verifyStatusErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"status\" must be one of [ACTIVE, DRAFT]");
    }

    public void verifyInvalidPlanAttributeErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "Invalid plan attribute");
    }

    public void verifyInvalidPlanFrequencyErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"frequency\" must be greater than 0");
    }

    public void verifyInvalidPlanDiscountErrorMessage() {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"discount\" must be greater than or equal to 0");
    }

    public void verifyErrorMessage(String errorMessage) {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), errorMessage);
    }

    public void verifyErrorMessageForTitleAndDescriptionLength(boolean isTitle, String length) {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        if (isTitle) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"title\" length must be less than or equal to " + length + " characters long");
        } else {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"description\" length must be less than or equal to " + length + " characters long");
        }
    }

    public void verifyErrorMessageForMissingProperties(String property) {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        if (property.equalsIgnoreCase("title")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"title\" is required");
        } else if (property.equalsIgnoreCase("description")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"description\" is required");
        } else if (property.equalsIgnoreCase("frequency")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"frequency\" is required");
        } else if (property.equalsIgnoreCase("frequencyType")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"frequencyType\" is required");
        } else if (property.equalsIgnoreCase("products")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"products\" is required");
        } else if (property.equalsIgnoreCase("status")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"status\" is required");
        }
    }

    public void verifyPlanUpdateWithNewProduct() {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        Assert.assertEquals(basePage.getResponse().then().extract().path("data.plans[0].products[0].itemId"), FileHandler.getDataFromPropertyFile("productItem2"));
    }

    public void verifyPlanUpdatesProperty(String property, String value) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        List<Object> ll = basePage.getResponse().jsonPath().get("data.plans");
        Map<String, Object> mp = (Map<String, Object>) ll.get(0);
        if (mp.get(property) instanceof Integer) {
            Assert.assertEquals(mp.get(property), Integer.parseInt(value));
        } else {
            Assert.assertEquals(mp.get(property), value);
        }
    }

    public void verifyPlanStatusUpdatedTo(String status) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        Assert.assertEquals(status, basePage.getResponse().then().extract().path("data.plans[0].status"));
    }

//    public void verifyPropertyValueIn(String propertyValue, String property){
//        Assert.assertEquals(200, response.getStatusCode());
//        Assert.assertEquals(propertyValue, response.then().extract().path(property));
//    }

    public void verifyInvalidPlanStatusResponse(String status) {
        Assert.assertEquals(400, basePage.getResponse().getStatusCode());
        if (null != status && status.toLowerCase().contains("deleted")) {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "\"status\" must be one of [ACTIVE, DRAFT, ARCHIVED]");
        } else {
            Assert.assertEquals(basePage.getResponse().jsonPath().get("message"), "Invalid Plan Status");
        }
    }

    public void verifyResponseOfGetByItemIDPlan(boolean isEmpty) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        List<Object> ll = basePage.getResponse().jsonPath().get("data." + FileHandler.getDataFromPropertyFile("productItem1") + "");
        if (isEmpty) {
            Assert.assertEquals(ll, null);
        } else {
            Map<String, Object> mp = (Map<String, Object>) ll.get(0);
            Assert.assertEquals("Automation Subscription Plan", mp.get("title"));
        }
    }

    public void verifyPlanRecords(int noOfPlans, int pageNumber) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        JsonPath path = basePage.getResponse().jsonPath();
        Assert.assertEquals("", pageNumber, Integer.parseInt(path.get("data.page").toString()));
        Assert.assertEquals("", noOfPlans, Integer.parseInt(path.get("data.limit").toString()));
        int totalRecords = path.get("data.totalDocs");
        if (totalRecords >= noOfPlans) {
            Assert.assertEquals(noOfPlans, ((List<Object>) (path.get("data.docs"))).size());
        }
    }

    public void verifyOnlyPlansWithParticularStatusInResponse(String status) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        int size = ((List<Object>) (basePage.getResponse().jsonPath().get("data.docs"))).size();
        for (int i = 0; i < size; i++) {
            Assert.assertEquals(basePage.getResponse().then().extract().path("data.docs[" + i + "].Plan.status"), status);
        }
    }

    public void verifyPlansShowingOnlyForDays(int noOfDays) {
        Assert.assertEquals(200, basePage.getResponse().getStatusCode());
        LocalDate currentDate = LocalDate.now();
        LocalDate currentDateMinusGivenDays = currentDate.minusDays(noOfDays+1);
        int size = ((List<Object>) (basePage.getResponse().jsonPath().get("data.docs"))).size();
        for (int i = 0; i < size; i++) {
            String[] date = basePage.getResponse().then().extract().path("data.docs[" + i + "].Plan.createdAt").toString().split("T");
            int day = Integer.parseInt(date[0].split("-")[2]);
            int month = Integer.parseInt(date[0].split("-")[1]);
            int year = Integer.parseInt(date[0].split("-")[0]);
            LocalDate date1 = LocalDate.of(year, month, day);
            Assert.assertTrue(date1.isAfter(currentDateMinusGivenDays) && date1.isBefore(currentDate.plusDays(1)));
        }
    }

    public String getCountOf(String status) {
        List<HashMap<String, String>> ll1 = basePage.getResponse().jsonPath().get("data.statusCount");
        for (Map<String, String> map :
                ll1) {
            if (map.get("_id").equals(status)) {
                return String.valueOf(map.get("total"));
            }
        }
        return null;
    }
}