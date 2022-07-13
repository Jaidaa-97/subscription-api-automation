@subscription_v2 @v2
Business Need: Create Bulk Subscription


  @can_not_create_duplicate_subscription
  Scenario: Duplicate subscription with same order id should not be created
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
          {
                "channel": "WEBSITE",
                "originOrderId": "6803-5058-41270",
                "customer": {
                    "customerReferenceId": "606f01f441b8fc0008529916",
                    "locale": "en_US",
                    "email": "customer@mail.com",
                    "contactNumber": "+92 3333709568",
                    "firstName": "John",
                    "lastName": "Doe",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_sku1---",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }
                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "paymentDetails": {
                    "paymentIdentifier": {
                        "cardIdentifier": "1234",
                        "expiryDate": "04/24"
                    },
                    "paymentMethod": "visa",
                    "paymentKind": "CARD_PAYPAL"
                }
          }
    """
    When I run post call
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
          {
                "channel": "WEBSITE",
                "originOrderId": "6803-5058-41270",
                "customer": {
                    "customerReferenceId": "606f01f441b8fc0008529916",
                    "locale": "en_US",
                    "email": "customer@mail.com",
                    "contactNumber": "+92 3333709568",
                    "firstName": "John",
                    "lastName": "Doe",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_sku1---",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    },
                    {
                        "sku":"---data:-:env_sku1---",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }

                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "paymentDetails": {
                    "paymentIdentifier": {
                        "cardIdentifier": "1234",
                        "expiryDate": "04/24"
                    },
                    "paymentMethod": "visa",
                    "paymentKind": "CARD_PAYPAL"
                }
          }
    """
    When I run post call
    Then I see response code 400
    Then I see property value "Subscription already exists with this originId and itemId" is present in the response property "data.errors[0].errorMessage"
    Then I see property value "INVALID_SUBSCRIPTION" is present in the response property "data.errors[1].errorCode"
    # Missing customerReferenceID
    And I have following request payload :
    """
         {
                "channel": "WEBSITE",
                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "customer": {
                    "locale": "en_US",
                    "email": "customer@mail.com",
                    "contactNumber": "+92 3333709568",
                    "firstName": "John",
                    "lastName": "Doe",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_sku1---",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    },
                    {
                        "sku":"---data:-:env_sku1---",
                        "sku": "ABC123",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }

                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "paymentDetails": {
                    "paymentIdentifier": {
                        "cardIdentifier": "1234",
                        "expiryDate": "04/24"
                    },
                    "paymentMethod": "visa",
                    "paymentKind": "CARD_PAYPAL"
                }
          }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "customer.customerReferenceId" is required
    """
    # missing locale in customer
    And I have following request payload :
    """
          {
                "channel": "WEBSITE",
                "originOrderId": "6803-5058-41270",
                "customer": {
                    "customerReferenceId": "606f01f441b8fc0008529916",
                    "email": "customer@mail.com",
                    "contactNumber": "+92 3333709568",
                    "firstName": "John",
                    "lastName": "Doe",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                         "sku":"---data:-:env_sku1---",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    },
                    {
                         "sku":"---data:-:env_sku2---",
                        "sku": "ABC123",
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }

                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "paymentDetails": {
                    "paymentIdentifier": {
                        "cardIdentifier": "1234",
                        "expiryDate": "04/24"
                    },
                    "paymentMethod": "visa",
                    "paymentKind": "CARD_PAYPAL"
                }
          }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "customer.locale" is required
    """
    # missing email in customer
    When I have following request payload :
    """
{
    "channel": "WEBSITE",
    "originOrderId": "2",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529954",
        "locale": "en_US",
        "contactNumber": "+92 3333709568",
        "firstName": "John",
        "lastName": "Doe",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
             "sku":"---data:-:env_sku1---",
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
            },
            "plan": {
                "frequency": 5,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
             "sku":"---data:-:env_sku2---",
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
            },
            "plan": {
                "frequency": 6,
                "frequencyType": "Weekly"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "customer.email" is required
    """
    # missing firstName
    Given I have following request payload :
    """
{
    "channel": "WEBSITE",
    "originOrderId": "2",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529954",
        "locale": "en_US",
        "email": "jitendra.pisal@mail.com",
        "contactNumber": "+92 3333709568",
        "lastName": "Doe",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
             "sku":"---data:-:env_sku1---",
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
            },
            "plan": {
                "frequency": 5,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
             "sku":"---data:-:env_sku2---",
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
            },
            "plan": {
                "frequency": 6,
                "frequencyType": "Weekly"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "customer.firstName" is required
    """
    # missing lastName
    Given I have following request payload :
    """
{
    "channel": "WEBSITE",
    "originOrderId": "2",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529954",
        "locale": "en_US",
        "email": "jitendra.pisal@mail.com",
        "contactNumber": "+92 3333709568",
        "firstName": "John",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
             "sku":"---data:-:env_sku1---",
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
            },
            "plan": {
                "frequency": 5,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
             "sku":"---data:-:env_sku2---",
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
            },
            "plan": {
                "frequency": 6,
                "frequencyType": "Weekly"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "customer.lastName" is required
    """

  @create_multiple_subscriptions
  Scenario: Create multiple subscriptions
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku":"---data:-:env_sku2---",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    And validate schema "gnc/createBulkSchema.json"

  @create_multiple_subscriptions_withSkuId @subscriptions_success
  Scenario: Create multiple subscriptions with sku id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku":"---data:-:env_sku2---",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode2---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    And validate schema "gnc/bulkSubscriptionWithSKUId.json"

  @create_subscription_without_optional_fields
  Scenario: Create Subscription without optional fields
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
    "channel": "WEBSITE",
    "customer": {
        "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
        "locale": "en_US",
        "email": "customer@mail.com",
        "firstName": "John",
        "lastName": "Doe",
        "segment": ["employee", "designer"]
    },
    "items": [
        {
            "sku":"---data:-:env_sku1---",
            "quantity": 1,
            "itemPrice": {
                "price": 100.00,
                "currencyCode": "USD"
            },
            "plan": {
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offer": {
                "id": "---data:-:env_offercode---"
            }
        }
    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST"
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST"
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        }
    }
}
      """
    When I run post call
    Then I see response code 200
    And validate schema "gnc/createSubscriptionWithoutOptionalfields.json"

  @can_not_create_subscription_if_expiryDate_in_past
  Scenario: Subscription should not be allowed to create if the expiry date is before today
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
    "channel": "WEBSITE",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "en_US",
        "email": "customer@mail.com",
        "contactNumber": "+92 3333709568",
        "firstName": "John",
        "lastName": "Doe",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
            "id":1767788,
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2021-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
            "sku":"---data:-:env_sku2---",
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2021-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
      """
    When I run post call
    Then I see response code 400
    And I see property value "expiryDate cannot be in past" is present in the response property "data.errors[0].errorMessage"

  @invalid_offer_id
  Scenario: Subscription should not be created for invalid offer id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
        """
        {
            "channel": "WEBSITE",
            "originOrderId": "4",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1",
                "communicationPreference":{
                    "SMS":true
                }
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "SUB",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku":"---data:-:env_sku2---",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "SUB",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
        }
        """
    When I run post call
    Then I see response code 400
    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"
    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[1].errorCode"

  @can_not_create_subscription_with_status
  Scenario: Subscription can not be create with status
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
                {
            "status":"ACTIVE",
            "channel": "WEBSITE",
            "originOrderId": "6803-5058-41270",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916",
                "locale": "en_US",
                "email": "customer@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "id":1767788,
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
                    },
                    "plan": {
                        "id": "1000000002",
                        "frequency": 30,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku":"---data:-:env_sku2---",
                    "sku": "ABC123",
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
                    },
                    "plan": {
                        "id": "1000000002",
                        "frequency": 30,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
        }
      """
    When I run post call
    Then I see response code 400
    And I see following value for property "message" :
      """
      "status" is not allowed
      """

  @partial_reponse_no_skuID
  Scenario: Verify partial response if skuid is not present
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
    "channel": "WEBSITE",
    "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "en_US",
        "email": "customer@mail.com",
        "contactNumber": "+92 3333709568",
        "firstName": "John",
        "lastName": "Doe",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
            "sku":"---data:-:env_sku1---",
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
            "sku": "ABC12356434",
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
      """
    When I run post call
    Then I see response code 200
    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
      # Invalid offer code
    And I have following request payload :
      """
      {
    "channel": "WEBSITE",
    "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
    "customer": {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "en_US",
        "email": "customer@mail.com",
        "contactNumber": "+92 3333709568",
        "firstName": "John",
        "lastName": "Doe",
        "segment": ["employee"],
        "employeeId": "1"
    },
    "items": [
        {
           "sku":"---data:-:env_sku1---",
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "---data:-:env_offercode---",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        },
        {
           "sku":"---data:-:env_sku2---",
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
            },
            "plan": {
                "id": "1000000002",
                "frequency": 30,
                "frequencyType": "Daily"
            },
            "offsetDays": 10,
            "offer": {
                "id": "SUB-3106421",
                "source": "PDP"
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
            "expiry": {
                "expiryDate": "2026-07-22T00:00:00.199Z",
                "billingCycles": 10
            }
        }

    ],
    "shipTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "03323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "billTo": {
        "name": {
            "firstName": "Roger",
            "middleName": "",
            "lastName": "Fang"
        },
        "streetAddress": {
            "street1": "27 O ST",
            "street2": ""
        },
        "phone": {
            "number": "012323370957",
            "kind": "mobile"
        },
        "city": "BOSTON MA",
        "state": "MA",
        "postalCode": "2127",
        "country": "US"
    },
    "paymentDetails": {
        "paymentIdentifier": {
            "cardIdentifier": "1234",
            "expiryDate": "04/24"
        },
        "paymentMethod": "visa",
        "paymentKind": "CARD_PAYPAL"
    }
}
      """
    When I run post call
    Then I see response code 200
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "offer code is not valid" is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @partial_response_invalid_offer_id
  Scenario: Partial Response if one of the subscription has invalid offer id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """s
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                   "sku":"---data:-:env_sku2---",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "SUB-31064211",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    Then I see following value for property "message" :
      """
          Request processed with partial success
      """
    Then I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"
    Then I see property value "---data:-:env_sku2---" is present in the response property "data.errors[0].item.sku"

  @partial_response_expiryDate_past
  Scenario: Verify partial response when one of the expiry date of a subscription is in the past
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2020-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                   "sku":"---data:-:env_sku2---",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode2---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "expiryDate cannot be in past" is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku2---" is present in the response property "data.subscriptions[0].item.sku"

  @partial_response_skuId_not_allowed_to_subscription
  Scenario: Verify partial response when skuId is not allowed for subscription
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2028-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku": "8UHY1",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @partial_response_skuId_not_valid
  Scenario: Verify partial response when skuId is not valid
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529954",
                "locale": "en_US",
                "email": "jitendra.pisal@mail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
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
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2028-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                },
                {
                    "sku": "8UHY12342",
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
                    },
                    "plan": {
                        "frequency": 6,
                        "frequencyType": "Weekly"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode---",
                        "source": "PDP"
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
                    "expiry": {
                        "expiryDate": "2026-07-22T00:00:00.199Z",
                        "billingCycles": 10
                    }
                }

            ],
            "shipTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "03323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "billTo": {
                "name": {
                    "firstName": "Roger",
                    "middleName": "",
                    "lastName": "Fang"
                },
                "streetAddress": {
                    "street1": "27 O ST",
                    "street2": ""
                },
                "phone": {
                    "number": "012323370957",
                    "kind": "mobile"
                },
                "city": "BOSTON MA",
                "state": "MA",
                "postalCode": "2127",
                "country": "US"
            },
            "paymentDetails": {
                "paymentIdentifier": {
                    "cardIdentifier": "1234",
                    "expiryDate": "04/24"
                },
                "paymentMethod": "visa",
                "paymentKind": "CARD_PAYPAL"
            }
      }
      """
    When I run post call
    Then I see response code 200
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @no_subscription_discontinued_sku
  Scenario: Subscription should not be created for discontinued sku
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
                "channel": "WEBSITE",
                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "customer": {
                    "customerReferenceId": "c2st83",
                    "locale": "en_US",
                    "email": "shubham@mail.com",
                    "contactNumber": "+91 3333709568",
                    "firstName": "shubham",
                    "lastName": "Pisal",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_discontinuedSKU---",
                        "quantity": 10000000099,
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }

                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
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
                    "storeId": "1234567890",
                    "storeAssociateId": "jitu",
                    "trackingUrl": "http://google.com"
                }
            }
      """
    When I run post call
    Then I see response code 400
    And I see property value "SKU_DISCONTINUED" is present in the response property "data.errors[0].errorCode"

  @subscription_not_allowed
  Scenario: Subscription should not be created for a product which is not available to subscribe
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
                "channel": "WEBSITE",
                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "customer": {
                    "customerReferenceId": "c2st83",
                    "locale": "en_US",
                    "email": "shubham@mail.com",
                    "contactNumber": "+91 3333709568",
                    "firstName": "shubham",
                    "lastName": "Pisal",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_notAvailableSubscription---",
                        "quantity": 10000000099,
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
                        },
                        "plan": {
                            "id": "1000000002",
                            "frequency": 30,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode---",
                            "source": "PDP"
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
                        "expiry": {
                            "expiryDate": "2026-07-22T00:00:00.199Z",
                            "billingCycles": 10
                        }
                    }

                ],
                "shipTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "03323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
                    "country": "US"
                },
                "billTo": {
                    "name": {
                        "firstName": "Roger",
                        "middleName": "",
                        "lastName": "Fang"
                    },
                    "streetAddress": {
                        "street1": "27 O ST",
                        "street2": ""
                    },
                    "phone": {
                        "number": "012323370957",
                        "kind": "mobile"
                    },
                    "city": "BOSTON MA",
                    "state": "MA",
                    "postalCode": "2127",
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
                    "storeId": "1234567890",
                    "storeAssociateId": "jitu",
                    "trackingUrl": "http://google.com"
                }
            }
      """
    When I run post call
    Then I see response code 400
    And I see property value "subscriptions not allowed on this sku" is present in the response property "data.errors[0].errorMessage"
