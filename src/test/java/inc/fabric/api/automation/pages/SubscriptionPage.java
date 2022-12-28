package inc.fabric.api.automation.pages;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import inc.fabric.api.automation.contstants.APIConstants;
import inc.fabric.api.automation.utility.CommonUtils;
import inc.fabric.api.automation.utility.FileHandler;
import org.apache.poi.ss.formula.functions.T;
import org.junit.Assert;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import java.time.Instant;

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
            case "delete":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION+"/"+getSubscriptionId();
                break;
            case "get by id":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION+"/";
                break;
            case "get by order id":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.ORDERS+"/";
                break;
            case "get order by subid":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.ORDERS+"/get-by-subscriptionId/";
                break;
            case "get order by customerid":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.ORDERS+"/get-by-customer/";
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
        JsonArray childItems = new JsonArray();

        quantity1.addProperty("itemID", FileHandler.getDataFromPropertyFile("productItem2"));
        quantity1.addProperty("quantity", 3);

        childItems.add(quantity1);

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

    public void saveDatePropertyValue(String key){
        Instant instant = Instant.now();
        Instant t2 = instant.plus(15, ChronoUnit.MINUTES);
        String updatedDate = t2.toString();
        savedValues.put(key,updatedDate);
    }

    public void saveStaticPropertyValue(String property, String key){
        savedValues.put(key,property);
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

    public void createCustomer() {
        commonPage.getEndPoint("/data-subscription/v1/customers");
        String payload = "{\n" +
                "           \"customerReferenceId\": \"606f01f441b8fc0"+CommonUtils.getRandomNumberFourDigit()+"\",\n" +
                "          \"locale\": \"fr_CAB\",\n" +
                "          \"email\": \"customer"+CommonUtils.getRandomNumberFourDigit()+"-"+CommonUtils.getRandomNumberFourDigit()+"@gmail.com\",\n"+
                "          \"contactNumber\": \"+92 3333709569\",\n" +
                "          \"firstName\": \"Jitendra\",\n" +
                "          \"lastName\": \"Pisal\",\n" +
                "          \"middleName\":\"Dilip\",\n" +
                "          \"segment\": [ \"employee\"],\n" +
                "          \"employeeId\": \"108A\",\n" +
                "          \"communicationPreference\": {\n" +
                "            \"SMS\": true,\n" +
                "            \"email\":true\n" +
                "        }\n" +
                "    }";
        commonPage.requestPayload(payload);
        commonPage.runPostCall();
        basePage.getResponse().then().assertThat().statusCode(200);
    }

    public void createSKU(){
        commonPage.getPimEndPoint("/api-pim-external/product");
        String payload = "{\n" +
                "   \"productSku\":\""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_sku4")+"\",\n" +
                "   \"itemType\": \"Item\",\n" +
                "   \"title\": \"test\",\n" +
                "    \"attributes\": {\n" +
                "       \"isSubscription\": \"true\",\n" +
                "       \"isDiscontinued\": \"false\",\n" +
                "       \"skuSwap\": [\n" +
                "           \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_swapproduct")+"\"\n" +
                "       ]\n" +
                "       }\n" +
                "      }";
        commonPage.requestPayload(payload);
        commonPage.runPimPostCall();
        basePage.getResponse().then().assertThat().statusCode(200);
    }

    public void createDisSKU(){
        commonPage.getPimEndPoint("/api-pim-external/product");
        String payload = "{\n" +
                "   \"productSku\": \"VITAMIN_"+CommonUtils.getRandomNumberFourDigit()+"\",\n" +
                "   \"itemType\": \"Item\",\n" +
                "   \"title\": \"test\",\n" +
                "    \"attributes\": {\n" +
                "       \"isSubscription\": \"true\",\n" +
                "       \"isDiscontinued\": \"false\",\n" +
                "       \"skuSwap\": [\n" +
                "           \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_swapproduct")+"\"\n" +
                "       ]\n" +
                "       }\n" +
                "      }";
        commonPage.requestPayload(payload);
        commonPage.runPimPostCall();
        basePage.getResponse().then().assertThat().statusCode(200);
    }

    public void createBulkSubscription(int noOfSubscriptions) {
        commonPage.getEndPoint("/data-subscription/v1/subscriptions/bulk");
        String payload = "{\n" +
                "            \"channel\": \"POS\",\n" +
                "            \"customer\": {\n" +
                "                \"customerReferenceId\": \""+CommonUtils.getRandomNumberFourDigit()+CommonUtils.getRandomNumberFourDigit()+CommonUtils.getRandomNumberFourDigit()+CommonUtils.getRandomNumberFourDigit()+"\",\n" +
                "                \"locale\": \"en_US\",\n" +
                "                \"email\": \""+CommonUtils.getRandomEmail()+"\",\n" +
                "                \"contactNumber\": \"923333709568\",\n" +
                "                \"firstName\": \"John\",\n" +
                "                \"lastName\": \"Doe\",\n" +
                "                \"segment\": [\"employee\"],\n" +
                "                \"employeeId\": \"1\"\n" +
                "            },\n" +
                "            \"items\": [\n" +
                "                {\n" +
                "                    \"sku\":\""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_sku1")+"\",\n" +
                "                    \"quantity\": 2,\n" +
                "                    \"weight\": 10,\n" +
                "                    \"weightUnit\": \"lb\",\n" +
                "                    \"itemPrice\": {\n" +
                "                        \"price\": 100.00,\n" +
                "                        \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"tax\": {\n" +
                "                        \"taxCode\": \"FR020000\",\n" +
                "                        \"taxAmount\": 10.00,    \n" +
                "                        \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"plan\": {\n" +
                "                        \"frequency\": 5,\n" +
                "                        \"frequencyType\": \"Daily\"\n" +
                "                    },\n" +
//                "                    \"offsetDays\": 10,\n" +
                "                    \"offer\": {\n" +
                "                        \"id\": \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_offercode")+"\"\n" +
