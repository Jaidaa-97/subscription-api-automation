@subscription_v2 @v2
Business Need: Create Bulk Subscription

#  @can_not_create_duplicate_subscription
#  Scenario: Duplicate subscription with same order id should not be created
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#    """
#          {
#                "channel": "WEBSITE",
#                "originOrderId": "6803-5058-41270",
#                "customer": {
#                    "customerReferenceId": "606f01f441b8fc0008529916",
#                    "locale": "en_US",
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
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#                        "sku":"---data:-:env_sku1---",
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#    When I run post call
#    Then I see response code 400
#    Then I see property value "Subscription already exists with this originId and itemId" is present in the response property "data.errors[0].errorMessage"
#    Then I see property value "INVALID_SUBSCRIPTION" is present in the response property "data.errors[1].errorCode"
#    # Missing customerReferenceID
#    And I have following request payload :
#    """
#          {
#                "channel": "WEBSITE",
#                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#                "customer": {
#                    "locale": "en_US",
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
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#                        "sku":"---data:-:env_sku1---",
#                        "sku": "ABC123",
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#    When I run post call
#    Then I see response code 400
#    Then I see following value for property "message" :
#    """
#        "customer.customerReferenceId" is required
#    """
#    # missing locale in customer
#    And I have following request payload :
#    """
#          {
#                "channel": "WEBSITE",
#                "originOrderId": "6803-5058-41270",
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
#                         "sku":"---data:-:env_sku1---",
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#                         "sku":"---data:-:env_sku2---",
#                        "sku": "ABC123",
#                        "quantity": 1,
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
#                            "frequency": 30,
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
#    When I run post call
#    Then I see response code 400
#    Then I see following value for property "message" :
#    """
#        "customer.locale" is required
#    """
#    # missing email in customer
#    When I have following request payload :
#    """
#{
#    "channel": "WEBSITE",
#    "originOrderId": "2",
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
#             "sku":"---data:-:env_sku1---",
#            "quantity": 1,
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
#            "quantity": 1,
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
#                "frequency": 6,
#                "frequencyType": "Weekly"
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
#    # missing firstName
#    Given I have following request payload :
#    """
#{
#    "channel": "WEBSITE",
#    "originOrderId": "2",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529954",
#        "locale": "en_US",
#        "email": "jitendra.pisal@mail.com",
#        "contactNumber": "+92 3333709568",
#        "lastName": "Doe",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#             "sku":"---data:-:env_sku1---",
#            "quantity": 1,
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
#            "quantity": 1,
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
#                "frequency": 6,
#                "frequencyType": "Weekly"
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
#{
#    "channel": "WEBSITE",
#    "originOrderId": "2",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529954",
#        "locale": "en_US",
#        "email": "jitendra.pisal@mail.com",
#        "contactNumber": "+92 3333709568",
#        "firstName": "John",
#        "segment": ["employee"],
#        "employeeId": "1"
#    },
#    "items": [
#        {
#             "sku":"---data:-:env_sku1---",
#            "quantity": 1,
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
#            "quantity": 1,
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
#                "frequency": 6,
#                "frequencyType": "Weekly"
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
#
#  @create_multiple_subscriptions @create_subscriptions_without_fabric_plan @sanity
#  Scenario: Create multiple subscriptions
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And validate schema "gnc/createBulkSchema.json"

#  @create_multiple_subscriptions_withSkuId
#  Scenario: Create multiple subscriptions with sku id
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And validate schema "gnc/bulkSubscriptionWithSKUId.json"

#  @invalid_offer_id
#  Scenario: Subscription should not be created for invalid offer id
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#        """
#        {
#            "channel": "WEBSITE",
#            "originOrderId": "4",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1",
#                "communicationPreference":{
#                    "SMS":true
#                }
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "SUB",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "SUB",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#        }
#        """
#    When I run post call
#    Then I see response code 400
#    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"
#    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[1].errorCode"

#  @can_not_create_subscription_if_expiryDate_in_past
#  Scenario: Subscription should not be allowed to create if the expiry date is before today
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#    "channel": "WEBSITE",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529916",
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
#            "id":1767788,
#            "quantity": 1,
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
#                "id": "1000000002",
#                "frequency": 30,
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
#                "expiryDate": "2021-07-22T00:00:00.199Z",
#                "billingCycles": 10
#            }
#        },
#        {
#            "sku":"---data:-:env_sku2---",
#            "quantity": 1,
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
#                "id": "1000000002",
#                "frequency": 30,
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
#                "expiryDate": "2021-07-22T00:00:00.199Z",
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
#    And I see property value "expiryDate cannot be in past" is present in the response property "data.errors[0].errorMessage"

