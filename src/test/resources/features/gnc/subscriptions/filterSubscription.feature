@subscription_filter

  Business Need: Filter subscription
    Scenario: Search subscription by ID
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].id" as "subId"
      And I have endpoint "/data-subscription/v1/subscriptions?limit=10&search={SavedValue::subId}"
      And I run get call api
      Then I see response code 200
      Then I see property value "{SavedValue::subId}" is present in the response property "data.subscriptions[0].id"

    Scenario: Search subscription by passing partial value from the beginning
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].id" as "subId"
      And search subscription by "first" 3 letters and I have "{SavedValue::subId}"
      And I wait for 10 sec
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

    Scenario: Search subscription by customer name
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&customerName=customerFirstName"
      And I run get call api
      Then I see response code 200
      Then I see property value "customerFirstName" is present in the response property "data.subscriptions[0].customer.firstName"

    Scenario: Search subscription by customer ID
      Given I have endpoint "/data-subscription/v1/subscriptions?search=639b3396b5c86a0008e2927a"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by planid
      Given I have endpoint "/data-subscription/v1/subscriptions?limit=10&search=639194ae04dd2900082e7d14"
      And I run get call api
      Then I see response code 200
      Then I see property value "639194ae04dd2900082e7d14" is present in the response property "data.subscriptions[0].plan.id"

    Scenario: Search subscription by passing partial value from the beginning
      Given I have endpoint "/data-subscription/v1/subscriptions?search=63a1"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by passing partial value from the middle
      Given I have endpoint "/data-subscription/v1/subscriptions?search=47976000"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by passing partial value from the middle
      Given I have endpoint "/data-subscription/v1/subscriptions?search=47976000"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by passing partial value from the end
      Given I have endpoint "/data-subscription/v1/subscriptions?search=1bc5e3"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by passing invalid partial value
      Given I have endpoint "/data-subscription/v1/subscriptions?search=1bc45455e3"
      And I run get call api
      Then I see response code 200

    Scenario: Search subscription by passing partial value with another filter
      Given I have endpoint "/data-subscription/v1/subscriptions?search=1bc&customerName=shubham Pisal"
      And I run get call api
      Then I see response code 200