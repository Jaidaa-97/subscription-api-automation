@subscription_v2 @v2 @Subscriptions_Create_Test
Business Need: Create Bulk Subscription

  @CreateBulkSubscriptionWithoutPlanAndOffer
  Scenario: Create a bulk subscription without plan and offer
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
       {
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
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
    And I see property value "items[0].plan" is contains in the response property "message"
    And I see property value "is required" is contains in the response property "message"

  @CreateBulkSubscriptionWithPlanFrequencyAndFrequencyType
  Scenario: Create a subscription with plan id and frequency and frequency type, It should give an error message
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
       {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "weight": 10,
                    "weightUnit": "lb",
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "id": "---data:-:env_planId1---",
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    },
                    "tax": {
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
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
    And I see property value "items[0].plan" is contains in the response property "message"
    And I see property value "contains a conflict between exclusive peers [id, frequency]" is contains in the response property "message"

  @CreateBulkSubscriptionWithPlanFrequency
  Scenario: Create a subscription with plan id frequency It should give an error message
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
       {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "weight": 10,
                    "weightUnit": "lb",
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "id": "---data:-:env_planId1---",
                        "frequency": "5"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    },
                    "tax": {
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
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
    And I see property value "items[0].plan" is contains in the response property "message"
    And I see property value "contains a conflict between exclusive peers [id, frequency]" is contains in the response property "message"

  @CreateBulkSubscriptionWithPlanFrequencyType
  Scenario: Create a subscription with plan id and frequency type, It should give an error message
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
       {
            "channel": "POS",
            "customer": {
                "customerReferenceId":"{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "weight": 10,
                    "weightUnit": "lb",
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "id": "---data:-:env_planId1---",
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    },
                    "tax": {
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
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
    And I see property value "items[0].plan" is contains in the response property "message"
    And I see property value "contains a conflict between exclusive peers [id, frequencyType]" is contains in the response property "message"

  @CreateBulkSubscriptionWithPlanAndWithoutFrequencyAndFrequencyType
  Scenario: Create a subscription with plan id and without frequency and frequency type, It should give 200 response
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
     """
           {
                "channel": "POS",
                "customer": {
                    "customerReferenceId":"{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                    "locale": "en_US",
                    "email": "custom{RandomNumber::4}@gmail.com",
                    "contactNumber": "+92 3333709568",
                    "firstName": "John",
                    "lastName": "Doe",
                    "segment": ["employee"],
                    "employeeId": "1"
                },
                "items": [
                    {
                        "sku":"---data:-:env_sku1---",
                        "quantity": 2,
                        "weight": 10,
                        "weightUnit": "lb",
                        "itemPrice": {
                            "price": 100.00,
                            "currencyCode": "USD"
                        },
                        "plan": {
                            "id": "---data:-:env_planId1---"
                        },
                        "offer": {
                            "id": "---data:-:env_offercode1---"
                        },
                        "tax": {
                            "taxCode": "FR020000",
                            "taxAmount": 10.00,
                            "currencyCode": "USD"
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

  @can_not_create_duplicate_subscription @regression_
  Scenario: Duplicate subscription with same order id should not be
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    When I have saved static property "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}" as "orderId"
    And I have following request payload :
    """
          {
                "channel": "POS",
                "originOrderId": "{SavedValue::orderId}",
                "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                         "id": "---data:-:env_planId1---"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
          {
                "channel": "POS",
                "originOrderId": "{SavedValue::orderId}",
                "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    Then I see response code 400
#     Then I see property value "Subscription already exists with this originOrderId and itemId/SKU" is present in the response property "data.errors[0].errorMessage"
#     Then I see property value "INVALID_SUBSCRIPTION" is present in the response property "data.errors[0].errorCode"

  @create_multiple_subscriptions @regression_
  Scenario: Create multiple subscriptions
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
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
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
                        "billingCycles": 10
                    }
                },
                {
                    "sku":"---data:-:env_sku2---",
                    "quantity": 2,
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
                    "offer": {
                        "id": "---data:-:env_offercode2---"
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

  @create_multiple_subscriptions_withSkuId @subscriptions_success @regression_
  Scenario: Create multiple subscriptions with sku id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "id":"---data:-:env_item1---",
                    "quantity": 2,
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
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
                        "billingCycles": 10
                    }
                },
                {
                    "id":"---data:-:env_item2---",
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
                        "id": "---data:-:env_offercode2---"
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

  @create_subscription_without_optional_fields @regression_
  Scenario: Create Subscription without optional fields
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
          {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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

  @create_subscription_without_optional_fields @regression_
  Scenario: Create subscription with customerReferenceId only
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
          {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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

  @create_subscription_without_optional_fields @regression_
  Scenario: Create a subscription with offer code that created by passing COPILOT in the channel
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
          {
            "channel": "COPILOT",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku5---",
                    "quantity": 5,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode5---"
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

  @create_subscription_without_optional_fields @regression_
  Scenario: Crate subscription with customerId only
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
          {
            "channel": "COPILOT",
            "customerId": "639adc09e8e82800087f971c",
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
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

  @create_subscription_without_optional_fields @regression_
  Scenario: Crate subscription with Invalid customerId only
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
          {
            "channel": "COPILOT",
            "customerId": "639adc09e8e82800087f9876",
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
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
    Then I see response code 404
    Then I see following value for property "message" :
    """
      Customer not found.
    """

  @create_subscription_without_optional_fields @regression_
  Scenario: Create a Subscription with customerId and customerReferenceId as well
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
          {
            "channel": "POS",
            "customerId": "639adc09e8e82800087f971c",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "value" contains a conflict between exclusive peers [customer, customerId]
    """



#    And validate schema "gnc/createSubscriptionWithoutOptionalfields.json"

#  @can_not_create_subscription_if_expiryDate_in_past
#  Scenario: Subscription should not be allowed to create if the expiry date is before today
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#    "channel": "POS",
#    "customer": {
#        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#        "locale": "en_US",
#        "email": "custom{RandomNumber::4}@gmail.com",
#        "contactNumber": "+92 3333709568",
#        "firstName": "John",
#        "lastName": "Doe",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#            "sku":"---data:-:env_sku1---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offer": {
#                "id": "---data:-:env_offercode1---"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#               "expiryDate": "2022-11-14T11:16:32.544Z",
#                "billingCycles": 10
#            }
#        },
#        {
#            "sku":"---data:-:env_sku2---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offer": {
#                "id": "---data:-:env_offercode2---"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2022-11-14T11:16:32.544Z",
#                "billingCycles": 10
#            }
#        }
#
#    ],
#    "shipTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "03323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "billTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "012323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "paymentDetails": {
#        "paymentIdentifier": {
#            "cardIdentifier": "1234",
#            "expiryDate": "04/24"
#        },
#        "paymentMethod": "visa",
#        "paymentKind": "CARD_PAYPAL"
#    }
#}
#      """
#    When I run post call
#    Then I see response code 400
#    And I see property value "must be greater than" is contains in the response property "message"
#    And I see property value "items[0].expiry.expiryDate must be greater than 2022-11-15T10:37:32.544Z" is present in the response property "message"

  @invalid_offer_id  @regression_
  Scenario: Subscription should not be created for invalid offer id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
        """
        {
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                        "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
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
#    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"

  @partial_reponse_no_skuID @regression_
  Scenario: Subscription can not be create with status
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
                {
            "status":"ACTIVE",
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8fc0008529916",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
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
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode1---",
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
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offsetDays": 10,
                    "offer": {
                        "id": "---data:-:env_offercode1---",
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

  @partial_reponse_no_skuID @regression_
  Scenario: Verify partial response if skuid is not present
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    }
                },
                {
                    "sku":"123452222",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
      # Invalid offer code
    And I have following request payload :
      """
      {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    }
                },
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "SUB"
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
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "offer code is not valid" is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @partial_response_invalid_offer_id @regression_
  Scenario:Verify partial response invalid offer code
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}-{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    }
                },
                {
                    "sku":"PROTEIN_1",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    Then I see following value for property "message" :
      """
          Request processed with partial success
      """
    Then I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"
    Then I see property value "PROTEIN_1" is present in the response property "data.errors[0].item.sku"


  @partial_response_skuId_not_allowed_to_subscription @regression_
  Scenario: Verify partial response when skuId is not allowed for subscription
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    }
                },
                {
                    "sku":"---data:-:env_notAvailableSubscription---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
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
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "subscriptions not allowed on this sku" is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @partial_response_skuId_not_valid @regression_
  Scenario: Verify partial response when skuId is not valid
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee", "designer"]
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    }
                },
                {
                    "sku":"123142",
                    "quantity": 2,
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "plan": {
                        "frequency": 5,
                        "frequencyType": "Daily"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    And I see property value "Request processed with partial success" is present in the response property "message"
    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

  @no_subscription_discontinued_sku @regression_
  Scenario: Subscription should not be created for discontinued sku
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
                "channel": "POS",
                "customer": {
                    "customerReferenceId": "{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}{RandomNumber::4}",
                    "locale": "en_US",
                    "email": "customer{RandomNumber::4}@gmail.com",
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
                            "frequency": 5,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode1---",
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
#    And I see property value "SKU_DISCONTINUED" is present in the response property "data.errors[0].errorCode"

  @subscription_not_allowed @regression_
  Scenario: Subscription should not be created for a product which is not available to subscribe
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {

                "channel": "POS",
                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "customer": {
                    "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                    "locale": "en_US",
                    "email": "customer{RandomNumber::4}-{RandomNumber::4}@gmail.com",
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

                            "frequency": 5,
                            "frequencyType": "Daily"
                        },
                        "offsetDays": 10,
                        "offer": {
                            "id": "---data:-:env_offercode1---",
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
#    And I see property value "SKU_DISCONTINUED" is present in the response property "data.errors[0].errorMessage"

  @check_offset_days
  Scenario: Check offset days for bulk subscription
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    When I have saved static property "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}" as "orderId"
    When I have saved static property "10" as "offsetDays"
    And I have following request payload :
      """
      {
            "channel": "POS",
            "originOrderId": "{SavedValue::orderId}",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
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
                    "offsetDays": {SavedValue::offsetDays},
                    "offer": {
                        "id": "---data:-:env_offercode1---"
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
    When I have saved property "data.subscriptions[0].id" as "subId"
    And I wait for 15 sec
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "{SavedValue::offsetDays}" is present in the response property "data.subscription.offsetDays.toString()"


#  @verify_missing_email_locale_name:
#  Scenario: Verify error message if customer don’t pass email, locale, firstName, lastName
#    #missing locale
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#    """
#          {
#                "channel": "WEBSITE",
#                "customer": {
#                    "customerReferenceId": "606f01f441b8fc0008529916",
#                    "email": "custom{RandomNumber::4}@gmail.com",
#                    "contactNumber": "+92 3333709568",
#                    "firstName": "John",
#                    "lastName": "Doe",
#                    "segment": ["employee"],
#                    "employeeId": "1"
#                },
#                "items": [
#                    {
#                        "sku":"---data:-:env_sku1---",
#                        "quantity": 2,
#                        "weight": 10,
#                        "weightUnit": "lb",
#                        "itemPrice": {
#                            "price": 100.00,
#                            "currencyCode": "USD"
#                        },
#                        "tax": {
#                            "taxCode": "FR020000",
#                            "taxAmount": 10.00,
#                            "currencyCode": "USD"
#                        },
#                        "plan": {
#                            "id": "1000000002",
#                            "frequency": 5,
#                            "frequencyType": "Daily"
#                        },
#                        "offsetDays": 10,
#                        "offer": {
#                            "id": "---data:-:env_offercode1---",
#                            "source": "PDP"
#                        },
#                        "shipping": {
#                          "shipmentCarrier": "USPS",
#                          "shipmentMethod": "Ground",
#                          "shipmentInstructions": "",
#                          "taxCode": "SHP020000",
#                          "shippingAmount": 10.00,
#                          "taxAmount": 1.00,
#                          "currencyCode": "USD"
#                        },
#                        "expiry": {
#                            "expiryDate": "2026-07-22T00:00:00.199Z",
#                            "billingCycles": 10
#                        }
#                    },
#                    {
#                        "sku":"---data:-:env_sku2---",
#                        "quantity": 2,
#                        "weight": 10,
#                        "weightUnit": "lb",
#                        "itemPrice": {
#                            "price": 100.00,
#                            "currencyCode": "USD"
#                        },
#                        "tax": {
#                            "taxCode": "FR020000",
#                            "taxAmount": 10.00,
#                            "currencyCode": "USD"
#                        },
#                        "plan": {
#                            "id": "1000000002",
#                            "frequency": 5,
#                            "frequencyType": "Daily"
#                        },
#                        "offsetDays": 10,
#                        "offer": {
#                            "id": "---data:-:env_offercode1---",
#                            "source": "PDP"
#                        },
#                        "shipping": {
#                          "shipmentCarrier": "USPS",
#                          "shipmentMethod": "Ground",
#                          "shipmentInstructions": "",
#                          "taxCode": "SHP020000",
#                          "shippingAmount": 10.00,
#                          "taxAmount": 1.00,
#                          "currencyCode": "USD"
#                        },
#                        "expiry": {
#                            "expiryDate": "2026-07-22T00:00:00.199Z",
#                            "billingCycles": 10
#                        }
#                    }
#
#                ],
#                "shipTo": {
#                    "name": {
#                        "firstName": "Roger",
#                        "middleName": "",
#                        "lastName": "Fang"
#                    },
#                    "streetAddress": {
#                        "street1": "27 O ST",
#                        "street2": ""
#                    },
#                    "phone": {
#                        "number": "03323370957",
#                        "kind": "mobile"
#                    },
#                    "city": "BOSTON MA",
#                    "state": "MA",
#                    "postalCode": "2127",
#                    "country": "US"
#                },
#                "billTo": {
#                    "name": {
#                        "firstName": "Roger",
#                        "middleName": "",
#                        "lastName": "Fang"
#                    },
#                    "streetAddress": {
#                        "street1": "27 O ST",
#                        "street2": ""
#                    },
#                    "phone": {
#                        "number": "012323370957",
#                        "kind": "mobile"
#                    },
#                    "city": "BOSTON MA",
#                    "state": "MA",
#                    "postalCode": "2127",
#                    "country": "US"
#                },
#                "paymentDetails": {
#                    "paymentIdentifier": {
#                        "cardIdentifier": "1234",
#                        "expiryDate": "04/24"
#                    },
#                    "paymentMethod": "visa",
#                    "paymentKind": "CARD_PAYPAL"
#                }
#          }
#    """
#      When I run post call
#      Then I see response code 400
#      Then I see following value for property "message" :
#    """
#        "customer.locale" is required
#    """
#    #missing email
#    When I have following request payload :
#    """
#  {
#    "channel": "WEBSITE",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529954",
#        "locale": "en_US",
#        "contactNumber": "+92 3333709568",
#        "firstName": "John",
#        "lastName": "Doe",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#            "sku":"---data:-:env_sku1---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        },
#        {
#             "sku":"---data:-:env_sku2---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        }
#
#    ],
#    "shipTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "03323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "billTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "012323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "paymentDetails": {
#        "paymentIdentifier": {
#            "cardIdentifier": "1234",
#            "expiryDate": "04/24"
#        },
#        "paymentMethod": "visa",
#        "paymentKind": "CARD_PAYPAL"
#    }
#}
#    """
#    When I run post call
#    Then I see response code 400
#    Then I see following value for property "message" :
#    """
#        "customer.email" is required
#    """
#    #missing firstname
#        Given I have following request payload :
#    """
#    {
#    "channel": "WEBSITE",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529954",
#        "locale": "en_US",
#        "email": "custom{RandomNumber::4}@gmail.com",
#        "contactNumber": "+92 3333709568",
#        "lastName": "Doe",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#             "sku":"---data:-:env_sku1---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        },
#        {
#             "sku":"---data:-:env_sku2---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        }
#
#    ],
#    "shipTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "03323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "billTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "012323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "paymentDetails": {
#        "paymentIdentifier": {
#            "cardIdentifier": "1234",
#            "expiryDate": "04/24"
#        },
#        "paymentMethod": "visa",
#        "paymentKind": "CARD_PAYPAL"
#    }
#}
#    """
#    When I run post call
#    Then I see response code 400
#    Then I see following value for property "message" :
#    """
#        "customer.firstName" is required
#    """
#    # missing lastName
#    Given I have following request payload :
#    """
#    {
#    "channel": "WEBSITE",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529954",
#        "locale": "en_US",
#        "email": "custom{RandomNumber::4}@gmail.com",
#        "contactNumber": "+92 3333709568",
#        "firstName": "John",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#             "sku":"---data:-:env_sku1---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        },
#        {
#             "sku":"---data:-:env_sku2---",
#            "quantity": 2,
#            "weight": 10,
#            "weightUnit": "lb",
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "tax": {
#                "taxCode": "FR020000",
#                "taxAmount": 10.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 5,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "---data:-:env_offercode1---",
#                "source": "PDP"
#            },
#            "shipping": {
#              "shipmentCarrier": "USPS",
#              "shipmentMethod": "Ground",
#              "shipmentInstructions": "",
#              "taxCode": "SHP020000",
#              "shippingAmount": 10.00,
#              "taxAmount": 1.00,
#              "currencyCode": "USD"
#            },
#            "expiry": {
#                "expiryDate": "2026-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        }
#
#    ],
#    "shipTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "03323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "billTo": {
#        "name": {
#            "firstName": "Roger",
#            "middleName": "",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST",
#            "street2": ""
#        },
#        "phone": {
#            "number": "012323370957",
#            "kind": "mobile"
#        },
#        "city": "BOSTON MA",
#        "state": "MA",
#        "postalCode": "2127",
#        "country": "US"
#    },
#    "paymentDetails": {
#        "paymentIdentifier": {
#            "cardIdentifier": "1234",
#            "expiryDate": "04/24"
#        },
#        "paymentMethod": "visa",
#        "paymentKind": "CARD_PAYPAL"
#    }
#}
#    """
#    When I run post call
#    Then I see response code 400
#    Then I see following value for property "message" :
#    """
#        "customer.lastName" is required
#    """

  Scenario: no order will be created for the bulk that has offsetdays attribute
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
    """
       {
            "channel": "POS",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "custom{RandomNumber::4}@gmail.com",
                "contactNumber": "+92 3333709568",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "1"
            },
            "items": [
                {
                    "sku":"---data:-:env_sku1---",
                    "quantity": 2,
                    "weight": 10,
                    "weightUnit": "lb",
                    "itemPrice": {
                        "price": 100.00,
                        "currencyCode": "USD"
                    },
                    "offsetDays": 5,
                    "plan": {
                        "id": "---data:-:env_planId1---"
                    },
                    "offer": {
                        "id": "---data:-:env_offercode1---"
                    },
                    "tax": {
                        "taxCode": "FR020000",
                        "taxAmount": 10.00,
                        "currencyCode": "USD"
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
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 404
    Then I see property value "Order not found" is present in the response property "message"