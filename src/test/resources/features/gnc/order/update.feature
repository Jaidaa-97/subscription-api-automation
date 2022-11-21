@v2 @update_order
Business Need: Update order
  @Update_Shipping_and_Billing_address @regression_
  Scenario: Update Shipping and Billing address
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 15 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I have following request payload :
    """
        {
            "shipTo": {
                "name": {
                    "firstName": "Nirali",
                    "middleName": "L",
                    "lastName": "Shirsekar"
                },
                "streetAddress": {
                    "street1": "hello word",
                    "street2": "Fnag road"
                },
                "phone": {
                    "number": "5375584493",
                    "kind": "phone"
                },
                "city": "Mumbai",
                "state": "MH",
                "postalCode": "411006",
                "country": "IN"
            },
            "billTo": {
                "name": {
                    "firstName": "Cust",
                    "middleName": "L",
                    "lastName": "Cust"
                },
                "streetAddress": {
                    "street1": "hello word",
                    "street2": "Fnag road"
                },
                "phone": {
                    "number": "5375584493",
                    "kind": "phone"
                },
                "city": "Pune",
                "state": "MH",
                "postalCode": "411006",
                "country": "IN"
            }
        }
    """
    When I run patch call
    Then I see response code 200
    Then I see property value "Nirali" is present in the response property "data.order.shipTo.name.firstName"
    Then I see property value "Cust" is present in the response property "data.order.billTo.name.firstName"

  @update_order_quantity @regression_
  Scenario: Update order quantity
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "customerID"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerID}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I have following request payload :
      """
            {
                "lineItems": [
                    {
                        "lineItemId": 1,
                        "item": {
                            "quantity": 100,
                            "weight": 100,
                            "weightUnit": "l1b",
                            "tax": {
                                "taxCode": "FR020000",
                                "taxAmount": 4566.00,
                                "currencyCode": "USD"
                            }
                        }
                    }
                ]
             }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 100 is present in the response property "data.order.lineItems[0].item.quantity"

  @Update_payment_details @regression_
  Scenario:Update payment details
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "customerID"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerID}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I have following request payload :
    """
    {
      "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        }
      }
    }
    """
    When I run patch call
    Then I see response code 200
    Then I see property value "1234" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"

  @Update_customer_attribute @regression_
  Scenario: Update customer attribute
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "customerID"
    And I wait for 15 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerID}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I have following request payload :
    """
    {
    "lineItems": [
        {
            "lineItemId": 1,
            "customAttributes": {
                "storeId": "60cb07fdc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "http://google.com"
            }
        }
    ]
    }
    """

    When I run patch call
    Then I see response code 200
    Then I see property value "60cb07fdc20387b000821c5c3" is present in the response property "data.order.lineItems[0].customAttributes.storeId"

  @update_scheduledDate @regression_
  Scenario: update scheduledDate
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "customerID"
    And I wait for 15 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerID}/orders"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    And I have following request payload :
    """
    {
      "scheduledDate": "{Date::uuu-MM-dd:::d=5}T13:40:01.199Z"
    }
    """
    When I run patch call
    Then I see response code 200
    Then I see property value "{Date::uuu-MM-dd:::d=5}T13:40:01.199Z" is present in the response property "data.order.scheduledDate"
