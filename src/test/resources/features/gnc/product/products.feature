@products @regression @wip
Business Need: Create Product SKU With Pricing

  @create_sku @regression_
  Scenario: Create Product SKU
    Given I have created sku
    Then I see property value "---data:-:env_sku4---" is present in the response property "productSku"
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




