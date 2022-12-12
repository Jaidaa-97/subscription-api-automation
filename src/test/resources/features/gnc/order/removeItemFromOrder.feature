@v2 @remove_item_from_order
Business Need: Remove item from order

@remove-upsell_item @regression_
Scenario: remove upsell Item
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
                    "sku": "---data:-:env_sku1---",
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
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/remove-items"
    And I have following request payload :
    """
    {
    "lineItemIds": [1]
    }
    """
    When I run post call
    Then I see response code 200

@remove_subscription_item
Scenario: remove subscription item
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
                    "sku": "PROTEIN_1",
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
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/remove-items"
    And I have following request payload :
    """
        {
        "lineItemIds": [2]
        }
        """
    When I run post call
    Then I see response code 200

@remove_item_not_exist @regression_
Scenario: remove item not exist
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
                    "sku": "---data:-:env_sku1---",
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
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/remove-items"
    And I have following request payload :
    """
    {
    "lineItemIds": [8]
    }
    """
    When I run post call
    Then I see response code 400
    Then I see property value "Invalid line item id" is contains in the response property "message.errorMessage"






