Business Need: Filter plan
  Scenario: Search by plan id
    Given I have endpoint "/data-subscription/v1/plan?search=637339dd28eda800086f3964"
    And I run get call api
    Then I see response code 200
    Then I see property value "637339dd28eda800086f3964" is present in the response property "data.plans[0].id"

  Scenario: Search by plan name
    Given I have endpoint "/data-subscription/v1/plan?search=plan210"
    And I run get call api
    Then I see response code 200
    Then I see property value "plan210" is present in the response property "data.plans[0].name"

  Scenario: Search by frequency type Daily
    Given I have endpoint "/data-subscription/v1/plan?frequencyType=Daily"
    And I run get call api
    Then I see response code 200
    Then I see property value "Daily" is present in the response property "data.plans[0].frequencyType"

  Scenario: Search by frequency type Daily and Monthly
    Given I have endpoint "/data-subscription/v1/plan?frequencyType=Daily,Monthly"
    And I run get call api
    Then I see response code 200
    Then I see property value "Daily" is present in the response property "data.plans[0].frequencyType"
    Then I see property value "Monthly" is present in the response property "data.plans[0].frequencyType"

  Scenario: Search by frequency type Monthly and Yearly
    Given I have endpoint "/data-subscription/v1/plan?frequencyType=Yearly,Monthly"
    And I run get call api
    Then I see response code 200
    Then I see property value "Yearly" is present in the response property "data.plans[0].frequencyType"
    Then I see property value "Monthly" is present in the response property "data.plans[0].frequencyType"

  Scenario: Search for a plan by pass date range
    Given I have endpoint "/data-subscription/v1/plan?createdAt=2022-11-14T11:38:59.076Z"
    And I run get call api
    Then I see response code 200
    Then I see property value "2022-11-14T11:38:59.076Z" is present in the response property "data.plans[0].createdAt"

  Scenario: Search by status ACTIVE
    Given I have endpoint "/data-subscription/v1/plan?status=ACTIVE"
    And I run get call api
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.plans[0].status"

  Scenario: Search by status ARCHIVED
    Given I have endpoint "/data-subscription/v1/plan?status=ARCHIVED"
    And I run get call api
    Then I see response code 200

  Scenario: Search by status ARCHIVED and ACTIVE
    Given I have endpoint "/data-subscription/v1/plan?status=ARCHIVE,ACTIVE"
    And I run get call api
    Then I see response code 200

  Scenario: Search by status DRAFT
    Given I have endpoint "/data-subscription/v1/plan?status=DRAFT"
    And I run get call api
    Then I see response code 200

  Scenario: Search by status SCHEDULED
    Given I have endpoint "/data-subscription/v1/plan?status=SCHEDULED"
    And I run get call api
    Then I see response code 200

  Scenario: Search by status DELETED
    Given I have endpoint "/data-subscription/v1/plan?status=DELETED"
    And I run get call api
    Then I see response code 200

  Scenario: Search by status EXPIRED
    Given I have endpoint "/data-subscription/v1/plan?status=EXPIRED"
    And I run get call api
    Then I see response code 200