#  @create_subscription_without_optional_fields
#  Scenario: Create Subscription without optional fields
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#    "channel": "WEBSITE",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529916",
#        "locale": "en_US",
#        "email": "custom{RandomNumber::4}@gmail.com",
#        "firstName": "John",
#        "lastName": "Doe"
#    },
#    "items": [
#        {
#            "sku":"---data:-:env_sku1---",
#            "quantity": 1,
#            "itemPrice": {
#                "price": 100.00,
#                "currencyCode": "USD"
#            },
#            "plan": {
#                "frequency": 30,
#                "frequencyType": "Daily"
#            },
#            "offer": {
#                "id": "---data:-:env_offercode1---"
#            }
#        }
#    ],
#    "shipTo": {
#        "name": {
#            "firstName": "Roger",
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST"
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
#            "lastName": "Fang"
#        },
#        "streetAddress": {
#            "street1": "27 O ST"
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
#        }
#    }
#}
#      """
#    When I run post call
#    Then I see response code 200
#    And validate schema "gnc/bulkSubscriptionWithSKUId.json"

#  @can_not_create_subscription_with_status
#  Scenario: Subscription can not be create with status
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#                {
#            "status":"ACTIVE",
#            "channel": "WEBSITE",
#            "originOrderId": "6803-5058-41270",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529916",
#                "locale": "en_US",
#                "email": "custom{RandomNumber::4}@gmail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "id":1767788,
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "id": "1000000002",
#                        "frequency": 30,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku":"---data:-:env_sku2---",
#                    "sku": "ABC123",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "id": "1000000002",
#                        "frequency": 30,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#        }
#      """
#    When I run post call
#    Then I see response code 400
#    And I see following value for property "message" :
#      """
#      "status" is not allowed
#      """

#  @partial_reponse_no_skuID @sanity
#  Scenario: Verify partial response if skuid is not present
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#    "channel": "WEBSITE",
#    "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529916",
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
#            "quantity": 10000000099,
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
#                "id": "1000000002",
#                "frequency": 30,
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
#            "sku": "ABC12356434",
#            "quantity": 1,
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
#                "id": "1000000002",
#                "frequency": 30,
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
#      """
#    When I run post call
#    Then I see response code 200
#    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
#    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
#      # Invalid offer code
#    And I have following request payload :
#      """
#      {
#    "channel": "WEBSITE",
#    "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#    "customer": {
#        "customerReferenceId": "606f01f441b8fc0008529916",
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
#           "sku":"---data:-:env_sku1---",
#            "quantity": 10000000099,
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
#                "id": "1000000002",
#                "frequency": 30,
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
#           "sku":"---data:-:env_sku2---",
#            "quantity": 1,
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
#                "id": "1000000002",
#                "frequency": 30,
#                "frequencyType": "Daily"
#            },
#            "offsetDays": 10,
#            "offer": {
#                "id": "SUB-3106421",
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
#      """
#    When I run post call
#    Then I see response code 200
#    And I see property value "Request processed with partial success" is present in the response property "message"
#    And I see property value "offer code is not valid" is present in the response property "data.errors[0].errorMessage"
#    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

#  @getSingleSubscriptionById @sanity
#  Scenario: Get single subscription by id
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+91 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "112d"
#            },
#            "items": [
#                {
#                  "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                   "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And validate schema "gnc/bulkSubscriptionWithSKUId.json"
#    Given I have saved property "data.subscriptions[0].id" as "subId"
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
#    When I run get call api
#    Then I see response code 200
#    And I see property value "en_US" is present in the response property "data.subscription.customer.locale"
#    And I see property value "jitendra.pisal@mail.com" is present in the response property "data.subscription.customer.email"
#    And I see property value "+91 3333709568" is present in the response property "data.subscription.customer.contactNumber"
#    And I see property value "John" is present in the response property "data.subscription.customer.firstName"
#    And I see property value "Doe" is present in the response property "data.subscription.customer.lastName"
#    And I see property value "employee" is present in the response property "data.subscription.customer.segment[0]"
#    And I see property value "112d" is present in the response property "data.subscription.customer.employeeId"
#    And I see property value "true" is present in the response property "data.subscription.customer.communicationPreference.SMS"

#  @partial_response_invalid_offer_id
#  Scenario: Partial Response if one of the subscription has invalid offer id
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """s
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                   "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "SUB-31064211",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    Then I see following value for property "message" :
#      """
#          Request processed with partial success
#      """
#    Then I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"
#    Then I see property value "INVALID_OFFERCODE" is present in the response property "data.errors[0].errorCode"
#    Then I see property value "---data:-:env_sku2---" is present in the response property "data.errors[0].item.sku"

