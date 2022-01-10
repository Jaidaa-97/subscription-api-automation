package inc.fabric.api.automation.steps;

import inc.fabric.api.automation.pages.BasePage;
import inc.fabric.api.automation.pages.CommonPage;
import inc.fabric.api.automation.pages.PlansPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class PlansSteps extends BasePage {
    public PlansPage plansPage;
    public CommonPage commonPage;

    public PlansSteps(PlansPage plansPage, CommonPage commonPage) {
        this.plansPage = plansPage;
        this.commonPage = commonPage;
    }

    @Given("^I have (create plan|update plan|get plan count|get plan v3|get by itemid|get plan by id|get plan by groupId) endpoint$")
    public void getEndPoint(String endPoint) throws IOException {
        plansPage.getPlanEndPoint(endPoint);
    }

    @And("I have access token")
    public void iHaveAccessToken() {
        plansPage.getAccessToken();
    }

    @And("I have request payload for create plan api")
    public void iHaveRequestPayloadForCreatePlanApi() {
        plansPage.requestBodyForCreatePlanAPI();
    }

    @And("I have request payload for update plan api")
    public void iHaveRequestPayloadForUpdatePlanApi() {
        plansPage.requestBodyForUpdatePlanAPI();
    }

    @When("^I run the create plan api( again)?$")
    public void iRunTheCreatePlanApi(String runAgain) {
        commonPage.runPostCall();
    }

    @Then("^I see that the plan is created with status (DRAFT|ACTIVE)?$")
    public void iSeeThatThePlanIsCreated(String status) {
        plansPage.verifyPlanCreation(status);
    }

    @Then("I see that error message is showing while creating plan with product which already part of another plan")
    public void iSeeThatErrorMessageIsShowingWhileCreatingPlanWithProductWhichAlreadyPartOfAnotherPlan() {
        plansPage.verifyDuplicateFrequencyErrorMessage();
    }

    @And("I have copied planId")
    public void iHaveCopiedPlanId() {
        plansPage.copyPlanId();
    }

    @And("I have updated shipping cost to {int}")
    public void iHaveUpdatedShippingCostTo(int cost) {
        plansPage.updateShippingCost(cost);
    }

    @Then("I see error message for shipping cost which can not be less than 0")
    public void iSeeErrorMessageForShippingCostWhichCanNotBeLessThan() {
        plansPage.verifyShippingCostErrorMessage();
    }

    @And("I have updated plan status to {string}")
    public void iHaveUpdatedPlanStatusTo(String planStatus) {
        plansPage.updatePlanStatus(planStatus);
    }

    @Then("I see error message if try to create a plan with status other than active or draft")
    public void iSeeErrorMessageIfTryToCreateAPlanWithStatusOtherThanActiveOrDraft() {
        plansPage.verifyStatusErrorMessage();
    }

    @And("I have added new attributes in payload")
    public void iHaveAddedNewAttributesInPayload() {
        plansPage.addNewAttributeProperty();
    }

    @Then("I see error message for invalid plan attribute")
    public void iSeeErrorMessageForInvalidInvalidPlanAttribute() {
        plansPage.verifyInvalidPlanAttributeErrorMessage();
    }

    @And("I have updated plan frequency to {int}")
    public void iHaveUpdatedPlanFrequencyTo(int frequencyValue) {
        plansPage.updateFrequency(frequencyValue);
    }

    @Then("I see error message for invalid plan frequency")
    public void iSeeErrorMessageForInvalidPlanFrequency() {
        plansPage.verifyInvalidPlanFrequencyErrorMessage();
    }

    @And("I have updated plan discount to {int}")
    public void iHaveUpdatedPlanDiscountTo(int discount) {
        plansPage.updatePlanDiscount(discount);
    }

    @Then("I see error message for invalid plan discount")
    public void iSeeErrorMessageForInvalidPlanDiscount() {
        plansPage.verifyInvalidPlanDiscountErrorMessage();
    }

    @And("^I have updated plan (title|description) to \"([^\"]+)\"$")
    public void iHaveUpdatedPlanTitleOrDescriptionTo(String titleOrDesc, String planName) {
        plansPage.updatePlanTitleOrDescription(titleOrDesc.equalsIgnoreCase("title"), planName);
    }

    @Then("^I see error message for plan (title|description) with greater that (60|2000) characters$")
    public void iSeeErrorMessageForPlanTitleWithGreaterThatCharacters(String titleOrDescription, String length) {
        plansPage.verifyErrorMessageForTitleAndDescriptionLength(titleOrDescription.equalsIgnoreCase("title"), length);
    }

    @And("^I have removed \"([^\"]+)\" from payload$")
    public void iHaveRemovedTitleFromPayload(String property) {
        commonPage.removeParentProperty(property);
    }

    @Then("^I see error message for missing property (title|description|frequency|frequencyType|products|status)$")
    public void iSeeErrorMessageForMissingProperty(String propertyName) {
        plansPage.verifyErrorMessageForMissingProperties(propertyName);
    }

    @When("I have updated product in update plan api")
    public void iHaveUpdatedProductInUpdatePlanApi() {
        plansPage.updateProductInUpdatePlanPayload();
    }

    @And("I run the update plan api")
    public void iRunTheUpdatePlanApi() {
        commonPage.runUpdatePlanApi();
    }

    @Then("I see that the plan gets updated with new product")
    public void iSeeThatThePlanGetsUpdatedWithNewProduct() {
        plansPage.verifyPlanUpdateWithNewProduct();
    }

    @And("I have updated plan status to {string} in update plan payload")
    public void iHaveUpdatedPlanStatusToInUpdatePlanPayload(String status) {
        plansPage.updateStatusInPlanUpdatePayload(status);
    }

    @Then("^I see invalid plan status response( for DELETED)?$")
    public void iSeeInvalidPlanStatusResponse(String status) {
        plansPage.verifyInvalidPlanStatusResponse(status);
    }

//    @Then("^I see plan status updated to (ARCHIVED|ACTIVE)$")
//    public void iSeePlanStatusUpdatedToARCHIVED(String status) {
//        plansPage.verifyPlanStatusUpdatedTo(status);
//    }

    @Then("^I see that the (title|description|discount|shippingCost|frequency|frequencyType) gets updated to \"([^\"]+)\"$")
    public void iSeeThatThePlanGetsUpdated(String property, String value) {
        plansPage.verifyPlanUpdatesProperty(property, value);
    }

    @When("^I run get call api with following param:$")
    public void iRunGetPlanCountApi(List<Map<String, String>> list) {
        commonPage.runGetCall(true, list);
    }

    @When("^I run get call api$")
    public void iRunGetCall() {
        commonPage.runGetCall(false, null);
    }

    @And("I verify the plan status count")
    public void iVerifyThePlanStatusCount() {
        String count1 = plansPage.getCountOf("ACTIVE");
        plansPage.getAccessToken();
        plansPage.getPlanEndPoint("create plan");
        plansPage.requestBodyForCreatePlanAPI();
        commonPage.runPostCall();

        plansPage.getPlanEndPoint("get plan count");
        commonPage.runGetCall(false, null);
        String count2 = plansPage.getCountOf("ACTIVE");
        Assert.assertEquals(Integer.parseInt(count1) + 1, Integer.parseInt(count2));
    }

//    @Then("^I see property value \"([^\"]+)\" is present in the response property \"([^\"]+)\"$")
//    public void iSeePlanIsPresentInTheResponse(String propertyValue, String property) {
//        plansPage.verifyPropertyValueIn(propertyValue,property);
//    }

    @And("I have request payload for get by itemid endpoint as key {string} from data property")
    public void iHaveRequestPayloadForGetByItemidEndpoint(String itemId) {
        plansPage.payloadForGetByItemID(itemId);
    }

    @When("I run post call")
    public void iRunPostCall() {
        commonPage.runPostCall();
    }

    @Then("^I verify( empty)? response of getByItemId plans$")
    public void iVerifyResponseOfGetByItemIdPlans(String empty) {
        plansPage.verifyResponseOfGetByItemIDPlan(empty != null && "empty".contains(empty.trim()));
    }

    @Then("I see only {int} plans on page number {int}")
    public void iSeeOnlyPlansOnPageNumber(int numberOfPlans, int pageNumber) {
        plansPage.verifyPlanRecords(numberOfPlans, pageNumber);
    }

    @Then("I see only {string} plans in response")
    public void iSeeOnlyPlansInResponse(String status) {
        plansPage.verifyOnlyPlansWithParticularStatusInResponse(status);
    }

    @Then("I verify that plans are showing only for last {int} days")
    public void iVerifyThatPlansAreShowingOnlyForLastDays(int days) {
        plansPage.verifyPlansShowingOnlyForDays(days);
    }

    @And("^I have added incorrect (plan|group) id in the endpoint$")
    public void iHaveAddedIncorrectPlanIdInTheEndpoint(String optional) {
        plansPage.addIncorrectPlanIdInEndPoint();
    }

    @Then("I see error message {string}")
    public void iSeeErrorMessage(String errorMessage) {
        plansPage.verifyErrorMessage(errorMessage);
    }

    @Given("I have created active plan")
    public void iHaveCreateActivePlan() {
        plansPage.getPlanEndPoint("create plan");
        plansPage.requestBodyForCreatePlanAPI();
        commonPage.runPostCall();
        plansPage.verifyPlanCreation("ACTIVE");
    }

    @Given("I have created active plan with multiple products")
    public void iHaveCreateActivePlanWithMultipleProduct() {
        plansPage.getPlanEndPoint("create plan");
        plansPage.requestBodyWithMultipleProductsForCreatePlanAPI();
        commonPage.runPostCall();
        plansPage.verifyPlanCreation("ACTIVE");
    }
}
