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
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_swapproduct---"
        }
    ],
    "name": "plan{RandomNumber::4}_---data:-:env_swapproduct---",
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
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
      {
          "items": [
              {
                  "sku":"---data:-:env_notAvailableSubscription---"
              }
          ],
          "name": "plan_{RandomNumber::4}",
          "description": "description",
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

  @create_plan_with_notAllowed_sku @regression_
  Scenario: Creating a plan with a nor allowed  SKU
    Given I have endpoint "/data-subscription/v1/plan"
    And I have following request payload :
    """
    {
    "items": [
        {
            "sku": "---data:-:env_notAvailableSubscription---"
        }
    ],
    "name": "plan{RandomNumber::4}_---data:-:env_notAvailableSubscription---",
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
    Given I have saved property "data.id" as "planId"
    Then I see property value "ACTIVE" is present in the response property "data.status"
    Given I have endpoint "/data-subscription/v1/plan/{SavedValue::planId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "{SavedValue::planId}" is present in the response property "data.id"
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_discount_pass_invalid_id @regression_
  Scenario: Pass invalid id
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/INVALIDSKU_"
    When I run get call api
    Then I see response code 404
    Then I see property value "NOT_FOUND" is present in the response property "responseStatus"

  @updating_the_plan @regression_
  Scenario: Updating the plan
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
    And I have following request payload :
      """
      {
        "description": "update description"
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value "update description" is present in the response property "data.description"

  @we_can_just_update_the_frequency_for_plan @regression_
  Scenario: We can just update the frequency for the plan
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
    And I have following request payload :
      """
      {
        "frequency": 3
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.frequency"
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
    And I have following request payload :
      """
      {
        "frequency": 5
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
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
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

    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
    When I run get call api
    Then I see response code 200
    Then I see property value 5 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"

  @check_frequency_on_upcoming_orders
  Scenario: Check the frequency and frequency type for the upcoming orders after updating the frequency and frequency type
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
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
                        "id": "---data:-:env_planId1---"
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
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
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
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
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
                        "id": "---data:-:env_planId1---"
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
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planId1---"
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