@subscription_v2 @v2 @ReactiveSubscription_Test
Business Need: Reactive Subscription
  @v2_reactivate_subscription
  @reactivate_subscription @subscriptions_success @regression_ @non_enterprise
  Scenario: Reactivate the subscription again and verify that new order gets created
    Given I have created bulk subscription
    And I wait for 10 sec
    And I have saved property "data.subscriptions[0].id" as "subId"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}/inactive"
    And I have following request payload :
    """
             {
             "cancelationReason": {
                 "reason": "reason 12",
                 "code": 10
             }
         }
    """
    When I run put call
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.status"
      # Get customer id
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
      # Get order id from get orders by customer id api
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I get the index of order for subscription "{SavedValue::subId}" as "index1"
    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
     # Reactivate the subscription again
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}/reactivate"
    When I run put call
    Then I see response code 200
    And I see property value "ACTIVE" is present in the response property "data.status"
    # verify if new order gets created
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    Then I verify 2 records are present in the response against the property "data.orders"
