@subscription_filter

  Business Need: Filter subscription
    Scenario: Search subscription by ID
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].id" as "subId"
      And I have endpoint "/data-subscription/v1/subscriptions?limit=10&search={SavedValue::subId}"
      And I run get call api
      Then I see response code 200
      Then I see property value "{SavedValue::subId}" is present in the response property "data.subscriptions[0].id"

    Scenario: Search subscription where status is ACTIVE
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&status=ACTIVE"
      And I run get call api
      Then I see response code 200
      Then I see property value "ACTIVE" is present in the response property "data.subscriptions[0].status"

    Scenario: Search subscription where status is INACTIVE
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&status=INACTIVE"
      And I run get call api
      Then I see response code 200
      Then I see property value "INACTIVE" is present in the response property "data.subscriptions[0].status"


    Scenario: Search subscription where status is FAILED
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&status=FAILED"
      And I run get call api
      Then I see response code 200
      Then I see property value "FAILED" is present in the response property "data.subscriptions[0].status"

    Scenario: Search subscription where status is ACTIVE INACTIVE FAILED
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&status=ACTIVE,INACTIVE,FAILED"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by product name
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&productName=test"
      And I run get call api
      Then I see response code 200
      Then I see property value "test" is present in the response property "data.subscriptions[0].item.title"