#  @partial_response_expiryDate_past
#  Scenario: Verify partial response when one of the expiry date of a subscription is in the past
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2020-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                   "sku":"---data:-:env_sku2---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And I see property value "Request processed with partial success" is present in the response property "message"
#    And I see property value "expiryDate cannot be in past" is present in the response property "data.errors[0].errorMessage"
#    And I see property value "---data:-:env_sku2---" is present in the response property "data.subscriptions[0].item.sku"

#  @partial_response_skuId_not_allowed_to_subscription
#  Scenario: Verify partial response when skuId is not allowed for subscription
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2028-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku": "8UHY1",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And I see property value "Request processed with partial success" is present in the response property "message"
#    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
#    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

#  @partial_response_skuId_not_valid
#  Scenario: Verify partial response when skuId is not valid
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#            "channel": "WEBSITE",
#            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#            "customer": {
#                "customerReferenceId": "606f01f441b8fc0008529954",
#                "locale": "en_US",
#                "email": "jitendra.pisal@mail.com",
#                "contactNumber": "+92 3333709568",
#                "firstName": "John",
#                "lastName": "Doe",
#                "segment": ["employee"],
#                "employeeId": "1"
#            },
#            "items": [
#                {
#                    "sku":"---data:-:env_sku1---",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 5,
#                        "frequencyType": "Daily"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2028-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                },
#                {
#                    "sku": "8UHY12342",
#                    "quantity": 1,
#                    "weight": 10,
#                    "weightUnit": "lb",
#                    "itemPrice": {
#                        "price": 100.00,
#                        "currencyCode": "USD"
#                    },
#                    "tax": {
#                        "taxCode": "FR020000",
#                        "taxAmount": 10.00,
#                        "currencyCode": "USD"
#                    },
#                    "plan": {
#                        "frequency": 6,
#                        "frequencyType": "Weekly"
#                    },
#                    "offsetDays": 10,
#                    "offer": {
#                        "id": "---data:-:env_offercode1---",
#                        "source": "PDP"
#                    },
#                    "shipping": {
#                      "shipmentCarrier": "USPS",
#                      "shipmentMethod": "Ground",
#                      "shipmentInstructions": "",
#                      "taxCode": "SHP020000",
#                      "shippingAmount": 10.00,
#                      "taxAmount": 1.00,
#                      "currencyCode": "USD"
#                    },
#                    "expiry": {
#                        "expiryDate": "2026-07-22T00:00:00.199Z",
#                        "billingCycles": 10
#                    }
#                }
#
#            ],
#            "shipTo": {
#                "name": {
#                    "firstName": "Roger",
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
#                },
#                "phone": {
#                    "number": "03323370957",
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
#                    "middleName": "",
#                    "lastName": "Fang"
#                },
#                "streetAddress": {
#                    "street1": "27 O ST",
#                    "street2": ""
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
#                },
#                "paymentMethod": "visa",
#                "paymentKind": "CARD_PAYPAL"
#            }
#      }
#      """
#    When I run post call
#    Then I see response code 200
#    And I see property value "Request processed with partial success" is present in the response property "message"
#    And I see property value "Product with the SKU ID does not exist." is present in the response property "data.errors[0].errorMessage"
#    And I see property value "---data:-:env_sku1---" is present in the response property "data.subscriptions[0].item.sku"

