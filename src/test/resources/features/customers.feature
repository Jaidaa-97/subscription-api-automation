@customers @regression
Business Need: Customers


  @getAllCustomers @searchCustomer @sanity
  Scenario: Get all subscribers
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And validate schema "createSubscription.json"
    Then I verify ACTIVE subscription is created
    Given I have endpoint "/data-subscription/customers?pageSize=1&pageNumber=1"
    When I run get call api
    Then validate schema "getAllCustomers.json"
    Then I see response code 200
    # Search customer
    Given I have endpoint "/data-subscription/customers?pageSize=35&pageNumber=1&search=jitendra.pisal1@fabric.inc"
    When I run get call api
    Then validate schema "getAllCustomers.json"
    Then I see response code 200
    Then I see value "jitendra.pisal1@fabric.inc" is contains in property "customerEmail" inside the property array "data.customers"


  @getSingleCustomer @sanity
  Scenario: Get single subscribers
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And validate schema "createSubscription.json"
    Then I verify ACTIVE subscription is created
    Given I have endpoint "/data-subscription/customers?pageSize=35&pageNumber=1&search=jitendra.pisal1@fabric.inc"
    When I run get call api
    Then validate schema "getAllCustomers.json"
    Then I see response code 200
    Then I have saved property "data.customers[0]._id" as "customerId"
    Given I have endpoint "/data-subscription/customers/{SavedValue::customerId}"
    When I run get call api
    Then validate schema "getSingleCustomer.json"
    Then I see response code 200
    Then I see property value "jitendra.pisal1@fabric.inc" is present in the response property "data.customerEmail"
