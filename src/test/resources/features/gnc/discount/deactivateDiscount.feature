@v2 @deactivate_sub_discount
  Business Need: Deactivate Sub Discount

    @deactivate_discount
    Scenario: Deactivate Discount
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
      And I have saved property "data.id" as "discountId"
      Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/deactivate/{SavedValue::discountId}"
      And I run patch call
      Then I see response code 200

  @deactivate_incorrectID
  Scenario: Deactivate discount incorrect id
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
    Given I have endpoint "/data-subscription/v1/subscriptionDiscounts/deactivate/622748997a95140009cf1ad9"
    And I run patch call
    Then I see response code 404



