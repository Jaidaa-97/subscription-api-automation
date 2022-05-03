Business Need: Update subscriptions details, Update customer billing and shipping
  address

  @SUB-813
  Scenario: Customer wants to update shipping address across all the subscriptions
    Given Customer has multiple subscriptions and orders in future
    Given I have endpoint "/customers/:id/subscriptions"
    And I have following request payload :
    """
    {
    "shippingTo": {
        "name": {
            "firstName": "Jitendra",
            "middleName": "D",
            "lastName": "Pisal"
        },
        "streetAddress": {
            "street1": "NS road",
            "street2": "koregaon park"
        },
        "phone": {
            "number": "+91 3333709512"
        },
        "city": "PUNE",
        "state": "MH",
        "zipCode": 411001,
        "country": "IN"
    }
}
    """
    When I run patch call
    Then I see that the all the subscription/order shipping address has updated.
    Then Shipping for all future orders for the respective customer should also get updated


  @SUB-813
  Scenario: Customer wants to update billing address across all the subscriptions
    Given Customer has multiple subscriptions and orders in future
    Given I have endpoint "/customers/:id/subscriptions"
    And I have following request payload :
    """
    {
    "billingTo": {
        "name": {
            "firstName": "Jitendra",
            "middleName": "D",
            "lastName": "Pisal"
        },
        "streetAddress": {
            "street1": "NS road",
            "street2": "koregaon park"
        },
        "phone": {
            "number": "+91 3333709512",
            "kind": "mobile"
        },
        "city": "PUNE",
        "state": "MH",
        "zipCode": 411001,
        "country": "IN"
    }
}
    """
    When I run patch call
    Then I see that the all the subscription billing address has updated.
    And Billing for all future orders for the respective customer should also get updated


  @SUB-752
  Scenario: Update shipping address of single subscription
    Given I have endpoint "subscriptions/:id"
    And I have following request payload :
      """
      "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "Doe",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": "10 Downing Street"
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "zipCode": 2127,
        "country": "US"
    }
      """
    When I run patch call
    Then I see response code 200
    Then I see that the shipping address gets updated for that subscription and its upcoming orders.


  @SUB-752
  Scenario: Update billing address of single subscription
    Given I have endpoint "subscriptions/:id"
    And I have following request payload :
      """
      "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "Doe",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": "10 Downing Street"
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "zipCode": 2127,
        "country": "US"
    }
      """
    When I run patch call
    Then I see response code 200
    Then I see that the shipping address gets updated for that subscription and its upcoming orders.

  @SUB-752
  Scenario:As a GNC customer I wants to update payment details of subscription
    Given I have endpoint "/subscriptions/:id"
    And I have following request payload :
      """
      "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
      """
    When I run patch call
    Then customer has successfully updated payment details for a subscription and also all the upcoming orders of the subscription should be charged with newly added payment


  @SUB-752
  Scenario: As a GNC customer I want to update the item quantity in the subscription
    Given I have endpoint "/subscriptions/:id"
    And I have following request payload :
        """
        {
            "item" {
              "quantity":10
            }
        }
        """
    When I run patch call
    Then I see response code 200
    And I see that the customer has successfully update the product quantity for the subscription.


  @SUB-820
  Scenario: As a GNC customer, I want to inactive the currently active subscription.
    Given Customer has subscribed to a subscription
    And I have endpoint "/v1/subscription"
    And I have following request payload :
          """
            {
              "status":"INACTIVE"
            }
          """
    When I run put call
    Then I see response code 200
    And I see that the subscription gets inactive and all the future orders gets cancelled.


  @SUB-757
  Scenario: As a GNC customer, I want to activate the currently inactive subscription.
    Given Customer has inactive subscription
    And I have endpoint "/v1/subscription"
    And I have following request payload :
          """
            {
              "status":"ACTIVE"
            }
          """
    When I run put call
    Then I see response code 200
    And I see that the subscription gets ACTIVE and orders gets created.


  @SUB-764 @WaitingForContract
  Scenario: When a customer has 2 or more recurring orders scheduled to generate within 7 days of each other, the orders should be consolidated into 1 order for shipping.
    Given Customer has created 2 or more recurring orders scheduled to generate within 7 days of each other
    And I have end point
    When I run get call api
    Then I should see single order is created for the orders which are placed/or about ship within 7 days of each other.


  @SUB-765
  Scenario: Add item to an order for one time upsell
  As a merchant, I shall enable my customers to add a one-time only/recurring product to their next order.
    Given I have endpoint "/orders/:id/add-items"
    And I have following request payload :
        """
           {
              "lineItems": [
                  {
                      "item": {
                          "id": 1000000006,                               // optional for GNC
                          "sku": "1000000006",
                          "quantity": 1,
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
                      "shipping": {                                      // optional
                          "shipmentCarrier": "USPS",
                          "shipmentMethod": "Ground",
                          "shipmentInstructions": "",
                          "taxCode": "SHP020000",
                          "shippingAmount": 10.00,
                          "taxAmount": 1.00,
                          "currencyCode": "USD"
                      },
                      "offer": {
                          "id": 10000022333,
                          "source": "PDP"                              // possible values: PDP, CART
                      },
                      "customAttributes": {                            // optional
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
    And I see following response :
    """
          {
                "responseStatus": "OK",
                "message": "Request processed successfully.",
                "data": {
                    "order": {
                        "id": "60cb0959dc645c0008eb9c1a",
                        "status": "Active",
                        "cancellationReason": "",
                        "orderTriggeredDate": "",
                        "paymentStatus": "",
                        "orderPaymentDate": "",
                        "scheduledDate": "2026-07-22T00:00:00.199Z",
                        "shipTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "Doe",
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": "10 Downing Street"
                            },
                            "phone": {
                                "number": "+92 3333709523",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "zipCode": 2127,
                            "country": "US"
                        },
                        "billTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "Doe",
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": "10 Downing Street"
                            },
                            "phone": {
                                "number": "+92 3333709523",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "zipCode": 2127,
                            "country": "US"
                        },
                        "paymentDetails": {
                            "paymentIdentifier": {
                                "cardIdentifier": "1234",
                                "expiryDate": "04/24"
                            },
                            "paymentMethod": "visa",         // optional
                            "paymentKind": "CARD_PAYPAL"     // optional
                        },
                        "lineItems": [
                            {
                                "lineItemId": 1,
                                "channel": "WEBSITE",
                                "subscription": {                    // if not returned then this lineItem is one time upsell.
                                  "id": "60cb0959dc645c0008eb9c1a",
                                  "plan": {
                                    "frequency": 2,
                                    "frequencyType": "Weekly"
                                   }
                                },
                                "item": {
                                    "id": 1000000006,
                                    "sku": "1000000006",
                                    "quantity": 1,
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
                                "shipping": {                      // optional
                                    "shipmentCarrier": "USPS",
                                    "shipmentMethod": "Ground",
                                    "shipmentInstructions": null,
                                    "taxCode": "SHP020000",
                                    "shippingAmount": 10.00,
                                    "taxAmount": 1.00,
                                    "currencyCode": "USD"
                                },
                                "offer": {
                                    "id": 10000022333,
                                    "source": "PDP"
                                },
                                "customAttributes": {
                                    "storeId": "60cb07fc20387b000821c5c3",
                                    "associateId": 1,
                                    "trackingUrl": "609436d21baded0008945b05"
                                }
                            }
                        ]
                    }
                }
          }
    """
    And when we get the orders by customer id
    Then I should see the order contains this one time upsell item.


  @SUB-765
  Scenario: Add multiple line item to an order for one time upsell
  As a merchant, I shall enable my customers to add a one-time only/recurring product to their next order.
    Given I have endpoint "/orders/:id/add-items"
    And I have added multiple line items
    Then I see that the multiple line items has been added in the order.


  @SUB-765
  Scenario: Verify partial response if customer has added an item in the existing order which already a part of an order
  As a merchant, I shall enable my customers to add a one-time only/recurring product to their next order.
    Given I have endpoint "/orders/:id/add-items"
    And I have added the lineItem1 which is not part of the order
    And I have added another lineItem2 which is already a part of an order.
    Then I customer should see the partial response as follows :
    """
    {
    "responseStatus": "PARTIAL_SUCCESS",
    "message": "Request processed successfully",
    "data": {
        errors: [
          {
            "item": {
              "id": 1000000033,
              "sku": "vitaminB12"
            },
           "errorCode": "ITEM_NOT_FOUND",
           "errorMessage": ""                     // Respective error message
          }
        ],
        "order": {
            "id": "60cb0959dc645c0008eb9c1a",
            "status": "Active",
            "cancellationReason": "",
            "orderTriggeredDate": "",
            "paymentStatus": "",
            "orderPaymentDate": "",
            "scheduledDate": "2026-07-22T00:00:00.199Z",
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "Doe",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": "10 Downing Street"
                },
                "phone": {
                    "number": "+92 3333709523",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "zipCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "Doe",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": "10 Downing Street"
                },
                "phone": {
                    "number": "+92 3333709523",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "zipCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",         // optional
                "paymentKind": "CARD_PAYPAL"     // optional
            },
            "lineItems": [
                {
                    "lineItemId": 1,
                    "channel": "WEBSITE",
                    "subscription": {                    // if not returned then this lineItem is one time upsell.
                      "id": "60cb0959dc645c0008eb9c1a",
                      "plan": {
                        "frequency": 2,
                        "frequencyType": "Weekly"
                       }
                    },
                    "item": {
                        "id": 1000000006,
                        "sku": "1000000006",
                        "quantity": 1,
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
                    "shipping": {                      // optional
                        "shipmentCarrier": "USPS",
                        "shipmentMethod": "Ground",
                        "shipmentInstructions": null,
                        "taxCode": "SHP020000",
                        "shippingAmount": 10.00,
                        "taxAmount": 1.00,
                        "currencyCode": "USD"
                    },
                    "offer": {
                        "id": 10000022333,
                        "source": "PDP"
                    },
                    "customAttributes": {
                        "storeId": "60cb07fc20387b000821c5c3",
                        "associateId": 1,
                        "trackingUrl": "609436d21baded0008945b05"
                    }
                }
            ]
        }
    }
}
    """


  @SUB-765
  Scenario: Verify that the customer should not be able to add the items in lineItem as one time upsell which is out of stock
    Given I have endpoint "/orders/:id/add-items"
    When As a customer I added the product in the lineItem of an order which are not for sell or availavble or out of stock
    And Make sure that the error message should be valid. following is just an example
    Then I see the following error response :
      """
      {
                "responseStatus": "BAD_REQUEST",
                "message": "Request failed",
                "data": {
                  "errors": [
                    {
                      "item": {
                        "id": 1000000033,
                        "sku": "vitaminB12"
                       },
                       "errorCode": "ITEM_NOT_FOUND",
                       "errorMessage": ""                  // Respective error message
                    },
                    {
                      "item": {
                        "id": 1000000006,
                        "sku": "vitaminB22"
                      },
                      "errorCode": "ITEM_NOT_FOUND",
                      "errorMessage": "",                 // Respective error message
                    }
                  ]
                }
            }
      """

  @SUB-768
  Scenario: Customer wants to skip an order
    Given Customer has created an order
    And Customer wants to skip the upcoming order
    When Customer skip the immediate upcoming order
    Then the Order should get skipped
    And The status of the order should be SKIPPED


  @SUB-768
  Scenario: Customer wants to change the delivery date of an Order
    Given Customer has created an order
    And Customer wants to change the delivery date of an order
    When Customer changes the delivery date
    Then Order next delivery date gates changed along with the subsequent orders

  @SUB-769
  Scenario: Update quantities in next order
    Given Customer has created an order
    And Customer wants to update the number of quantities of a product
    When Customer update the quantity
    Then the quantity in next order gets updated.

  @SUB-769
  Scenario: Update billing details of next order
    Given Customer has updated the billing details of an order
    Then the next order billing details gets updated


  @SUB-769
  Scenario: Update shipping details of next order
    Given Customer wants to ship the next order to different shipping address
    When Customer has updated the shipping details of an order
    Then the next order shipping details gets updated