#  @deactivate_subscription @reactivate_subscription @sanity
#  Scenario: Deactivate subscription and all the future orders should be canceled.| Reactivate the subscription again
#    Given I have created bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId"
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}/inactive"
#    When I run put call
#    Then I see response code 200
#    Then I see property value "INACTIVE" is present in the response property "data.status"
#      # Get customer id
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
#    When I run get call api
#    Then I see response code 200
#    And I have saved property "data.subscription.customer.id" as "customerId"
#      # Get order id from get orders by customer id api
#    And I wait for 2 sec
#    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
#    When I run get call api
#    Then I see response code 200
#    And I get the index of order for subscription "{SavedValue::subId}" as "index1"
#    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId"
#    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
#    And I run get call api
#    Then I see response code 200
#    Then I see property value "CANCELED" is present in the response property "data.order.status"
#    # Reactivate the subscription again
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}/reactivate"
#    When I run put call
#    Then I see response code 200
#    And I see property value "ACTIVE" is present in the response property "data.status"
#    # verify if new order gets created
#    And I wait for 2 sec
#    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
#    When I run get call api
#    Then I see response code 200
#    Then I verify 3 records are present in the response against the property "data.orders"

  @bulk_update_subscription_of_customer
  Scenario: Bulk update shipping,billing,paymentDetails and offer in subscription of customer
    Given I have created bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId1"
    And I have saved property "data.subscriptions[1].id" as "subId2"
        # Get customer id
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
        # customer updates the shipTo
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/subscriptions"
    And I have following request payload :
        """
            {
              "shipTo": {
                  "name": {
                      "firstName": "Jitendra",
                      "middleName": "Dilip",
                      "lastName": "Pisal"
                  },
                  "streetAddress": {
                      "street1": "kOREGAON PARK",
                      "street2": "Hindu sena marg"
                  },
                  "phone": {
                      "number": "+91 3333709512"
                  },
                  "city": "Pune",
                  "state": "MH",
                  "postalCode": "411001",
                  "country": "US"
              },
              "paymentDetails": {
                  "currencyCode": "USD",
                  "paymentIdentifier": {
                    "cardIdentifier": "5555",
                    "expiryDate": "03/26"
                   },
                   "paymentMethod": "rupay",
                   "paymentKind": "CARD_PAYPAL11"
              }
            }
        """
    When I run patch call
    Then I see response code 200
        # Verify shipTo is updated for all the subscriptions belongs to the customer
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    And I see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.shipTo.city"
    And I see property value "MH" is present in the response property "data.subscription.shipTo.state"
    And I see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.subscription.shipTo.country"

    # validate payment details
    And I see property value "5555" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "03/26" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
    And I see property value "CARD_PAYPAL11" is present in the response property "data.subscription.paymentDetails.paymentKind"

    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId2}"
    When I run get call api
    Then I see response code 200
    And I see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.shipTo.city"
    And I see property value "MH" is present in the response property "data.subscription.shipTo.state"
    And I see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.subscription.shipTo.country"

    # validate payment details
    And I see property value "5555" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "03/26" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
    And I see property value "CARD_PAYPAL11" is present in the response property "data.subscription.paymentDetails.paymentKind"

# Get order id from get orders by customer id api
    And I wait for 5 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I get the index of order for subscription "{SavedValue::subId1}" as "index1"
    And I get the index of order for subscription "{SavedValue::subId2}" as "index2"
    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId1"
    And I get the order id of subscription at index "{SavedValue::index2}" and saved it as "orderId2"
    # Verify order 1 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId1}"
    And I run get call api
    Then I see response code 200
    # verify shipTo gets updated on order
    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I see property value "MH" is present in the response property "data.order.shipTo.state"
    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.order.shipTo.country"

     # validate payment details in order 1
    And I see property value "5555" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "03/26" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"
    And I see property value "CARD_PAYPAL11" is present in the response property "data.order.paymentDetails.paymentKind"

    # Verify order 2 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId2}"
    And I run get call api
    Then I see response code 200
    # verify shipTo gets updated on order
    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I see property value "MH" is present in the response property "data.order.shipTo.state"
    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.order.shipTo.country"

    # validate payment details in order 2
    And I see property value "5555" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "03/26" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"
    And I see property value "CARD_PAYPAL11" is present in the response property "data.order.paymentDetails.paymentKind"

        # customer updates the billTo
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/subscriptions"
    And I have following request payload :
        """
            {
              "billTo": {
                  "name": {
                      "firstName": "Jitendra",
                      "middleName": "Dilip",
                      "lastName": "Pisal"
                  },
                  "streetAddress": {
                      "street1": "kOREGAON PARK",
                      "street2": "Hindu sena marg"
                  },
                  "phone": {
                      "number": "+91 3333709512"
                  },
                  "city": "Pune",
                  "state": "MH",
                  "postalCode": "411001",
                  "country": "US"
              }
            }
        """
    When I run patch call
    Then I see response code 200
        # Verify shipTo is updated for all the subscriptions belongs to the customer
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    And I see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.billTo.city"
    And I see property value "MH" is present in the response property "data.subscription.billTo.state"
    And I see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
    And I see property value "US" is present in the response property "data.subscription.billTo.country"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId2}"
    When I run get call api
    Then I see response code 200
    And I see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.billTo.city"
    And I see property value "MH" is present in the response property "data.subscription.billTo.state"
    And I see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
    And I see property value "US" is present in the response property "data.subscription.billTo.country"


    # Verify order 1 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId1}"
    And I run get call api
    Then I see response code 200
    # verify shipTo gets updated on order
    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I see property value "MH" is present in the response property "data.order.shipTo.state"
    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.order.shipTo.country"

    # Verify order 2 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId2}"
    And I run get call api
    Then I see response code 200
    # verify shipTo gets updated on order
    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I see property value "MH" is present in the response property "data.order.shipTo.state"
    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I see property value "US" is present in the response property "data.order.shipTo.country"

        # Update Offer
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/subscriptions"
    And I have following request payload :
        """
            {
              "offer": {
                 "id": "---data:-:env_updateOfferCode---",
                 "source": "PDP"
               }
            }
        """
    When I run patch call
    Then I see response code 200
        # Verify offer gets updated in all the subscriptions belongs customer
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    And I see property value "---data:-:env_updateOfferCode---" is present in the response property "data.subscription.offer.id"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId2}"
    When I run get call api
    Then I see response code 200
    And I see property value "---data:-:env_updateOfferCode---" is present in the response property "data.subscription.offer.id"

    # validate offer applied in order 1
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId1}"
    And I run get call api
    Then I see response code 200
    And I see property value "---data:-:env_updateOfferCode---" is present in the response property "data.order.lineItems[0].offer.id"

    # validate offer applied in order 2
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId2}"
    And I run get call api
    Then I see response code 200
    And I see property value "---data:-:env_updateOfferCode---" is present in the response property "data.order.lineItems[0].offer.id"

