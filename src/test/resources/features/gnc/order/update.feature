@v2
Business Need: Update order

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
                "postalCode": 411006,
                "country": "IN"
            },
            "billTo": {
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
                "city": "Pune",
                "state": "MH",
                "postalCode": 411006,
                "country": "IN"
            }
        }
    """
    When I run patch call
    Then I see response code 200

  @update_order_quantity
  Scenario: Update order quantity
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "motasem"
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::motasem}/orders"
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
                            "itemPrice": {
                                "price": 13400.00,
                                "currencyCode": "USD"
                            },
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
