Business Need: Create a subscription discount api

  @SUB-727
  Scenario: Create a subscription discount
    Given I have endpoint "/v1/subscriptionDiscount"
    And I have following request payload :
    """
      {
          "validity":{
            "startDate":"2022-04-04T10:18:49.120Z",
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
            "item1234561 ",
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

  @SUB-727
  Scenario: Verify error message if code field is not passed
    Given I have endpoint "/discount/createDiscount"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    { code ,
      discount
    }
    """
    And I run post call
    Then I see response code 400
    Then discount should not be created and valid error message should be shown in the response

  @SUB-727
  Scenario: Verify error message if discount field is not passed
    Given I have endpoint "/discount/createDiscount"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    { code ,
      discount
    }
    """
    And I run post call
    Then I see response code 400
    Then discount should not be created and valid error message should be shown in the response

  @SUB-727
  Scenario: Create a discount for particular segment of customers
    Given I have created segment
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
      "discount":{
          "amount":1
      },
      "customerSegment":[
      "employee",
      "designer"
      ]
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created and this discount code be only applicable for these segmented customers.

  @SUB-727
  Scenario: Create a discount for a product which can be sell with particular frequency e.g monthly, weekly, yearly and daily
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
      "frequency":{
      "shippingFrequency":1,
      "shippingFrequencyType":"daily",
      "billingFrequency":3,
      "billingFrequencyType":"daily"
      },
      "discount":{
          "amount":1
      }
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created and those discount should only be applicable for those frequency.

  @SUB-727
  Scenario: Create a discount for particular product quantity
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
        "discount":{
          "amount":1
        },
        "itemQuantity": 2
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created.

  @SUB-727
  Scenario: Create a discount for channels such as PoS, Web, Mobile
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
    "discount":{
      "amount":1
    },
    "channel": "POS"
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created.

  @SUB-727
  Scenario: Create a discount for particular products or group of products
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
        "itemIds":[
          "item1234561 ",
          "itemI2345678"
        ],
        "categories":[
      "product category 1",
      "product category 2",
      "product category 3"
        ]
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created.

  @SUB-727
  Scenario: Create a discount with discount message
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
    "discount":{
          "amount":1
       },
    "message":"terms and conditions of the offer"
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created.

  @SUB-727
  Scenario: Create a discount with validity
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
        "discount":{
          "amount":1
          },
           "validity":{
          "startDate":"2022-04-04T10:18:49.120Z",
          "endDate":"2022-04-04T10:18:49.120Z",
          "applyOnOrders":[
             2,
             3,
             10
          ]
         }
        }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created with validity.

  Scenario: Create a discount in percentage
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
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

  Scenario: Verify that the discount can not be created in amount and percentage at the same time
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
        "discount":{
          "percentage":10,
          amount: 20
          }
        }
    """
    And I run post call
    Then I see response code 400
    Then Discount should be allowed to create.



  @SUB-727
  Scenario: Create a discount with target
    Given I have endpoint "/subscriptionDiscounts"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
    {
        "discount":{
          "amount":1
        },
        "taget": "PDP"
    }
    """
    And I run post call
    Then I see response code 200
    Then discount should be created.


