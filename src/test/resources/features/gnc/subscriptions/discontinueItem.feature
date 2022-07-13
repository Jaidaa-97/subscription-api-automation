@subscription_v2 @v2
Business Need: Discontinue item
  @v2_discontinue_item
  @discontinue_item @subscriptions_success
  Scenario: All subscription should get inactive if the sku/item is discontinued
    Given I have created 1 bulk subscription
    When I discontinued item "---data:-:env_sku1---"
    Then I see response code 200
    When I get all the subscription of an item "---data:-:env_sku1---"
    Then I see response code 200
    And I see all the subscription of discontinued item gets deactivated

  @cancel_order_discontinued_item @subscriptions_success
  Scenario: All future Order should get cancel for order having only 1 lineItem if the sku/item is discontinued
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId"
    When I get the subscription by id "{SavedValue::subId}"
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
    And I wait for 10 sec
    When I get all the orders placed by customer "{SavedValue::customerId}"
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    When I discontinued item "---data:-:env_sku1---"
    Then I see response code 200
    And I wait for 10 sec
    When I get the order by id "{SavedValue::orderId}"
    Then I see response code 200
    And I see property value "CANCELED" is present in the response property "data.order.status"

  @remove_item_discontinued_item
  Scenario: Discontinued line item should be removed from the order if order has more than 1 line items
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId"
    When I get the subscription by id "{SavedValue::subId}"
    Then I see response code 200
#    And I have saved property "data.subscription.customer.id" as "customerId"
#    And I wait for 10 sec
#    When I get all the orders placed by customer "{SavedValue::customerId}"
#    Then I see response code 200
#    And I have saved property "data.orders[0].id" as "orderId"
#    # Add item in order
#    When add item "---data:-:env_sku2---" in order "{SavedValue::orderId}"
#    When I discontinued item "---data:-:env_sku1---"
#    Then I see response code 200
#    And I wait for 10 sec
    # get order by id
#    When I get the order by id "{SavedValue::orderId}"
#    Then I see response code 200
#    And I do not see property value "CANCELED" is present in the response property "data.order.status"
#    And I verify 1 records are present in the response against the property "data.order.lineItems"
#    And I see property value "---data:-:env_sku2---" is present in the response property "data.order.lineItems[0].item.sku"

  @error_no_sku_exist
  Scenario: Should allow to discontinue item which is not even exist
    Given I have endpoint "/data-subscription/v1/subscriptions/discontinued-items"
    And I have following request payload :
      """
            {
          "sku": ["aqerutollcj"]
            }
      """
    When I run post call
    Then I see response code 404