//                "                        \"source\": \"PDP\"\n" +
                "                    },\n" +
                "                    \"shipping\": {\n" +
                "                      \"shipmentCarrier\": \"USPS\",\n" +
                "                      \"shipmentMethod\": \"Ground\",\n" +
                "                      \"shipmentInstructions\": \"\",\n" +
                "                      \"taxCode\": \"SHP020000\",\n" +
                "                      \"shippingAmount\": 10.00,\n" +
                "                      \"taxAmount\": 1.00,\n" +
                "                      \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"expiry\": {\n" +
                "                        \"billingCycles\": 10\n" +
                "                    }\n" +
                "                },\n" +
                "                {\n" +
                "                    \"sku\": \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_sku2")+"\",\n" +
                "                    \"quantity\": 2,\n" +
                "                    \"weight\": 10,\n" +
                "                    \"weightUnit\": \"lb\",\n" +
                "                    \"itemPrice\": {\n" +
                "                        \"price\": 100.00,\n" +
                "                        \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"tax\": {\n" +
                "                        \"taxCode\": \"FR020000\",\n" +
                "                        \"taxAmount\": 10.00,    \n" +
                "                        \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"plan\": {\n" +
                "                        \"frequency\": 5,\n" +
                "                        \"frequencyType\": \"Daily\"\n" +
                "                    },\n" +
//                "                    \"offsetDays\": 10,\n" +
                "                    \"offer\": {\n" +
                "                        \"id\": \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_offercode2")+"\"\n" +
