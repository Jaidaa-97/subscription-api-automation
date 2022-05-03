Business Need: Update discount


  Scenario: Update validity of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
        "validity": {
            "startDate": "2022-04-04T10:18:49.120Z",
            "endDate": "2022-04-04T10:18:49.120Z",
            "orders": "2" // what is orders? no. of orders?
          }
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see validity is updated

  Scenario: Update product of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "product": {
          "productIds": [
              "productId1",
              "productId2"
          ],
          "category": "product category", // what is category. How can I create a category? Is there a endpoint?
          "categoryId": "product categoryId"
          }
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see products are updated

  Scenario: Update frequency of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "frequency": 1,
          "frequencyType": "Daily"
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see frequency gets updated

  Scenario: Update product quantity of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "productQuantity": 2
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see productQuantity gets updated

  Scenario: Update channel(POS, WEB, MOBILE) quantity of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "channel": "POS"
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see CHANNEL gets updated

  Scenario: Update customer Segment quantity of discount(validate that the offers should valid only for the added customer segments)
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "customerSegment": "private"
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see customer segment gets updated and the discount is only valid for added customer segment.

  Scenario: Update target(PDP, cart, quick view, subscription management portal) of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "target": "Cart"
        }
    """
    And I run put call
    Then I see response code 200
    Then I verified that taget gets updated and the discount is only applicable for those offer when customer add to cart from above mentioned location

  Scenario: Update percentage and amount of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "discount": {
            "percentage": 1,
            "amount": 2
          }
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see percentage and amount gets updated

  Scenario: Update message of discount
    Given I have endpoint "/subscriptionDiscounts/6221f21a67d8960009f4e0b4"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        {
          "message":"discount for steel"
        }
    """
    And I run put call
    Then I see response code 200
    Then I should see message gets updated