#  @v2_update_subscription
#  Scenario: Update customer details, shipping and billing address, payment details by updating subscription and verify
#  that the orders also gets updated
#    # Create subscription
#    Given I have created bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId1"
#    And I have saved property "data.subscriptions[1].id" as "subId2"
#    # Update customer details
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    And I have following request payload :
#          """
#                {
#                  "item":{},
#                    "customer": {
#                      "customerReferenceId": "606f01f441b8fc0008557433",
#                      "locale": "en_US",
#                      "email": "jj@mail.com",
#                      "contactNumber": "+91 574594335",
#                      "firstName": "James",
#                      "middleName": "Patric",
#                      "lastName": "Pics",
#                      "segment": ["employee1"],
#                      "employeeId": "123482y73"
#                  }
#              }
#          """
#    When I run patch call
#    Then I see response code 200
#    # Verify if customer gets updated or not
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    When I run get call api
#    Then I see response code 200
#    Then I see property value "employee1" is present in the response property "data.subscription.customer.segment[0]"
#    Then I see property value "606f01f441b8fc0008557433" is present in the response property "data.subscription.customer.customerReferenceId"
#    Then I see property value "en_US" is present in the response property "data.subscription.customer.locale"
#    Then I see property value "jj@mail.com" is present in the response property "data.subscription.customer.email"
#    Then I see property value "+91 574594335" is present in the response property "data.subscription.customer.contactNumber"
#    Then I see property value "James" is present in the response property "data.subscription.customer.firstName"
#    Then I see property value "Pics" is present in the response property "data.subscription.customer.lastName"
#    Then I see property value "123482y73" is present in the response property "data.subscription.customer.employeeId"
#    Then I see property value "Patric" is present in the response property "data.subscription.customer.middleName"
#    #Update Shipping and billing address
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    And I have following request payload :
#          """
#                {
#                  "item":{},
#                  "shipTo": {
#                      "name": {
#                      "firstName": "Jitendra",
#                      "middleName": "Dilip",
#                      "lastName": "Pisal"
#                      },
#                      "streetAddress": {
#                          "street1": "kOREGAON PARK",
#                          "street2": "Hindu sena marg"
#                      },
#                      "phone": {
#                          "number": "+91 3333709512"
#                      },
#                      "city": "Pune",
#                      "state": "MH",
#                      "postalCode": "411001",
#                      "country": "IN"
#                  },
#                  "billTo": {
#                      "name": {
#                      "firstName": "Jitendra",
#                      "middleName": "Dilip",
#                      "lastName": "Pisal"
#                  },
#                  "streetAddress": {
#                      "street1": "kOREGAON PARK",
#                      "street2": "Hindu sena marg"
#                  },
#                  "phone": {
#                      "number": "+91 3333709512"
#                  },
#                  "city": "Pune",
#                  "state": "MH",
#                  "postalCode": "411001",
#                  "country": "IN"
#                  },
#                  "paymentDetails": {
#                    "paymentIdentifier": {
#                        "cardIdentifier": "5674",
#                        "expiryDate": "04/25"
#                    },
#                    "paymentMethod": "rupay",
#                    "paymentKind": "CARD_PAYPAL"
#                  }
#                }
#          """
#    When I run patch call
#    Then I see response code 200
#    # Verify if shipping and billing address gets updated or not
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    When I run get call api
#    Then I see response code 200
#    And I have saved property "data.subscription.customer.id" as "customerId"
#    And I see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
#    And I see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
#    And I see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
#    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
#    And I see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
#    And I see property value "Pune" is present in the response property "data.subscription.billTo.city"
#    And I see property value "MH" is present in the response property "data.subscription.billTo.state"
#    And I see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
#    And I see property value "IN" is present in the response property "data.subscription.billTo.country"
#    # validate shipTo details
#    And I see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
#    And I see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
#    And I see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
#    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
#    And I see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
#    And I see property value "Pune" is present in the response property "data.subscription.shipTo.city"
#    And I see property value "MH" is present in the response property "data.subscription.shipTo.state"
#    And I see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
#    And I see property value "IN" is present in the response property "data.subscription.shipTo.country"
#    # Validate if payment details gets updated or not
#    And I see property value "5674" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
#    And I see property value "04/25" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
#    And I see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
#    # Validate other subscription details should not get updated
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId2}"
#    When I run get call api
#    Then I see response code 200
#    And I do not see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
#    And I do not see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
#    And I do not see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
#    And I do not see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
#    And I do not see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
#    And I do not see property value "Pune" is present in the response property "data.subscription.billTo.city"
#    And I do not see property value "MH" is present in the response property "data.subscription.billTo.state"
#    And I do not see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
#    And I do not see property value "IN" is present in the response property "data.subscription.billTo.country"
#    #validate shipTo
#    And I do not see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
#    And I do not see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
#    And I do not see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
#    And I do not see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
#    And I do not see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
#    And I do not see property value "Pune" is present in the response property "data.subscription.shipTo.city"
#    And I do not see property value "MH" is present in the response property "data.subscription.shipTo.state"
#    And I do not see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
#    And I do not see property value "IN" is present in the response property "data.subscription.shipTo.country"
#    # Verify paymentDetails should not be updated in another subscription
#    And I do not see property value "5674" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
#    And I do not see property value "04/25" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
#    And I do not see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
#    # Get order id from get orders by customer id api
#    And I wait for 10 sec
#    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
#    When I run get call api
#    Then I see response code 200
#    And I get the index of order for subscription "{SavedValue::subId1}" as "index1"
#    And I get the index of order for subscription "{SavedValue::subId2}" as "index2"
#    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId1"
#    And I get the order id of subscription at index "{SavedValue::index2}" and saved it as "orderId2"
#    # Verify order 1 gets updated or not
#    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId1}"
#    And I run get call api
#    Then I see response code 200
#    And I see property value "Jitendra" is present in the response property "data.order.billTo.name.firstName"
#    And I see property value "Dilip" is present in the response property "data.order.billTo.name.middleName"
#    And I see property value "Pisal" is present in the response property "data.order.billTo.name.lastName"
#    And I see property value "kOREGAON PARK" is present in the response property "data.order.billTo.streetAddress.street1"
#    And I see property value "Hindu sena marg" is present in the response property "data.order.billTo.streetAddress.street2"
#    And I see property value "Pune" is present in the response property "data.order.billTo.city"
#    And I see property value "MH" is present in the response property "data.order.billTo.state"
#    And I see property value "411001" is present in the response property "data.order.billTo.postalCode"
#    And I see property value "IN" is present in the response property "data.order.billTo.country"
#    # verify shipTo gets updated on order
#    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
#    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
#    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
#    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
#    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
#    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
#    And I see property value "MH" is present in the response property "data.order.shipTo.state"
#    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
#    And I see property value "IN" is present in the response property "data.order.shipTo.country"
#    # Verify payment details gets updated in Order
#    And I see property value "5674" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
#    And I see property value "04/25" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
#    And I see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"
#    # Verify Order 2 gets updated or not
#    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId2}"
#    And I run get call api
#    Then I see response code 200
#    And I do not see property value "Jitendra" is present in the response property "data.order.billTo.name.firstName"
#    And I do not see property value "Dilip" is present in the response property "data.order.billTo.name.middleName"
#    And I do not see property value "Pisal" is present in the response property "data.order.billTo.name.lastName"
#    And I do not see property value "kOREGAON PARK" is present in the response property "data.order.billTo.streetAddress.street1"
#    And I do not see property value "Hindu sena marg" is present in the response property "data.order.billTo.streetAddress.street2"
#    And I do not see property value "Pune" is present in the response property "data.order.billTo.city"
#    And I do not see property value "MH" is present in the response property "data.order.billTo.state"
#    And I do not see property value "411001" is present in the response property "data.order.billTo.postalCode"
#    And I do not see property value "IN" is present in the response property "data.order.billTo.country"
#    And I do not see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
#    And I do not see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
#    And I do not see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
#    And I do not see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
#    And I do not see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
#    And I do not see property value "Pune" is present in the response property "data.order.shipTo.city"
#    And I do not see property value "MH" is present in the response property "data.order.shipTo.state"
#    And I do not see property value "411001" is present in the response property "data.order.shipTo.postalCode"
#    And I do not see property value "IN" is present in the response property "data.order.shipTo.country"
#    # Verify payment details should not get updated in Order 2
#    And I do not see property value "5674" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
#    And I do not see property value "04/25" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
#    And I do not see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"
    # TO DO - update frequency, item quantity

