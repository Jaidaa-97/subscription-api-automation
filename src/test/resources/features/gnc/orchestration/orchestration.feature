@subscription_v2 @orchestration
Business Need: Orchestration Response

  @Success_Scenario @regression_
  Scenario: Success Scenario
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
[
        {
            "order":{
            "code": "SUCCESS",
            "orderId": "{SavedValue::orderId}"
            }
        }


]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "SUCCESS" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUCCESS" is present in the response property "data.order.status"

  @Success_Scenario_Without_Trigger_Order @regression_
  Scenario: Success Scenario without Trigger Order
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
[
        {
            "order":{
            "code": "SUCCESS",
            "orderId": "{SavedValue::orderId}"
            }
        }


]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "SUCCESS" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUCCESS" is present in the response property "data.order.status"

  @Invalid_Code @regression_
  Scenario: Enter Invalid code
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":72221,
            "errorMsg":"Customer Not found"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "Invalid errorCode or errorMsg" is present in the response property "data[0].status"
#    Then I see property value "Cannot destructure property 'status' of '(intermediate value)' as it is null." is present in the response property "data[0].error"

  @Invalid_message @regression_
  Scenario: Enter Invalid message
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"sdfsdffsdfdf"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "Invalid errorCode or errorMsg" is present in the response property "data[0].status"
#    Then I see property value "Cannot destructure property 'status' of '(intermediate value)' as it is null." is present in the response property "data[0].error"

  @Invalid_length_OrderId @regression_
  Scenario: Enter Invalid length OrderId
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "62a1cd15be4b3000333092ae27f",
            "errorCode":999,
            "errorMsg":"Customer Not found"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "Argument passed in must be a single String of 12 bytes or a string of 24 hex characters" is present in the response property "data[0].error"

  @Invalid_OrderId @regression_
  Scenario: Enter Invalid OrderId
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "62a1fd8a611218008929cacb",
            "errorCode":999,
            "errorMsg":"Customer Not found"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "NO Order Found" is present in the response property "data[0].error"
  @Failed_Scenario_without_trigger_order @regression_
  Scenario: failed without trigger order
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "NO Order Found" is present in the response property "data[0].error"


  @Customer_Not_found @regression_
  Scenario: Customer Not Found
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Customer Not found"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "FAILED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"


  @Agent_login_failed @regression_
  Scenario: Agent login failed
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    And I wait for 30 sec
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    And I wait for 30 sec
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    And I wait for 30 sec
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Aurus_payment_token_not_available @regression_
  Scenario: Aurus payment token not available
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Aurus payment token not available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Aurus payment token not available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Aurus payment token not available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Aurus payment token not available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Customer_wallet_has_no_saved_CC @regression_
  Scenario: Customer wallet has no saved CC
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer wallet has no saved CC"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer wallet has no saved CC"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer wallet has no saved CC"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer wallet has no saved CC"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    And I wait for 10 sec
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Customer_walle_does_not_have_default_card @regression_
  Scenario: Customer walle does not have default card
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer walle does not have default card"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer walle does not have default card"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer walle does not have default card"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":170,
            "errorMsg":"Customer walle does not have default card"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Could_not_build_cart_or_shipment_is_empty @regression_
  Scenario: Could not build cart or shipment is empty
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 20 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Could not build cart or shipment is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
   """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Could not build cart or shipment is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
   """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Could not build cart or shipment is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
   """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Could not build cart or shipment is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Coud_not_build_cart_due_to_invalid_billing_address @regression_
  Scenario: Coud not build cart due to invalid billing address
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":130,
            "errorMsg":"Coud not build cart due to invalid billing address"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":130,
            "errorMsg":"Coud not build cart due to invalid billing address"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":130,
            "errorMsg":"Coud not build cart due to invalid billing address"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :

    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":130,
            "errorMsg":"Coud not build cart due to invalid billing address"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Coud_not_build_cart @regression_
  Scenario: Coud not build cart
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Coud not build cart"
            }
        }
    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Coud not build cart"
            }
        }
    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Coud not build cart"
            }
        }
    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Coud not build cart"
            }
        }
    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Could_not_build_cart,_received_null_product_from_OG_POST @regression_
  Scenario: Could not build cart, received null product from OG POST
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 20 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Could not build cart, received null product from OG POST"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
       """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Could not build cart, received null product from OG POST"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Could not build cart, received null product from OG POST"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Could not build cart, received null product from OG POST"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Basket_is_empty @regression_
  Scenario: Basket is empty
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Basket is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
        """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Basket is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
   """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Basket is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Basket is empty"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Gift_certificate_is_the_only_payment_method_available @regression_
  Scenario: Gift certificate is the only payment method available
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Gift certificate is the only payment method available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Gift certificate is the only payment method available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Gift certificate is the only payment method available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Gift certificate is the only payment method available"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Invalid_payment_amount_during_order_placement. @regression_
  Scenario: Invalid payment amount during order placement.
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Invalid payment amount during order placement."
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Invalid payment amount during order placement."
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Invalid payment amount during order placement."
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":110,
            "errorMsg":"Invalid payment amount during order placement."
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Payment_Auth_Failed @regression_
  Scenario: Payment Auth Failed
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment Auth Failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment Auth Failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment Auth Failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
      """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment Auth Failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Payment_processor_issue @regression_
  Scenario: Payment processor issue
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment processor issue"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment processor issue"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment processor issue"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
       """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment processor issue"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Payment_declined @regression_
  Scenario: Payment declined
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment declined"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment declined"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment declined"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":140,
            "errorMsg":"Payment declined"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Order_creation_failed @regression_
  Scenario: Order creation failed
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Order creation failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Order creation failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
      """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Order creation failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Order creation failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Order_placement_failed @regression_
  Scenario: Order placement failed
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":20,
            "errorMsg":"Order placement failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "FAILED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"

  @Generic_error @regression_
  Scenario: Generic error
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Generic error"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Generic error"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
     """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Generic error"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Generic error"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"

  @Out_of_stock @regression_
  Scenario: out of stock
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
      {
    "lineItems": [
        {
            "subscriptionId": "{SavedValue::subId}",
            "item": {
                "itemPrice": {
                    "price": 10,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10,
                    "currencyCode": "USD"
                },
                "sku":"---data:-:env_sku2---",
                "quantity": 2,
                "weight": 10
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10,
                "taxAmount": 1,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "1234567890",
                "storeAssociateId": "jitu",
                "trackingUrl": "http://google.com"
            }
        }
    ]
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.lineItems[1].lineItemId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":321,
            "errorMsg":"out of stuck",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"

    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":321,
            "errorMsg":"out of stuck",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"

    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":321,
            "errorMsg":"out of stuck",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"

  @Low_Inventory @regression_
  Scenario: Low Inventory
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
      {
    "lineItems": [
        {
            "subscriptionId": "{SavedValue::subId}",
            "item": {
                "itemPrice": {
                    "price": 10,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10,
                    "currencyCode": "USD"
                },
                "sku":"---data:-:env_sku2---",
                "quantity": 2,
                "weight": 10
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10,
                "taxAmount": 1,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "1234567890",
                "storeAssociateId": "jitu",
                "trackingUrl": "http://google.com"
            }
        }
    ]
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.lineItems[1].lineItemId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":123,
            "errorMsg":"Low Inventory",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"

    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":123,
            "errorMsg":"Low Inventory",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"

    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
            "orderId": "{SavedValue::orderId}",
            "errorCode":123,
            "errorMsg":"Low Inventory",
            "lineItemIds": [1]
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"

