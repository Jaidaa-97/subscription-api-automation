Business Need: Filter order
  Scenario: Search order by SKU
    Given I have endpoint "/data-subscription/v1/orders?sku=PROTEIN_1"
    And I run get call api
    Then I see response code 200

  Scenario: Search orders by status
    Given I have endpoint "/data-subscription/v1/orders?status=SKIPPED"
    And I run get call api
    Then I see response code 200
    Then I see property value "SKIPPED" is present in the response property "data.orders[0].status"

  Scenario: Search orders by customer ID
    Given I have endpoint "/data-subscription/v1/orders?customerId=639042a38ddb220008b049d1"
    And I run get call api
    Then I see response code 200
    Then I see property value "639042a38ddb220008b049d1" is present in the response property "data.orders[0].customer.id"

  Scenario: Search orders by subscription ID
    Given I have endpoint "/data-subscription/v1/orders?search=639042a48ddb220008b049d6"
    And I run get call api
    Then I see response code 200
    Then I see property value "639042a48ddb220008b049d6" is present in the response property "data.orders[0].lineItems[0].subscription.id"

  Scenario: Search orders by customer name
    Given I have endpoint "/data-subscription/v1/orders?search=shubham"
    And I run get call api
    Then I see response code 200
    Then I see property value "shubham" is contains in the response property "data.orders[0].customer.fullName"

  Scenario: Search orders by Scheduled valid date range
    Given I have endpoint "/data-subscription/v1/orders?from=2022-12-15T14:48:28.285Z&to=2022-12-18T14:02:37.497Z"
    And I run get call api
    Then I see response code 200
