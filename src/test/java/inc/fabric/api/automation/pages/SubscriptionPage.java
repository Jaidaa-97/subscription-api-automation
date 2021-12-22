package inc.fabric.api.automation.pages;

import com.google.gson.JsonObject;
import inc.fabric.api.automation.contstants.APIConstants;
import inc.fabric.api.automation.utility.FileHandler;

import java.util.Random;

public class SubscriptionPage extends BasePage{
    private String subEndPoint;
    public BasePage basePage;
    public PlansPage plansPage;

    public SubscriptionPage(BasePage basePage, PlansPage plansPage){
        this.basePage = basePage;
        this.plansPage = plansPage;
    }

    public String getOrderId(){
        String order1 = "6803-5058-";
        Random r = new Random( System.currentTimeMillis());
        return order1+(10000 + r.nextInt(20000));
    }

    public void getSubEndPoint(String endPoint){
        endPoint = endPoint.toLowerCase();
        switch (endPoint) {
            case "create":
                subEndPoint = getBaseURL() + "/data-subscription/" + APIConstants.CREATE_SUBSCRIPTION;
                break;
        }
        basePage.setEndPoint(subEndPoint);
        scenario.write("End Point : "+subEndPoint);
    }

    public void getRequestPayloadForSubscriptionAPI(){
        JsonObject requestPayload = FileHandler.getDataFromJson("request-payload/createSubscription.json");
        String body = requestPayload.toString().replace("{{order}}",getOrderId());
        body = body.replace("{{planID}}",plansPage.getPlanId());
        basePage.setBody(body);
    }
}
