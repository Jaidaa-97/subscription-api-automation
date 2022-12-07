@subscription_v2 @v2 @Discontinue_item_Test
Business Need: Discontinue item

  @discontinue_item @after_regression_
  Scenario: All subscription should get inactive if the sku/item is discontinued
    Given I have created discontinue sku
    When I have saved property "productSku" as "productSku"
    When I have saved property "itemId.toString()" as "itemId"
    When I have saved post 15minutes datetime property as "dateTime"
    Given I have pricing endpoint "/api-price/price/bulk-insert"
    And I have following request payload :
    """
    [
      {
      "priceListId": 100000,
      "itemId": {SavedValue::itemId},
      "itemSku": "{SavedValue::productSku}",
        "offers": [
          {
            "kind": 12,
            "channel": 12,
            "startDate": "{SavedValue::dateTime}",
            "endDate": "2028-01-11T02:59:51.459Z",
            "price": {
              "base": 80,
              "sale": 70,
              "cost": 60,
              "currency": "USD"
            },
            "additionalAttributes": [
            {}
            ]
          }
        ]
      }
    ]
    """
    When I run pricing post call
    Then I see response code 200
    And I wait for 10 sec
    #create offer
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
      {
          "validity":{
            "startDate":"{SavedValue::dateTime}",
            "endDate":"2028-01-11T02:59:51.459Z",
            "applyOnOrders":[
               2,
               3,
               10
            ]
         },
         "message":"terms and conditions of the offer",
         "discount":{
            "percentage":1

         },
         "skus":[
            "{SavedValue::productSku}"
         ],
         "categories":[
            "product category 1",
            "product category 2",
            "product category 3"
         ],
         "frequency": {
        "frequency": 5,
        "frequencyType": "Daily"
         },
          "itemQuantity": 2,
              "channel": "POS",
          "customerSegment":[
            "employee",
            "designer"
         ]
      }
    """
    And I run post call
    Then I see response code 200
#    When I have saved property "data.offerCode" as "offerCode"
##    Given I have created 1 bulk subscription
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#          {
#            "channel": "POS",
#            "customer": {
#                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
#                "locale": "en_US",
#                "email": "custom{RandomNumber::4}@gmail.com",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee", "designer"]
#            },
#            "items": [
#                {
#                    "sku":"{SavedValue::productSku}",
#                    "quantity": 2,
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offer": {
#                        "id": "{SavedValue::offerCode}"
#                    }
#                }
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST"
#                },
#                "phone": {
#                    "number": "01113370957",
#                    "kind": "mobile"
#                },
#                "city": "BOSTON MA",
#                "state": "MA",
#                "postalCode": "2127",
#                "country": "US"
#            },
#            "billTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST"
#                },
#                "phone": {
#                    "number": "012323370957",
#                    "kind": "mobile"
#                },
#                "city": "BOSTON MA",
#                "state": "MA",
#                "postalCode": "2127",
#                "country": "US"
#            },
#            "paymentDetails": {
#                "paymentIdentifier": {
#                    "cardIdentifier": "1234",
#                    "expiryDate": "04/24"
#                }
#            }
#        }
#      """
#    When I run post call
#    And I wait for 30 sec
#    Then I see response code 200
#    When I discontinued item "{SavedValue::productSku}"
#    Then I see response code 200
#    When I get all the subscription of an item "{SavedValue::productSku}"
#    Then I see response code 200
#    And I see all the subscription of discontinued item gets deactivated

  @cancel_order_discontinued_item @after_regression_
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
    When I discontinued item "---data:-:env_sku2---"
    Then I see response code 200
    And I wait for 10 sec
    When I get the order by id "{SavedValue::orderId}"
    Then I see response code 200
    And I see property value "CANCELED" is present in the response property "data.order.status"

  @remove_item_discontinued_item @regression_
  Scenario: Discontinued line item should be removed from the order if order has more than 1 line items
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId"
    When I get the subscription by id "{SavedValue::subId}"
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
    And I wait for 10 sec
    When I get all the orders placed by customer "{SavedValue::customerId}"
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    # Add item in order
    When add item "---data:-:env_sku1---" in order "{SavedValue::orderId}"
    When I discontinued item "---data:-:env_sku2---"
    Then I see response code 200
    And I wait for 15 sec
    # get order by id
    When I get the order by id "{SavedValue::orderId}"
    Then I see response code 200
    And I wait for 15 sec
    And I do not see property value "CANCELED" is present in the response property "data.order.status"
    And I verify 1 records are present in the response against the property "data.order.lineItems"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.order.lineItems[0].item.sku"

  @error_no_sku_exist @regression_
  Scenario: Should not allow to discontinue item which is not even exist
    Given I have endpoint "/data-subscription/v1/subscriptions/discontinued-items"
    And I have following request payload :
      """
            {
          "sku": ["aqerutollcj"]
            }
      """
    When I run post call
    Then I see response code 404

