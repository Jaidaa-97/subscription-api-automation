Business Need: As a merchant, I should be able to create multiple subscription at the
  same time

  @CreateBulkSubscriptionWithoutPlan @SUB-700
  Scenario: Create a bulk subscription without plan
    Given I have endpoint "/bulkSubscription"
    And I have following request payload :
    """
     [
           {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 1000000006, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            },
          {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 1000000006, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            }
     ]
    """
    When I run post call
    Then I see response code 200
    And Multiple subscriptions gets created without passing plan.
    And I see following response :
    """
            {
            "responseStatus": "OK",
            "message": "Request processed successfully.",
            "data": {
                "subscriptions": [
                    {
                        "id": "44299603833e720011776221",
                        "item": {
                            "id": 1000000006,
                            "sku": "vitaminB7"
                        }
                    },
                    {
                        "id": "61499603833e720011776c93",
                        "item": {
                            "id": 1000000006,
                            "sku": "vitaminB13"
                        }
                    }
                ]
            }
        }

    """

  @CreatePartialSubscription
  Scenario: Partial subscription should be created if one of the subscription is already created
    Given I have already created a subscription for particular item id
    And I have endpoint "/bulk"
    And I have following request payload :
      """
      [
           {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 1000000006, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            },
          {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 1000000006, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            }
     ]
      """
    When I run post call
    Then I see response code 200
    And I should see partial response as follows :
      """
                {
              "responseStatus": "PARTIAL_SUCCESS",
              "message": "Request processed with partial success",
              "data": {
                  "subscriptions": [
                      {
                          "id": "44299603833e720011776221",
                          "item": {
                              "id": 1000000006,
                              "sku": "vitaminB7"
                          }
                      },
                      {
                          "id": "61499603833e720011776c93",
                          "item": {
                              "id": 1000000006,
                              "sku": "vitaminB13"
                          }
                      }
                  ],
                  "errors": [
                      {
                          "item": {
                              "id": 1000000033,
                              "sku": "vitaminB12"
                          },
                          "errorCode": "INVALID_INPUT",
                          "errorMessage": ""
                      },
                      {
                          "item": {
                              "id": 1000000006,
                              "sku": "vitaminB22"
                          },
                          "errorCode": "MISSING_FIELD",
                          "errorMessage": ""
                      }
                  ]
              }
          }
      """

  @PartialResponseIfCustomerDetailsMissing
  Scenario: Verify partial response if we did not pass the customer details in one of the
  subscription details in the payload and we should get valid error message for missing field customer
    Given I have endpoint "/bulk"
    And I have following request payload :
        """
                    [
                       {
                        "status": "ACTIVE",
                        "channel": "WEBSITE",                        // possible values: POS, WEBSITE
                        "originOrderId": "6803-5058-41270",          // optional
                        "items": [
                            {
                                "id": 1000000006, // either id or sku is required.
                                "sku": "vitamin123", // either id or sku is required.
                                "quantity": 1,
                                "weight": 10,        // optional
                                "weightUnit": "lb",  // optional
                                "itemPrice": {
                                    "price": 100.00,
                                    "currencyCode": "USD"
                                },
                                "tax": {                   // optional
                                    "taxCode": "FR020000",
                                    "taxAmount": 10.00,
                                    "currencyCode": "USD"
                                },
                                "offsetDays": 10,         // optional
                                "offer": {
                                    "id": 10000022333,
                                    "source": ""          // optional // possible values: PDP, CART
                                },
                                "shipping": {             // optional
                                  "shipmentCarrier": "USPS",
                                  "shipmentMethod": "Ground",
                                  "shipmentInstructions": "",
                                  "taxCode": "SHP020000",
                                  "shippingAmount": 10.00,
                                  "taxAmount": 1.00,
                                  "currencyCode": "USD"
                                },
                                "expiry": {               // optional field
                                    "expiryDate": "2026-07-22T00:00:00.199Z",
                                    "billingCycles": 10
                                }
                            }
                        ],
                        "shipTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "",         // optional
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": ""             // optional
                            },
                            "phone": {
                                "number": "03323370957",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "postalCode": 2127,
                            "country": "US"
                        },
                        "billTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "",         // optional
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": ""             // optional
                            },
                            "phone": {
                                "number": "012323370957",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "postalCode": 2127,
                            "country": "US"
                        },
                        "paymentDetails": {
                            "paymentIdentifier": {
                                "cardIdentifier": "1234",                   // last 4 digits
                                "expiryDate": "04/24"
                            },
                            "paymentMethod": "visa",                        // optional
                            "paymentKind": "CARD_PAYPAL"                    // optional
                        },
                        "customAttributes": {                               // optional
                            "storeId": "60cb07fc20387b000821c5c3",
                            "storeAssociateId": "",
                            "trackingUrl": "609436d21baded0008945b05"
                            }
                        },
                      {
                        "status": "ACTIVE",
                        "channel": "WEBSITE",                        // possible values: POS, WEBSITE
                        "originOrderId": "6803-5058-41270",          // optional
                        "customer": {
                            "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                            "locale": "en_US",                      // possible values: fr_ca, en_US
                            "email": "customer@mail.com",
                            "contactNumber": "+92 3333709568"       // optional
                            "firstName": "John",
                            "middleName": "",                       // optional
                            "lastName": "Doe",
                            "segment": "employee",   // optional // possible values: proUser, regularUser
                            "employeeId": 1          // optional
                        },
                        "items": [
                            {
                                "id": 1000000006, // either id or sku is required.
                                "sku": "vitamin123", // either id or sku is required.
                                "quantity": 1,
                                "weight": 10,        // optional
                                "weightUnit": "lb",  // optional
                                "itemPrice": {
                                    "price": 100.00,
                                    "currencyCode": "USD"
                                },
                                "tax": {                   // optional
                                    "taxCode": "FR020000",
                                    "taxAmount": 10.00,
                                    "currencyCode": "USD"
                                },
                                "offsetDays": 10,         // optional
                                "offer": {
                                    "id": 10000022333,
                                    "source": ""          // optional // possible values: PDP, CART
                                },
                                "shipping": {             // optional
                                  "shipmentCarrier": "USPS",
                                  "shipmentMethod": "Ground",
                                  "shipmentInstructions": "",
                                  "taxCode": "SHP020000",
                                  "shippingAmount": 10.00,
                                  "taxAmount": 1.00,
                                  "currencyCode": "USD"
                                },
                                "expiry": {               // optional field
                                    "expiryDate": "2026-07-22T00:00:00.199Z",
                                    "billingCycles": 10
                                }
                            }
                        ],
                        "shipTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "",         // optional
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": ""             // optional
                            },
                            "phone": {
                                "number": "03323370957",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "postalCode": 2127,
                            "country": "US"
                        },
                        "billTo": {
                            "name": {
                                "firstName": "Roger",
                                "middleName": "",         // optional
                                "lastName": "Fang"
                            },
                            "streetAddress": {
                                "street1": "27 O ST",
                                "street2": ""             // optional
                            },
                            "phone": {
                                "number": "012323370957",
                                "kind": "mobile"
                            },
                            "city": "BOSTON MA",
                            "state": "MA",
                            "postalCode": 2127,
                            "country": "US"
                        },
                        "paymentDetails": {
                            "paymentIdentifier": {
                                "cardIdentifier": "1234",                   // last 4 digits
                                "expiryDate": "04/24"
                            },
                            "paymentMethod": "visa",                        // optional
                            "paymentKind": "CARD_PAYPAL"                    // optional
                        },
                        "customAttributes": {                               // optional
                            "storeId": "60cb07fc20387b000821c5c3",
                            "storeAssociateId": "",
                            "trackingUrl": "609436d21baded0008945b05"
                            }
                        }
                    ]
        """
    Then I see response code 200
    And I see that the one subscription gets created and for other subscription valid error message is shown
    And I verify similarly for all the mandatory field if they are missing in request payload

  @NoBulkSubscriptionCreated
  Scenario: Validate that the bulk subscriptions should not be created if we are missing any mandatory field in the request
  payload for all the subscription object
    Given I have endpoint "/bulk"
          # I have removed the status field from the request payload below
          # Also verify for all the mandatory fields e.g channel, items.id, items.sku, item.quantity, items.itemPrice, items.offer,
          # shipTo,billTo, paymentDetails
    When I have following request payload :
          """
                    [
                     {
                      "channel": "WEBSITE",                        // possible values: POS, WEBSITE
                      "originOrderId": "6803-5058-41270",          // optional
                      "customer": {
                          "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                          "locale": "en_US",                      // possible values: fr_ca, en_US
                          "email": "customer@mail.com",
                          "contactNumber": "+92 3333709568",       // optional
                          "firstName": "John",
                          "middleName": "",                       // optional
                          "lastName": "Doe",
                          "segment": ["employee"],   // optional // possible values: proUser, regularUser
                          "employeeId": 1          // optional
                      },
                      "items": [
                          {
                              "id": 1000000006, // either id or sku is required.
                              "sku": "vitamin123", // either id or sku is required.
                              "quantity": 1,
                              "weight": 10,        // optional
                              "weightUnit": "lb",  // optional
                              "itemPrice": {
                                  "price": 100.00,
                                  "currencyCode": "USD"
                              },
                              "tax": {                   // optional
                                  "taxCode": "FR020000",
                                  "taxAmount": 10.00,
                                  "currencyCode": "USD"
                              },
                              "offsetDays": 10,         // optional
                              "offer": {
                                  "id": 10000022333,
                                  "source": ""          // optional // possible values: PDP, CART
                              },
                              "shipping": {             // optional
                                "shipmentCarrier": "USPS",
                                "shipmentMethod": "Ground",
                                "shipmentInstructions": "",
                                "taxCode": "SHP020000",
                                "shippingAmount": 10.00,
                                "taxAmount": 1.00,
                                "currencyCode": "USD"
                              },
                              "expiry": {               // optional field
                                  "expiryDate": "2026-07-22T00:00:00.199Z",
                                  "billingCycles": 10
                              }
                          }
                      ],
                      "shipTo": {
                          "name": {
                              "firstName": "Roger",
                              "middleName": "",         // optional
                              "lastName": "Fang"
                          },
                          "streetAddress": {
                              "street1": "27 O ST",
                              "street2": ""             // optional
                          },
                          "phone": {
                              "number": "03323370957",
                              "kind": "mobile"
                          },
                          "city": "BOSTON MA",
                          "state": "MA",
                          "postalCode": 2127,
                          "country": "US"
                      },
                      "billTo": {
                          "name": {
                              "firstName": "Roger",
                              "middleName": "",         // optional
                              "lastName": "Fang"
                          },
                          "streetAddress": {
                              "street1": "27 O ST",
                              "street2": ""             // optional
                          },
                          "phone": {
                              "number": "012323370957",
                              "kind": "mobile"
                          },
                          "city": "BOSTON MA",
                          "state": "MA",
                          "postalCode": 2127,
                          "country": "US"
                      },
                      "paymentDetails": {
                          "paymentIdentifier": {
                              "cardIdentifier": "1234",                   // last 4 digits
                              "expiryDate": "04/24"
                          },
                          "paymentMethod": "visa",                        // optional
                          "paymentKind": "CARD_PAYPAL"                    // optional
                      },
                      "customAttributes": {                               // optional
                          "storeId": "60cb07fc20387b000821c5c3",
                          "storeAssociateId": "",
                          "trackingUrl": "609436d21baded0008945b05"
                          }
                      },
                    {
                      "channel": "WEBSITE",                        // possible values: POS, WEBSITE
                      "originOrderId": "6803-5058-41270",          // optional
                      "customer": {
                          "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                          "locale": "en_US",                      // possible values: fr_ca, en_US
                          "email": "customer@mail.com",
                          "contactNumber": "+92 3333709568"       // optional
                          "firstName": "John",
                          "middleName": "",                       // optional
                          "lastName": "Doe",
                          "segment": "employee",   // optional // possible values: proUser, regularUser
                          "employeeId": 1          // optional
                      },
                      "items": [
                          {
                              "id": 1000000006, // either id or sku is required.
                              "sku": "vitamin123", // either id or sku is required.
                              "quantity": 1,
                              "weight": 10,        // optional
                              "weightUnit": "lb",  // optional
                              "itemPrice": {
                                  "price": 100.00,
                                  "currencyCode": "USD"
                              },
                              "tax": {                   // optional
                                  "taxCode": "FR020000",
                                  "taxAmount": 10.00,
                                  "currencyCode": "USD"
                              },
                              "offsetDays": 10,         // optional
                              "offer": {
                                  "id": 10000022333,
                                  "source": ""          // optional // possible values: PDP, CART
                              },
                              "shipping": {             // optional
                                "shipmentCarrier": "USPS",
                                "shipmentMethod": "Ground",
                                "shipmentInstructions": "",
                                "taxCode": "SHP020000",
                                "shippingAmount": 10.00,
                                "taxAmount": 1.00,
                                "currencyCode": "USD"
                              },
                              "expiry": {               // optional field
                                  "expiryDate": "2026-07-22T00:00:00.199Z",
                                  "billingCycles": 10
                              }
                          }
                      ],
                      "shipTo": {
                          "name": {
                              "firstName": "Roger",
                              "middleName": "",         // optional
                              "lastName": "Fang"
                          },
                          "streetAddress": {
                              "street1": "27 O ST",
                              "street2": ""             // optional
                          },
                          "phone": {
                              "number": "03323370957",
                              "kind": "mobile"
                          },
                          "city": "BOSTON MA",
                          "state": "MA",
                          "postalCode": 2127,
                          "country": "US"
                      },
                      "billTo": {
                          "name": {
                              "firstName": "Roger",
                              "middleName": "",         // optional
                              "lastName": "Fang"
                          },
                          "streetAddress": {
                              "street1": "27 O ST",
                              "street2": ""             // optional
                          },
                          "phone": {
                              "number": "012323370957",
                              "kind": "mobile"
                          },
                          "city": "BOSTON MA",
                          "state": "MA",
                          "postalCode": 2127,
                          "country": "US"
                      },
                      "paymentDetails": {
                          "paymentIdentifier": {
                              "cardIdentifier": "1234",                   // last 4 digits
                              "expiryDate": "04/24"
                          },
                          "paymentMethod": "visa",                        // optional
                          "paymentKind": "CARD_PAYPAL"                    // optional
                      },
                      "customAttributes": {                               // optional
                          "storeId": "60cb07fc20387b000821c5c3",
                          "storeAssociateId": "",
                          "trackingUrl": "609436d21baded0008945b05"
                          }
                      }
                  ]
          """
    When I run post call
    Then I see response code 400
    And I see that the bulk subscriptions are not created and I see error response for missing mandatory field in the request payload

  @CreateBulkSubscriptionWithoutPassingOptionalFields_tax
  Scenario: Create bulk subscription without passing tax field under items object in the request payload
    Given I have endpoint "/bulk"
    And I have not added following properties in the original request payload:
            """
            "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    }
            """
    When I run post call
    Then I see response code 200
    And I see that the bulk subscription is created

  @CreateBulkSubscriptionWithoutPassingOptionalFields_offsetDays
  Scenario: Create bulk subscription without passing offsetDays field under item object in the request payload
    Given I have endpoint "/bulk"
    And I have not added following properties in the original request payload:
            """
            "offsetDays": 10
            """
    When I run post call
    Then I see response code 200
    And I see that the bulk subscription is created

  @CreateBulkSubscriptionWithoutPassingOptionalFields_shipping
  Scenario: Create bulk subscription without passing shipping field under items object in the request payload
    Given I have endpoint "/bulk"
    And I have not added following properties in the original request payload:
            """
            "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    }
            """
    When I run post call
    Then I see response code 200
    And I see that the bulk subscription is created

  @CreateBulkSubscriptionWithoutPassingOptionalFields_expiry
  Scenario: Create bulk subscription without passing expiry field under items object in the request payload
    Given I have endpoint "/bulk"
    And I have not added following properties in the original request payload:
            """
            "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
            """
    When I run post call
    Then I see response code 200
    And I see that the bulk subscription is created

  @CreateBulkSubscriptionWithoutPassingOptionalFields_customAttributes
  Scenario: Create bulk subscription without passing customAttributes field in the request payload
    Given I have endpoint "/bulk"
    And I have not added following properties in the original request payload:
            """
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            """
    When I run post call
    Then I see response code 200
    And I see that the bulk subscription is created

  @NoDuplicateSubscriptionCreation
  Scenario: Duplicate subscription should not be created
    Given I have already created subscription for item id 123456 and 234567
    Given I have endpoint "/bulk"
    And I have following request payload :
      """
      [
           {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 234567, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            },
          {
            "status": "ACTIVE",
            "channel": "WEBSITE",                        // possible values: POS, WEBSITE
            "originOrderId": "6803-5058-41270",          // optional
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916", // GNC customerId
                "locale": "en_US",                      // possible values: fr_ca, en_US
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568"       // optional
                "firstName": "John",
                "middleName": "",                       // optional
                "lastName": "Doe",
                "segment": "employee",   // optional // possible values: proUser, regularUser
                "employeeId": 1          // optional
            },
            "items": [
                {
                    "id": 123456, // either id or sku is required.
                    "sku": "vitamin123", // either id or sku is required.
                    "quantity": 1,
                    "weight": 10,        // optional
                    "weightUnit": "lb",  // optional
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "tax": {                   // optional
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 10,         // optional
                    "offer": {
                        "id": 10000022333,
                        "source": ""          // optional // possible values: PDP, CART
                    },
                    "shipping": {             // optional
                      "shipmentCarrier": "USPS",
                      "shipmentMethod": "Ground",
                      "shipmentInstructions": "",
                      "taxCode": "SHP020000",
                      "shippingAmount": 10.00,
                      "taxAmount": 1.00,
                      "currencyCode": "USD"
                    },
                    "expiry": {               // optional field
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }
            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",         // optional
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""             // optional
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": 2127,
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",                   // last 4 digits
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",                        // optional
                "paymentKind": "CARD_PAYPAL"                    // optional
            },
            "customAttributes": {                               // optional
                "storeId": "60cb07fc20387b000821c5c3",
                "storeAssociateId": "",
                "trackingUrl": "609436d21baded0008945b05"
                }
            }
     ]
      """
    When I run post call
    Then I see response code 400
    And I see that the duplicate subscription can not be created

  @error_invalid_offer_id
  Scenario: Validate error if try to create subscription with offer id which is not valid or exist.
    Given I have endpoint "/bulk"
    And I have request payload having offer id which is not exist or valid
    When I run post call
    Then I see response code 400
    And I see that error message is showing for invalid offer

    # Get Subscriptions by its id
  @get_subscription_by_id
  Scenario: Get Subscriptions by its id
    Given I have endpoint "subscriptions/:id"
    When I run get call api
    Then I see response code 200
    And I see following response :
      """
      {
    "responseStatus": "OK",
    "message": "Request processed successfully",
    "data": {
        "subscription": {
            "status": "ACTIVE",
            "channel": "WEBSITE",
            "offsetDays": 10,
            "originOrderId": "23144449933444444jhh36",
            "customer": {
                "id": "606f01f441b8fc0008529916",
                "customerReferenceId": 446f01f441b8fc0008529912",
                "locale": "en_US",
                "email": "customer@mail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": "employee",
                "employeeId": 1
            },
            "plan": {
                "frequency": 2,
                "frequencyType": "Weekly"
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
            "shipping": {
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
                "source": "PDP"      // optional
            },
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
                    "number": "1099923032",
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
                    "number": "1099923032",
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
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            },
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z"
            }
        }
    }
}
      """

  @subscription_not_found
  Scenario: Verify error message when subscription not found
    Given I have endpoint "/subscriptions/:invalidId"
    When I run get call api
    Then I see response code 404
    Then I see following response :
        """
            {
                "responseStatus": "NOT_FOUND",
                "message": "Subscription not found",
            }
        """
