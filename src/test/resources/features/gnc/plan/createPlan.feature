@planv2
Business Need: Create Plan

  @create_plan_with_valid_item @regression_
  Scenario: Create Plan with valid item
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_sku1---"
        }
    ],
    "name": "plan{RandomNumber::4}_---data:-:env_sku1---",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_plan_with_sku_without_price @regression_
  Scenario: Creating a plan with SKU that hasn't price
    Given I have created sku
    Then I see property value "---data:-:env_sku4---" is present in the response property "productSku"
    When I have saved property "productSku" as "productSku"
    When I have saved property "itemId.toString()" as "itemId"
    When I have saved post 15minutes datetime property as "dateTime"
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "{SavedValue::productSku}"
        }
    ],
    "name": "plan{RandomNumber::4}_{SavedValue::productSku}",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_plan_with_sku_not_allowed @regression_
  Scenario: Creating a plan with SKU that is not allowed to be subscribed
    When I have saved static property "SKU_{RandomNumber::4}" as "productSku"
    Given I have created not allowed to be subscribed sku"{SavedValue::productSku}"
    Then I see property value "{SavedValue::productSku}" is present in the response property "productSku"
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
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "{SavedValue::productSku}"
        }
    ],
    "name": "plan_{SavedValue::productSku}",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_plan_with_discontinue_sku @regression_
  Scenario: Creating a plan with a discontinued SKU
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_discontinuedSKU---"
        }
    ],
    "name": "plan{RandomNumber::4}_---data:-:env_discontinuedSKU---",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @get_plan_by_id @regression_
  Scenario: Get Plan by its id
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    When I run get call api
    Then I see response code 200
    Then I see property value "---data:-:env_planid---" is present in the response property "data.id"
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_Plan_pass_invalid_id @regression_
  Scenario: Pass invalid id
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planInvalidid---"
    When I run get call api
    Then I see response code 400
    Then I see following value for property "message" :
      """
        PLAN_NOT_FOUND
      """


  @updating_the_plan @regression_
  Scenario: Updating the plan
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "description": "update description"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value "update description" is present in the response property "data.description"

  @we_can_just_update_the_frequency_and_frequencyType_for_plan @regression_
  Scenario: We can just update the frequency and frequencyType for the plan
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 3,
        "frequencyType": "Daily"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.frequency"
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 5,
        "frequencyType": "Monthly"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"

  @creating_plan_with_name_used_before @regression_
  Scenario: Creating a plan with name used before
    When I have saved static property "plan{RandomNumber::4}_---data:-:env_sku1---" as "plan_name"
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_sku1---"
        }
    ],
    "name": "{SavedValue::plan_name}",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "ACTIVE" is present in the response property "data.status"

    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_sku1---"
        }
    ],
    "name": "{SavedValue::plan_name}",
    "description": "test plan description",
    "frequency": "5",
    "frequencyType": "Daily"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see property value "Plan already exist" is present in the response property "message"

  @check_frequency_and_type_after_updating_plan @regression_
  Scenario: Check the frequency and frequency type after Updating them by updating the plan itself
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": "5",
        "frequencyType": "Daily"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"

    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    When I run get call api
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"

  @check_frequency_on_upcoming_orders
  Scenario: Check the frequency and frequency type for the upcoming orders after updating the frequency and frequency type
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 3,
        "frequencyType": "Weekly"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.frequency"
    Then I see property value "Weekly" is present in the response property "data.frequencyType"
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
                        "id": "---data:-:env_planid---"
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
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.subscription.plan.frequency"
    Then I see property value "Weekly" is present in the response property "data.subscription.plan.frequencyType"
    #revert it back to 5 daily frequency
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 5,
        "frequencyType": "Daily"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"

  @check_scheduled_date_on_upcoming_orders
  Scenario: Check the scheduled date for the upcoming orders after updating the frequency and frequency type
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 3,
        "frequencyType": "Weekly"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.frequency"
    Then I see property value "Weekly" is present in the response property "data.frequencyType"
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
                        "id": "---data:-:env_planid---"
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
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Then I see property value "{Date::uuu-MM-dd:::d=21}" is contains in the response property "data.orders[0].scheduledDate"
    #revert it back to 5 daily frequency
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 5,
        "frequencyType": "Daily"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"