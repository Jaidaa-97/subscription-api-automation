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
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/---data:-:env_offercode---"
    When I run get call api
    Then I see response code 200
    Then I see property value "---data:-:env_offercode---" is present in the response property "data.offerCode"
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @create_discount_pass_invalid_id @regression_
  Scenario: Pass invalid id
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/INVALIDSKU_"
    When I run get call api
    Then I see response code 404
    Then I see property value "NOT_FOUND" is present in the response property "responseStatus"

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

  @we_can_just_update_the_frequency_for_plan @regression_
  Scenario: We can just update the frequency for the plan
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
    And I have following request payload :
      """
      {
        "frequency": 3
      }
      """
    When I run patch call
    Then I see response code 200
    Then I see property value 3 is present in the response property "data.frequency"
    Given I have endpoint "/data-subscription/v1/plan/---data:-:env_planid---"
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