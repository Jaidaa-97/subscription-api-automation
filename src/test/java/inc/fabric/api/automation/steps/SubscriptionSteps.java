package inc.fabric.api.automation.steps;

import inc.fabric.api.automation.pages.SubscriptionPage;
import io.cucumber.java.en.And;

public class SubscriptionSteps {
    public SubscriptionPage subscriptionPage;

    public SubscriptionSteps(SubscriptionPage subscriptionPage){
        this.subscriptionPage = subscriptionPage;
    }

    @And("^I have (create) subscription endpoint$")
    public void subEndPoint(String endPoint){
        subscriptionPage.getSubEndPoint(endPoint);
    }

    @And("I have request payload for create subscription api")
    public void iHaveRequestPayloadForCreateSubscriptionApi() {
        subscriptionPage.getRequestPayloadForSubscriptionAPI();
    }
}
