@v2 @add_item_to_order
Business Need: Add Item To Order

  @add_item_to_order_as_upsell
  Scenario: add item as upsell to order
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
    {
    "lineItems": [
        {

            "item": {
                "sku": "MOT44",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }
    """
    When I run post call
    Then I see response code 200



  @add_item_to_order_as_subscription
  Scenario: add item to order as subscription
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
    {
    "lineItems": [
        {
           "subscriptionId": "{SavedValue::subId}",
           "item": {
                "sku": "MOT44",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }

    """
    When I run post call
    Then I see response code 200
    And validate schema "/gnc/addItemAsSubscription.json"


  @add_item_to_order_not_exist
    Scenario: add item to order not exist
    Given I have endpoint "/data-subscription/v1/orders/625wer236998170009601d85/add-items"
    And I have following request payload :
    """
    {
    "lineItems": [
        {

            "item": {
                "sku": "MOT44",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }
    """
    When I run post call
    Then I see response code 400


  @add_item_to_order_as_subscription_not_found
  Scenario: add item to order as subscription not found
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
    {
    "lineItems": [
        {
           "subscriptionId": "62c2b2d63fcd82000965467c",
           "item": {
                "sku": "MOT44",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }

    """
    When I run post call
    Then I see response code 400




