@v2 @Create_sub_discount
Business Need: Create Sub Discount

  @SUB-716 @createDiscount @getDiscountById @regression_
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
            "percentage":1

         },
         "skus":[
            "---data:-:env_sku1---"
         ],
         "categories":[
            "product category 1",
            "product category 2",
            "product category 3"
         ],
         "frequency": {
        "frequency": 5,
        "frequencyType": "Daily"
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

     And I have saved property "data.offerCode" as "offerCode"
     Then I see property value "---data:-:env_sku1---" is contains in the response property "data.skus[0]"
    Then I see property value 1 is present in the response property "data.discount.percentage"
    Then I see property value 2 is present in the response property "data.itemQuantity"
    Then I see property value "POS" is present in the response property "data.channel"
    Then I see property value "PDP" is present in the response property "data.target"
    Then I see property value "employee" is present in the response property "data.customerSegment[0]"
    Then I see property value "designer" is present in the response property "data.customerSegment[1]"
    # Get the discount by its code
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/{SavedValue::offerCode}"
    When I run get call api
    Then I see response code 200
#    Then validate schema "/gnc/createDiscount.json"
    Then I see property value 1 is present in the response property "data.discount.percentage"
    Then I see property value 2 is present in the response property "data.itemQuantity"
    Then I see property value "POS" is present in the response property "data.channel"
    Then I see property value "PDP" is present in the response property "data.target"
    Then I see property value "employee" is present in the response property "data.customerSegment[0]"
    Then I see property value "designer" is present in the response property "data.customerSegment[1]"

  @SUB-716 @required_discount_field @regression_
  Scenario: Verify error message if discount field is not passed
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
    {
      "skus":[
              "---data:-:env_sku1---"
           ]
    }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "discount" is required
    """

  @SUB-716 @create_discount_percentage @regression_
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

  @conflict_create_discount_with_sku_and_itemIDs @regression_
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
            "1000038996"
         ],
         "skus":["---data:-:env_sku1---","---data:-:env_sku2---"],

         "categories":[
            "product category 1",
            "product category 2",
            "product category 3"
         ],
         "frequency": {
            "frequency": 5,
            "frequencyType": "Daily"
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
    "value" contains a conflict between exclusive peers [itemIds, skus]
    """

  @SUB-716 @error_discount_in_amount_and_percentage @regression_
  Scenario: Verify that the discount can not be created in amount and percentage at the same time
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
        {
        "discount":{
          "percentage":10,
          "amount": 20
          },
            "skus":["---data:-:env_sku1---"]
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
    "discount" contains a conflict between exclusive peers [percentage, amount]
    """

