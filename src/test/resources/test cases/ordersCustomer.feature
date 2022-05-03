Business Need:
"""
  A subscription gets converted into order before it renews.
  The Order entity can comprise of one or more subscription products.
  As soon as a subscription get’s created its next order is created with a scheduled date representing when the subscription renews.
  An order should contain all items required to charge, create order in merchant OMS and ship the products.
  """

  @SUB-706
  Scenario: Get all the future orders for a customer
    Given Customer has created a multiple subscription
    When I call get all the subscription orders api
    Then I should see following response containing all the order details:
    """
            {
              "responseStatus": "OK",
              "message": "Request processed successfully",
              "data": {
                  "orders": [
                      {
                          "id": "60cb0959dc645c0008eb9c1a",
                          "status": "scheduled",
                          "cancellationReason": "",
                          "orderTriggeredDate": "",
                          "paymentStatus": "",             // optional : not applicable to GNC
                          "orderPaymentDate": "",          // optional : not applicable to GNC.
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
                              "paymentMethod": "visa",             // optional
                              "paymentKind": "CARD_PAYPAL"         // optional
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
                                  "shipping": {                        // optional: Not applicable to GNC
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
                  ]
              }
            }
    """

  @SUB-706
  Scenario: Get orders for customer which is not present
    Given Customer is not present
    When I call get all the subscription orders api
    Then I should see following response :
      """
            {
              "responseStatus": "NOT_FOUND",
              "message": "Customer not found",
            }
      """

  @SUB-706
  Scenario: Verify that all the orders in response should contains latest lowest 7 days price
    Given I have created subscription for item 1234 having item price as $100
    When I have lower the price of the item 1234 as $90(Either from PIM - Dont know yet need to confirm with saurabh)
    When I call get all the subscription orders api
    Then I should see orders contains the latest lowest 7 days price


     # Get Order collection by id
  @SUB-707
  Scenario: Get the order by its id
    Given I have endpoint "getOrder/id"
    When I call this api
    Then I should see following response :
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
                    "paymentStatus": "",                      // optional
                    "orderPaymentDate": "",                   // optional
                    "scheduledDate": "2026-07-22T00:00:00.199Z",
                    "totalAmount": 270.00,
                    "currencyCode": "USD",
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