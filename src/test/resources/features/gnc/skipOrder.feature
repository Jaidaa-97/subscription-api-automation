@v2 @skipOrder
Business Need: Skip Order
  
  @skipOrder @delivery_date
  Scenario: Skip the order/Validate change of delivery date
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 15 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/skip"
    When I run put call
    Then I see response code 200
    Then I see property value "SKIPPED" is present in the response property "data.Order.status"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "{Date::uuu-MM-dd:::M=1}" is contains in the response property "data.order.scheduledDate"

    @invalid_order_id
    Scenario: Invalid order id
      Given I have endpoint "/data-subscription/v1/orders/asdasdasd/skip"
      And I have following request payload :
      """

      """
      When I run put call
      Then I see response code 400
      Then I see property value "Invalid order id" is present in the response property "message"

