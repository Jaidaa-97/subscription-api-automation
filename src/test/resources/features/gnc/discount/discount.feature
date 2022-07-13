@v2 @Create_sub_discount
Business Need: Create Sub Discount

  @SUB-716 @createDiscount @getDiscountById
  Scenario: Create a subscription discount || Get discount by its id
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
      {
          "validity":{
            "startDate":"{Date::uuu-MM-dd:::d=1}T10:18:49.120Z",
            "endDate":"2030-04-04T10:18:49.120Z",
            "applyOnOrders":[
               2,
               3,
               10
            ]
         },
         "message":"terms and conditions of the offer",
         "discount":{
            "amount":1
         },
         "skus":[
            "MOT44"
         ],
         "categories":[
            "product category 1",
            "product category 2",
            "product category 3"
         ],
         "frequency":{
            "shippingFrequency":1,
            "shippingFrequencyType":"daily",
            "billingFrequency":3,
            "billingFrequencyType":"daily"
         },
          "itemQuantity": 2,
              "channel": "POS",
              "target": "PDP",
          "customerSegment":[
            "employee",
            "designer"
         ]
      }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "/gnc/createDiscount.json"
    And I have saved property "data.offerCode" as "offerCode"
    Then I see property value "MOT44" is contains in the response property "data.skus[0]"
    Then I see property value 1 is present in the response property "data.discount.amount"
    Then I see property value 2 is present in the response property "data.itemQuantity"
    Then I see property value "POS" is present in the response property "data.channel"
    Then I see property value "PDP" is present in the response property "data.target"
    Then I see property value "employee" is present in the response property "data.customerSegment[0]"
    Then I see property value "designer" is present in the response property "data.customerSegment[1]"
    # Get the discount by its code
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/{SavedValue::offerCode}"
    When I run get call api
    Then I see response code 200
    Then validate schema "/gnc/createDiscount.json"
    Then I see property value "item1234561" is contains in the response property "data.itemIds[0]"
    Then I see property value "itemI2345678" is contains in the response property "data.itemIds[1]"
    Then I see property value 1 is present in the response property "data.discount.amount"
    Then I see property value 2 is present in the response property "data.itemQuantity"
    Then I see property value "POS" is present in the response property "data.channel"
    Then I see property value "PDP" is present in the response property "data.target"
    Then I see property value "employee" is present in the response property "data.customerSegment[0]"
    Then I see property value "designer" is present in the response property "data.customerSegment[1]"

  @SUB-716 @required_discount_field
  Scenario: Verify error message if discount field is not passed
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
    {
      "skus":[
              "MOT44"
           ]
    }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "discount" is required
    """

  @SUB-716 @create_discount_percentage
  Scenario: Create a discount in percentage
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
        {
        "discount":{
          "percentage":10
          },
          "skus":[]
        }
    """
    And I run post call
    Then I see response code 200
    Then I see property value 10 is present in the response property "data.discount.percentage"

  @conflict_create_discount_with_sku_and_itemIDs
  Scenario: conflict create discount with sku and itemIDs
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
      {
          "validity":{
            "startDate":"{Date::uuu-MM-dd:::d=1}T10:18:49.120Z",
            "endDate":"2030-04-04T10:18:49.120Z",
            "applyOnOrders":[
               2,
               3,
               10
            ]
         },
         "message":"terms and conditions of the offer",
         "discount":{
            "amount":1
         },
         "itemIds":[
            "item1234561",
            "itemI2345678"
         ],
         "skus":["MO44"],

         "categories":[
            "product category 1",
            "product category 2",
            "product category 3"
         ],
         "frequency":{
            "shippingFrequency":1,
            "shippingFrequencyType":"daily",
            "billingFrequency":3,
            "billingFrequencyType":"daily"
         },
          "itemQuantity": 2,
              "channel": "POS",
              "target": "PDP",
          "customerSegment":[
            "employee",
            "designer"
         ]
      }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """

    """

  @SUB-716 @error_discount_in_amount_and_percentage
  Scenario: Verify that the discount can not be created in amount and percentage at the same time
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
        {
        "discount":{
          "percentage":10,
          "amount": 20
          },
            "skus":[]
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
    "discount" contains a conflict between exclusive peers [percentage, amount]
    """

