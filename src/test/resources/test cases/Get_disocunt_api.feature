Business Need: Get all the discount codes

  Scenario: get all the discounts
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 200
    Then I should see all the created discounts

  Scenario: get subscription discount by discount code
    Given I have endpoint "/subscriptionDiscounts/SUB-F9141646391834000"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 200
    Then I should see all the created discounts by id

  Scenario: no discounts with 0 count
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 200
    Then I should see that the response is positive and 0 discount codes in the response

  Scenario: Verify autherisation error if auth taken is missing
    Given I have endpoint "/discount/getDiscount"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 400
    Then I should see error response saying that the auth token is missing