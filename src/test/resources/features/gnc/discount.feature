@discount @v2
Business Need: Discount

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
         "itemIds":[
            "item1234561",
            "itemI2345678"
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
    Then I see property value "item1234561" is contains in the response property "data.itemIds[0]"
    Then I see property value "itemI2345678" is contains in the response property "data.itemIds[1]"
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
      "itemIds":[
              "item1234561",
              "itemI2345678"
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
          }
        }
    """
    And I run post call
    Then I see response code 200
    Then I see property value 10 is present in the response property "data.discount.percentage"

  @SUB-716 @error_discount_in_amount_and_percentage
  Scenario: Verify that the discount can not be created in amount and percentage at the same time
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount"
    And I have following request payload :
    """
        {
        "discount":{
          "percentage":10,
          "amount": 20
          }
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
    "discount" contains a conflict between exclusive peers [percentage, amount]
    """

  @SUB-716 @updateDiscount
  Scenario: Update discount
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
    And I have saved property "data.id" as "discountId"
    # Update message
    Given I have endpoint "/data-subscription/v1/subscriptionDiscount/{SavedValue::discountId}"
    And I have following request payload :
    """
        {
          "message":"updated message"
        }
    """
    When I run put call
    Then I see response code 200
    Then I see property value "updated message" is present in the response property "data.message"
    #Update discount
    And I have following request payload :
    """
    {
        "discount":{
          "percentage":10
       }
       }
    """
    When I run put call
    Then I see response code 200
    Then I see property value 10 is present in the response property "data.discount.percentage"
    #Update itemIds
    And I have following request payload :
    """
            {
              "itemIds":[
          "itemId89",
          "itemId56"
          ]
            }
    """
    When I run put call
    Then I see response code 200
    Then I see property value "itemId89" is present in the response property "data.itemIds[0]"
    Then I see property value "itemId56" is present in the response property "data.itemIds[1]"
    # Update categories
    And I have following request payload :
    """
        {
        "categories":[
            "cat1"
          ]
        }
    """
    When I run put call
    Then I see response code 200
    Then I see property value "cat1" is present in the response property "data.categories[0]"
    # Update frequency
    And I have following request payload :
    """
        {
            "frequency":{
            "shippingFrequency":10,
            "shippingFrequencyType":"daily",
            "billingFrequency":4,
            "billingFrequencyType":"weekly"
        }
        }
    """
    When I run put call
    Then I see response code 200
    Then I see property value 10 is present in the response property "data.frequency.shippingFrequency"
    Then I see property value 4 is present in the response property "data.frequency.billingFrequency"
    Then I see property value "weekly" is present in the response property "data.frequency.billingFrequencyType"
    Then I see property value "daily" is present in the response property "data.frequency.shippingFrequencyType"
    # Update itemQuantity, channel, target, customerSegment
    And I have following request payload :
    """
        {
            "itemQuantity": 20,
        "channel": "POS1",
        "target": "PDP1",
        "customerSegment":[
              "employee1",
              "designer1"
            ]
        }
    """
    When I run put call
    Then I see response code 200
    Then I see property value 20 is present in the response property "data.itemQuantity"
    Then I see property value "POS1" is present in the response property "data.channel"
    Then I see property value "PDP1" is present in the response property "data.target"
    Then I see property value "employee1" is present in the response property "data.customerSegment[0]"
    Then I see property value "designer1" is present in the response property "data.customerSegment[1]"

    And I have following request payload :
    """
        {
            "validity":{
                "startDate":"{Date::uuu-MM-dd:::d=2}T10:18:49.120Z",
                "endDate":"2031-04-04T10:18:49.120Z",
                "applyOnOrders":[
                   20,
                   30,
                   100
                ]
            }
        }
    """
    When I run put call
    Then I see response code 200
    Then I see property value 20 is present in the response property "data.validity.applyOnOrders[0]"
    Then I see property value 30 is present in the response property "data.validity.applyOnOrders[1]"
    Then I see property value 100 is present in the response property "data.validity.applyOnOrders[2]"
    Then I see property value "2031-04-04T10:18:49.120Z" is present in the response property "data.validity.endDate"
    Then I see property value "{Date::uuu-MM-dd:::d=2}T10:18:49.120Z" is present in the response property "data.validity.startDate"