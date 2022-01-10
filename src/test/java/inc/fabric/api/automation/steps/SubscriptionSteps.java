package inc.fabric.api.automation.steps;

import inc.fabric.api.automation.pages.CommonPage;
import inc.fabric.api.automation.pages.SubscriptionPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class SubscriptionSteps {
    public SubscriptionPage subscriptionPage;
    public CommonPage commonPage;

    public SubscriptionSteps(SubscriptionPage subscriptionPage, CommonPage commonPage){
        this.subscriptionPage = subscriptionPage;
        this.commonPage = commonPage;
    }

    @And("^I have (create|update|skip subscription) subscription endpoint$")
    public void subEndPoint(String endPoint){
        subscriptionPage.getSubEndPoint(endPoint);
    }

    @And("^I have request payload for create (ACTIVE|INACTIVE) subscription api$")
    public void iHaveRequestPayloadForCreateSubscriptionApi(String status) {
        subscriptionPage.getRequestPayloadForSubscriptionAPI(status);
    }

    @Then("^I verify (ACTIVE|INACTIVE) subscription is created$")
    public void iVerifyACTIVESubscriptionIsCreated(String status) {
        subscriptionPage.verifySubscriptionCreation(status);
    }

    @And("I have updated property {string} as {string} in subscription payload")
    public void iHaveUpdatedInSubscriptionPayload(String property, String propertyValue) {
        subscriptionPage.updateSubscriptionProperty(property, propertyValue);
    }

    @And("I have added child items")
    public void iHaveAddedChildItems() {
        subscriptionPage.addChildItems();
    }

    @And("^I have added (empty giftSettings|giftSettings) in subscription payload$")
    public void iHaveAddedGitSettingsInSubscriptionPayload(String empty) {
        subscriptionPage.addGifSettings(empty.contains("empty"));
    }

    @And("I have following request payload for update subscription api :")
    public void iHaveFollowingRequestPayloadForUpdateSubscriptionApi(String payload) {
        commonPage.createRequestPayload(payload);
    }

    @When("I have saved property {string} as {string}")
    public void iHaveSavedSchedules(String property, String key) {
        subscriptionPage.savePropertyValue(property,key);
    }

    @Then("^I verify \"([^\"]+)\" date updated is after \"([^\"]+)\" (weeks|days|months|years)$")
    public void iVerifyDateUpdatedIsAfterWeeks(String key, String afterNoOf, String type) {
        subscriptionPage.verifyDatesOf(key, afterNoOf, type);
    }

    @And("I have set the nextPaymentDate as {string} by {int} days")
    public void iHaveSetTheNextPaymentDateAsByDays(String key, int days) {
        subscriptionPage.setNextPaymentDate(key, days);
    }
}
