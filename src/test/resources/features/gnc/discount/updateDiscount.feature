@SUB-716 @update_sub_discount
  Business Need: Update Sub discount

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
    #Update SKUs
And I have following request payload :
"""
            {
              "skus":[
          "SHOES02"
          ]
            }
    """
When I run put call
Then I see response code 200
Then I see property value "SHOES02" is present in the response property "data.skus[0]"
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