//                "                        \"source\": \"PDP\"\n" +
                "                    },\n" +
                "                    \"shipping\": {\n" +
                "                      \"shipmentCarrier\": \"USPS\",\n" +
                "                      \"shipmentMethod\": \"Ground\",\n" +
                "                      \"shipmentInstructions\": \"\",\n" +
                "                      \"taxCode\": \"SHP020000\",\n" +
                "                      \"shippingAmount\": 10.00,\n" +
                "                      \"taxAmount\": 1.00,\n" +
                "                      \"currencyCode\": \"USD\"\n" +
                "                    },\n" +
                "                    \"expiry\": {\n" +
                "                        \"billingCycles\": 10\n" +
                "                    }\n" +
                "                }\n" +
                "                \n" +
                "            ],\n" +
                "            \"shipTo\": {\n" +
                "                \"name\": {\n" +
                "                    \"firstName\": \"Roger\",\n" +
                "                    \"middleName\": \"\",\n" +
                "                    \"lastName\": \"Fang\"\n" +
                "                },\n" +
                "                \"streetAddress\": {\n" +
                "                    \"street1\": \"27 O ST\",\n" +
                "                    \"street2\": \"\"\n" +
                "                },\n" +
                "                \"phone\": {\n" +
                "                    \"number\": \"03323370957\",\n" +
                "                    \"kind\": \"mobile\"\n" +
                "                },\n" +
                "                \"city\": \"BOSTON MA\",\n" +
                "                \"state\": \"MA\",\n" +
                "                \"postalCode\": \"2127\",\n" +
                "                \"country\": \"US\"\n" +
                "            },\n" +
                "            \"billTo\": {\n" +
                "                \"name\": {\n" +
                "                    \"firstName\": \"Roger\",\n" +
                "                    \"middleName\": \"\",\n" +
                "                    \"lastName\": \"Fang\"\n" +
                "                },\n" +
                "                \"streetAddress\": {\n" +
                "                    \"street1\": \"27 O ST\",\n" +
                "                    \"street2\": \"\"\n" +
                "                },\n" +
                "                \"phone\": {\n" +
                "                    \"number\": \"012323370957\",\n" +
                "                    \"kind\": \"mobile\"\n" +
                "                },\n" +
                "                \"city\": \"BOSTON MA\",\n" +
                "                \"state\": \"MA\",\n" +
                "                \"postalCode\": \"2127\",\n" +
                "                \"country\": \"US\"\n" +
                "            },\n" +
                "            \"paymentDetails\": {\n" +
                "                \"paymentIdentifier\": {\n" +
                "                    \"cardIdentifier\": \"1234\",\n" +
                "                    \"expiryDate\": \"04/24\"\n" +
                "                },\n" +
                "                \"paymentMethod\": \"visa\", \n" +
                "                \"paymentKind\": \"CARD_PAYPAL\"\n" +
                "            }\n" +
                "      }";

        if (noOfSubscriptions == 1) {
            payload = "{\n" +
                    "    \"channel\": \"POS\",\n" +
//                    "    \"originOrderId\": \""+CommonUtils.getRandomNumberFourDigit()+"-"+CommonUtils.getRandomNumberFourDigit()+"-"+CommonUtils.getRandomNumberFourDigit()+"\",\n" +
                    "    \"customer\": {\n" +
                    "        \"customerReferenceId\": \"606f01f441b8fc00"+CommonUtils.getRandomNumberFourDigit()+CommonUtils.getRandomNumberFourDigit()+"\",\n" +
                    "        \"locale\": \"en_US\",\n" +
                    "        \"email\": \""+CommonUtils.getRandomEmail()+"\",\n" +
                    "        \"contactNumber\": \"+91 3333709568\",\n" +
                    "        \"firstName\": \"shubham\",\n" +
                    "        \"lastName\": \"Pisal\",\n" +
                    "        \"segment\": [\"employee\"],\n" +
                    "        \"employeeId\": \"1\"\n" +
                    "    },\n" +
                    "    \"items\": [\n" +
                    "        {\n" +
                    "            \"sku\":\""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_sku1")+"\",\n" +
                    "            \"quantity\": 2,\n" +
                    "            \"weight\": 10,\n" +
                    "            \"weightUnit\": \"lb\",\n" +
                    "            \"itemPrice\": {\n" +
                    "                \"price\": 100.00,\n" +
                    "                \"currencyCode\": \"USD\"\n" +
                    "            },\n" +
                    "            \"tax\": {\n" +
                    "                \"taxCode\": \"FR020000\",\n" +
                    "                \"taxAmount\": 10.00,    \n" +
                    "                \"currencyCode\": \"USD\"\n" +
                    "            },\n" +
                    "            \"plan\": {\n" +
//                    "                \"id\": \"637359fe13c6ba00087a5c0f\",\n" +
                    "                \"frequency\": 5,\n" +
                    "                \"frequencyType\": \"Daily\"\n" +
                    "            },\n" +
             //       "            \"offsetDays\": 2,\n" +
                    "            \"offer\": {\n" +
                    "                \"id\": \""+FileHandler.readPropertyFile("data.properties",CommonUtils.getEnv().toLowerCase()+"_offercode")+"\"\n" +
             //       "                \"source\": \"PDP\"\n" +
                    "            },\n" +
                    "            \"shipping\": {\n" +
                    "              \"shipmentCarrier\": \"USPS\",\n" +
                    "              \"shipmentMethod\": \"Ground\",\n" +
                    "              \"shipmentInstructions\": \"\",\n" +
                    "              \"taxCode\": \"SHP020000\",\n" +
                    "              \"shippingAmount\": 10.00,\n" +
                    "              \"taxAmount\": 1.00,\n" +
                    "              \"currencyCode\": \"USD\"\n" +
                    "            },\n" +
                    "            \"expiry\": {\n" +
                    "                \"billingCycles\": 2\n" +
                    "            }\n" +
                    "        }\n" +
                    "    ],\n" +
                    "    \"shipTo\": {\n" +
                    "        \"name\": {\n" +
                    "            \"firstName\": \"Roger\",\n" +
                    "            \"middleName\": \"\",\n" +
                    "            \"lastName\": \"Fang\"\n" +
                    "        },\n" +
                    "        \"streetAddress\": {\n" +
                    "            \"street1\": \"27 O ST\",\n" +
                    "            \"street2\": \"\"\n" +
                    "        },\n" +
                    "        \"phone\": {\n" +
                    "            \"number\": \"03323370957\",\n" +
                    "            \"kind\": \"mobile\"\n" +
                    "        },\n" +
                    "        \"city\": \"BOSTON MA\",\n" +
                    "        \"state\": \"MA\",\n" +
                    "        \"postalCode\": \"2127\",\n" +
                    "        \"country\": \"US\"\n" +
                    "    },\n" +
                    "    \"billTo\": {\n" +
                    "        \"name\": {\n" +
                    "            \"firstName\": \"Roger\",\n" +
                    "            \"middleName\": \"\",\n" +
                    "            \"lastName\": \"Fang\"\n" +
                    "        },\n" +
                    "        \"streetAddress\": {\n" +
                    "            \"street1\": \"27 O ST\",\n" +
                    "            \"street2\": \"\"\n" +
                    "        },\n" +
                    "        \"phone\": {\n" +
                    "            \"number\": \"012323370957\",\n" +
                    "            \"kind\": \"mobile\"\n" +
                    "        },\n" +
                    "        \"city\": \"BOSTON MA\",\n" +
                    "        \"state\": \"MA\",\n" +
                    "        \"postalCode\": \"2127\",\n" +
                    "        \"country\": \"US\"\n" +
                    "    },\n" +
                    "    \"paymentDetails\": {\n" +
                    "        \"paymentIdentifier\": {\n" +
                    "            \"cardIdentifier\": \"1234\",\n" +
                    "            \"expiryDate\": \"04/24\"\n" +
                    "        },\n" +
                    "        \"paymentMethod\": \"visa\", \n" +
                    "        \"paymentKind\": \"CARD_PAYPAL\"\n" +
                    "    },\n" +
                    "    \"customAttributes\": {\n" +
                    "        \"storeId\": \"1234567890\",\n" +
                    "        \"storeAssociateId\": \"jitu\",\n" +
                    "        \"trackingUrl\": \"http://google.com\"\n" +
                    "    }\n" +
                    "}";
        }

        commonPage.requestPayload(payload);
        commonPage.runPostCall();
        basePage.getResponse().then().assertThat().statusCode(200);
    }

    public void getIndexOfSubscriptionInOrder(String subscription, String key) {
        ArrayList list = (ArrayList<T>) (basePage.getResponse().then().extract().path("data.orders"));
        int size = list.size();
        int index = 0;

        while (size > index) {
            String sub = basePage.getResponse().then().extract().path("data.orders["+index+"].lineItems[0].subscription.id");
            if (subscription.equalsIgnoreCase(sub)) {
                break;
            }
            index++;
        }
        savedValues.put(key,String.valueOf(index));
    }

    public void saveOrderId(String index, String key) {
        String orderId = basePage.getResponse().then().extract().path("data.orders["+index+"].id");
        savedValues.put(key,orderId);
    }

    public void removeLineItemFromOrder(int lineItem, String orderId) {
        commonPage.getEndPoint("/data-subscription/v1/orders/"+orderId+"/remove-items");
        String payload = "{\n" +
                "    \"lineItemIds\": ["+lineItem+"]\n" +
                "}";
        commonPage.requestPayload(payload);
        commonPage.runPostCall();
    }

    public void getSubscriptionById(String subId) {
        commonPage.getEndPoint("/data-subscription/v1/subscriptions/"+subId+"");
        commonPage.runGetCall(false,null);
    }

    public void discontinueItem(String sku) {
        commonPage.getEndPoint("/data-subscription/v1/subscriptions/discontinued-items");
        String payload = "{\n" +
                "    \"sku\": [\""+sku+"\"]\n" +
                "}";
        commonPage.requestPayload(payload);
        commonPage.runPostCall();
    }

    public void getAllSubscriptionOfSKU(String sku) {
        commonPage.getEndPoint("/data-subscription/v1/subscriptions?limit=10&offset=0&sku="+sku+"");
        commonPage.runGetCall(false,null);
    }

    public void verifyAllSubsGetDiactivatedForDiscItem() {
        ArrayList list = basePage.getResponse().then().extract().path("data.subscriptions");

        for (int i = 0; i < list.size(); i++) {
            String status = basePage.getResponse().then().extract().path("data.subscriptions["+i+"].status");
            String id = basePage.getResponse().then().extract().path("data.subscriptions["+i+"].id");
            System.out.println("status --------->");
            System.out.println(status);
            System.out.println("id --------->");
            System.out.println(id);
            Assert.assertEquals(status,"INACTIVE");
        }
    }

    public void getAllOrdersPlacedByCustomer(String customerId) {
        commonPage.getEndPoint("/data-subscription/v1/customers/"+customerId+"/orders");
        commonPage.runGetCall(false,null);
    }

    public void getOrderById(String orderId) {
        commonPage.getEndPoint("/data-subscription/v1/orders/"+orderId+"");
        commonPage.runGetCall(false,null);
    }

    public void addItemInOrder(String item, String orderId) {
        commonPage.getEndPoint("/data-subscription/v1/orders/"+orderId+"/add-items");
        String payload = "{\n" +
                "    \"lineItems\": [\n" +
                "        {\n" +
                "            \n" +
                "            \"item\": {\n" +
                "                \"sku\": \""+item+"\",\n" +
                "                \"quantity\": 2,\n" +
                "                \"weight\": 10,\n" +
                "                \"weightUnit\": \"lb\",\n" +
                "                \"itemPrice\": {\n" +
                "                    \"price\": 100.00,\n" +
                "                    \"currencyCode\": \"USD\"\n" +
                "                },\n" +
                "                \"tax\": {\n" +
                "                    \"taxCode\": \"FR020000\",\n" +
                "                    \"taxAmount\": 10.00,\n" +
                "                    \"currencyCode\": \"USD\"\n" +
                "                }\n" +
                "            },\n" +
                "            \"shipping\": {\n" +
                "                \"shipmentCarrier\": \"USPS\",\n" +
                "                \"shipmentMethod\": \"Ground\",\n" +
                "                \"shipmentInstructions\": \"\",\n" +
                "                \"taxCode\": \"SHP020000\",\n" +
                "                \"shippingAmount\": 10.00,\n" +
                "                \"taxAmount\": 1.00,\n" +
                "                \"currencyCode\": \"USD\"\n" +
                "            },\n" +
                "            \"customAttributes\": {\n" +
                "                \"storeId\": \"60cb07fc20387b000821c5c3\",\n" +
                "                \"associateId\": 1,\n" +
                "                \"trackingUrl\": \"609436d21baded0008945b05\"\n" +
                "            }\n" +
                "        }\n" +
                "    ]\n" +
                "}";
        commonPage.requestPayload(payload);
        commonPage.runPostCall();
    }
}
