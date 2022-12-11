@subscription_v2 @v2
Business Need: Replace Item in Subscription
    @v2_replace_item
    @replace_item @subscriptions_success @after_regression_
    Scenario: Replace item
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
                    "sku":"VITAMIEN-500",
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
#      # Replace item
    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
    And I have following request payload :
    """
              {
              "item": {
              "sku": "VITAMIEN-500"
              },
              "replacementItem": {
                  "item": {
                      "sku": "VITAMIEN-5000",
                      "quantity": 2,
                      "weight": 10,
                      "weightUnit": "lb",
                      "itemPrice": {
                          "price": 100.00,
                          "currencyCode": "USD"
                      }
                  }
              }
          }
        """
    When I run post call
    Then I see response code 200
    And I wait for 10 sec
    # sawp again
    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
    And I have following request payload :
    """
              {
              "item": {
                  "sku": "VITAMIEN-5000"
              },
              "replacementItem": {
                  "item": {
                      "sku": "VITAMIEN-500",
                      "quantity": 2,
                      "weight": 10,
                      "weightUnit": "lb",
                      "itemPrice": {
                          "price": 100.00,
                          "currencyCode": "USD"
                      }
                  }
              }
          }
        """
        When I run post call
        Then I see response code 200

    @error_unknown_error @regression_
    Scenario: sku should not be replace if it is not present in the system
        Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
        And I have following request payload :
    """
          {
          "item": {
              "sku": "1dfe"
          },
          "replacementItem": {
              "item": {
                  "sku": "1dddd",
                  "quantity": 1,
                  "weight": 10,
                  "weightUnit": "lb",
                  "itemPrice": {
                      "price": 100.00,
                      "currencyCode": "USD"
                  }
              }
          }
      }
    """
        When I run post call
        Then I see response code 400


