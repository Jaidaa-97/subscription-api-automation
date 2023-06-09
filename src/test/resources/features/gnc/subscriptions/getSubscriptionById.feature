@subscription_v2 @v2 @GetSingleSubscription_Test
Business Need: Get Subscription


  @getSingleSubscriptionById @regression_
  Scenario: Get single subscription by id
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :
"""
      {
            "channel": "POS",
            "originOrderId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
            "customer": {
                "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
                "locale": "en_US",
                "email": "customer{RandomNumber::4}@gmail.com",
                "contactNumber": "453534543544",
                "firstName": "John",
                "lastName": "Doe",
                "segment": ["employee"],
                "employeeId": "112d"
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
    Given I have saved property "data.subscriptions[0].id" as "subId"
    Given I have saved property "data.subscription.customer.email" as "customerEmail"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    And I see property value "en_US" is present in the response property "data.subscription.customer.locale"
#    And I see property value "{SavedValue::customerEmail}" is present in the response property "data.subscription.customer.email"
    And I see property value "453534543544" is present in the response property "data.subscription.customer.contactNumber"
    And I see property value "John" is present in the response property "data.subscription.customer.firstName"
    And I see property value "Doe" is present in the response property "data.subscription.customer.lastName"
    And I see property value "employee" is present in the response property "data.subscription.customer.segment[0]"
    And I see property value "112d" is present in the response property "data.subscription.customer.employeeId"
