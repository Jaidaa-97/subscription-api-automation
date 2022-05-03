package inc.fabric.api.automation.steps;

import inc.fabric.api.automation.pages.BasePage;
import inc.fabric.api.automation.pages.CommonPage;
import inc.fabric.api.automation.pages.SubscriptionPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class SubscriptionSteps {
    public SubscriptionPage subscriptionPage;
    public CommonPage commonPage;

    public SubscriptionSteps(SubscriptionPage subscriptionPage, CommonPage commonPage){
        this.subscriptionPage = subscriptionPage;
        this.commonPage = commonPage;
    }

    @And("^I have (create|update|skip subscription|delete|get by id|get by order id|get order by subId|get order by customerId) subscription endpoint$")
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

    @Given("I have created customer for gnc")
    public void iHaveCreatedCustomerForGnc() {
        subscriptionPage.createCustomer();
    }

    @Given("^I have created( .*)? bulk subscription$")
    public void iHaveCreatedBulkSubscription(int number) {
        subscriptionPage.createBulkSubscription(number);
    }

    @And("I get the index of order for subscription {string} as {string}")
    public void iGetTheIndexOfOrderForSubscriptionAs(String subscription, String key) {
        subscriptionPage.getIndexOfSubscriptionInOrder(subscription,key);
    }

    @And("I get the order id of subscription at index {string} and saved it as {string}")
    public void iGetTheOrderIdOfSubscriptionAtIndexAndSavedItAs(String index, String key) {
        subscriptionPage.saveOrderId(index,key);
    }

    @Given("I have removed lineItem {int} from an order {string}")
    public void iHaveRemovedLineItemFromAnOrder(int lineItem, String orderId) {
        subscriptionPage.removeLineItemFromOrder(lineItem,orderId);
    }

    @When("I get the subscription by id {string}")
    public void getSubById(String subId) {
        subscriptionPage.getSubscriptionById(subId);
    }

    @When("I discontinued item {string}")
    public void iDiscontinuedItem(String sku) {
        subscriptionPage.discontinueItem(sku);
    }

    @When("I get all the subscription of an item {string}")
    public void iGetAllTheSubscriptionOfAnItem(String sku) {
        subscriptionPage.getAllSubscriptionOfSKU(sku);
    }

    @And("I see all the subscription of discontinued item gets deactivated")
    public void iSeeAllTheSubscriptionOfDiscontinuedItemGetsDeactivated() {
        subscriptionPage.verifyAllSubsGetDiactivatedForDiscItem();
    }

    @When("I get all the orders placed by customer {string}")
    public void iGetAllTheOrdersPlacedByCustomer(String customerId) {
        subscriptionPage.getAllOrdersPlacedByCustomer(customerId);
    }

    @When("I get the order by id {string}")
    public void iGetTheOrderById(String orderId) {
        subscriptionPage.getOrderById(orderId);
    }

    @When("add item {string} in order {string}")
    public void iAddItemInOrder(String item, String orderId) {
        subscriptionPage.addItemInOrder(item, orderId);
    }
}
