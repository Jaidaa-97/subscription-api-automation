Business Need: Filter customer
  Scenario: Search customer by customer ID
    Given I have endpoint "/data-subscription/v1/customers?search=637626d2a80e160008db3512"
    And I run get call api
    Then I see response code 200
    Then I see property value "637626d2a80e160008db3512" is present in the response property "data.customers[0].id"

  Scenario: Search customer by customer name
    Given I have endpoint "/data-subscription/v1/customers?search=jiya"
    And I run get call api
    Then I see response code 200
    Then I see property value "jiya" is contains in the response property "data.customers[0].fullName"

  Scenario: Search customer by status
    Given I have endpoint "/data-subscription/v1/customers?status=INACTIVE"
    And I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is contains in the response property "data.customers[0].status"