#  @no_subscription_discontinued_sku
#  Scenario: Subscription should not be created for discontinued sku
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#                "channel": "WEBSITE",
#                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#                "customer": {
#                    "customerReferenceId": "c2st83",
#                    "locale": "en_US",
#                    "email": "shubham@mail.com",
#                    "contactNumber": "+91 3333709568",
#                    "firstName": "shubham",
#                    "lastName": "Pisal",
#                    "segment": ["employee"],
#                    "employeeId": "1"
#                },
#                "items": [
#                    {
#                        "sku":"---data:-:env_discontinuedSKU---",
#                        "quantity": 10000000099,
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
#                            "frequency": 30,
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
#                },
#                "customAttributes": {
#                    "storeId": "1234567890",
#                    "storeAssociateId": "jitu",
#                    "trackingUrl": "http://google.com"
#                }
#            }
#      """
#    When I run post call
#    Then I see response code 400
#    And I see property value "SKU_DISCONTINUED" is present in the response property "data.errors[0].errorCode"

#  @subscription_not_allowed
#  Scenario: Subscription should not be created for a product which is not available to subscribe
#    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
#    And I have following request payload :
#      """
#      {
#                "channel": "WEBSITE",
#                "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
#                "customer": {
#                    "customerReferenceId": "c2st83",
#                    "locale": "en_US",
#                    "email": "shubham@mail.com",
#                    "contactNumber": "+91 3333709568",
#                    "firstName": "shubham",
#                    "lastName": "Pisal",
#                    "segment": ["employee"],
#                    "employeeId": "1"
#                },
#                "items": [
#                    {
#                        "sku":"---data:-:env_notAvailableSubscription---",
#                        "quantity": 10000000099,
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
#                            "frequency": 30,
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
#                },
#                "customAttributes": {
#                    "storeId": "1234567890",
#                    "storeAssociateId": "jitu",
#                    "trackingUrl": "http://google.com"
#                }
#            }
#      """
#    When I run post call
#    Then I see response code 400
#    And I see property value "subscriptions not allowed on this sku" is present in the response property "data.errors[0].errorMessage"

#  @update_sku
#  Scenario: Swap the product in subscription with another product which is present in the list of swappable
#    Given I have created bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId1"
#    And I have saved property "data.subscriptions[1].id" as "subId2"
#      # Update sku
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    And I have following request payload :
#          """
#                {
#                    "item":{
#                        "sku":"---data:-:env_sku3---"
#                    }
#                }
#          """
#    When I run patch call
#    Then I see response code 200
#    And I see property value "---data:-:env_sku3---" is present in the response property "data.subscription.item.sku"

#  @swap_incorrect_product
#  Scenario: Product should not be swapped/updated in the subscription if the swapping product is not a part of swappable list of the product
#    Given I have
#    d bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId1"
#    And I have saved property "data.subscriptions[1].id" as "subId2"
#      # Update sku
#    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
#    And I have following request payload :
#          """
#                {
#                    "item":{
#                        "sku":"---data:-:env_sku2---"
#                    }
#                }
#          """
#    When I run patch call
#    Then I see response code 400
#    And I see property value "---data:-:env_sku2--- is not a apart of the swappable SKU list of ---data:-:env_sku1---" is present in the response property "message"

  @upsell_order @remove_item_from_order @error_message_for_invalidLineItem
  Scenario: Add item to an Order for onetime sell/upsell | Remove item from an Order | Verify error message if invalid line item is removed
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8f{RandomNumber::4}{RandomNumber::4}",
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
    And I have saved property "data.subscriptions[0].id" as "subId"
        # Get customer id
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
      # Get order id from get orders by customer id api
    And I wait for 2 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I get the index of order for subscription "{SavedValue::subId}" as "index1"
    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId"
      # Add Upsell item
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
      """
      {
                "lineItems": [
                    {
                        "item": {
                            "sku": "---data:-:env_sku2---",
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
    Then I verify 2 records are present in the response against the property "data.order.lineItems"
    Given I have removed lineItem 1 from an order "{SavedValue::orderId}"
    Then I verify 1 records are present in the response against the property "data.order.lineItems"
    And I see property value 2 is present in the response property "data.order.lineItems[0].lineItemId"
    Given I have removed lineItem 4 from an order "{SavedValue::orderId}"
    Then I see response code 404
    Then I see property value "Invalid line item id" is present in the response property "message[0].errorMessage"

  @add_item_in_subscription
  Scenario: Add items to an order as a part of subscription
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
      """
      {
            "channel": "WEBSITE",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "606f01f441b8f{RandomNumber::4}{RandomNumber::4}",
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
    And I have saved property "data.subscriptions[0].id" as "subId"
        # Get customer id
    When I get the subscription by id "{SavedValue::subId}"
#      Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
#      When I run get call api
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
      # Get order id from get orders by customer id api
    And I wait for 2 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I get the index of order for subscription "{SavedValue::subId}" as "index1"
    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId"

    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
      """
      {
    "lineItems": [
        {
            "subscriptionId": "{SavedValue::subId}",
            "item": {
                "sku": "---data:-:env_sku2---",
                "quantity": 10,
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
    And I see property value "SKU is not allowed with this subscription" is present in the response property "message[0].errorMessage"
    # When we call the get subscription by id then the subscription does not contains newly added quanity of a product

#  @discontinue_item
#  Scenario: All subscription should get inactive if the sku/item is discontinued
#    Given I have created 1 bulk subscription
#    When I discontinued item "---data:-:env_sku1---"
#    Then I see response code 200
#    When I get all the subscription of an item "---data:-:env_sku1---"
#    Then I see response code 200
#    And I see all the subscription of discontinued item gets deactivated

#  @cancel_order_discontinued_item
#  Scenario: All future Order should get cancel for order having only 1 lineItem if the sku/item is discontinued
#    Given I have created 1 bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId"
#    When I get the subscription by id "{SavedValue::subId}"
#    Then I see response code 200
#    And I have saved property "data.subscription.customer.id" as "customerId"
#    When I get all the orders placed by customer "{SavedValue::customerId}"
#    Then I see response code 200
#    And I have saved property "data.orders[0].id" as "orderId"
#    When I discontinued item "---data:-:env_sku1---"
#    Then I see response code 200
#    When I get the order by id "{SavedValue::orderId}"
#    Then I see response code 200
#    And I see property value "CANCELED" is present in the response property "data.order.status"

#  @remove_item_discontinued_item
#  Scenario: Discontinued line item should be removed from the order if order has more than 1 line items
#    Given I have created 1 bulk subscription
#    And I have saved property "data.subscriptions[0].id" as "subId"
#    When I get the subscription by id "{SavedValue::subId}"
#    Then I see response code 200
#    And I have saved property "data.subscription.customer.id" as "customerId"
#    When I get all the orders placed by customer "{SavedValue::customerId}"
#    Then I see response code 200
#    And I have saved property "data.orders[0].id" as "orderId"
#    # Add item in order
#    When add item "---data:-:env_sku2---" in order "{SavedValue::orderId}"
#    When I discontinued item "---data:-:env_sku1---"
#    Then I see response code 200
#    # get order by id
#    When I get the order by id "{SavedValue::orderId}"
#    Then I see response code 200
#    And I do not see property value "CANCELED" is present in the response property "data.order.status"
#    And I verify 1 records are present in the response against the property "data.order.lineItems"
#    And I see property value "---data:-:env_sku2---" is present in the response property "data.order.lineItems[0].item.sku"

    # add more validation to it such as see if item is replaced in all the subscription and orders
#  @replace_item
#  Scenario: Replace item
#    Given I have created 1 bulk subscription
#      # Replace item
#    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
#    And I have following request payload :
#    """
#          {
#          "item": {
#              "sku": "---data:-:env_sku1---"
#          },
#          "replacementItem": {
#              "item": {
#                  "sku": "---data:-:env_sku3---",
#                  "quantity": 1,
#                  "weight": 10,
#                  "weightUnit": "lb",
#                  "itemPrice": {
#                      "price": 100.00,
#                      "currencyCode": "USD"
#                  }
#              }
#          }
#      }
#    """
#    When I run post call
#    Then I see response code 200
#

#  @error_unknown_error
#  Scenario: sku should not be replace if it is not present in the system
#    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
#    And I have following request payload :
#    """
#          {
#          "item": {
#              "sku": "1dfe"
#          },
#          "replacementItem": {
#              "item": {
#                  "sku": "1dddd",
#                  "quantity": 1,
#                  "weight": 10,
#                  "weightUnit": "lb",
#                  "itemPrice": {
#                      "price": 100.00,
#                      "currencyCode": "USD"
#                  }
#              }
#          }
#      }
#    """
#    When I run post call
#    Then I see response code 404

#  @error_no_sku_exist
#  Scenario: Should allow to discontinue item which is not even exist
#    Given I have endpoint "/data-subscription/v1/subscriptions/discontinued-items"
#    And I have following request payload :
#      """
#            {
#          "sku": ["s"]
#            }
#      """
#    When I run post call
#    Then I see response code 404
#
