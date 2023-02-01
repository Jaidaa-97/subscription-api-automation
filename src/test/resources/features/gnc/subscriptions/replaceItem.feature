@subscription_v2 @v2
Business Need: Replace Item in Subscription
    @v2_replace_item
    @replace_item @subscriptions_success @after_regression_
    Scenario: Replace item
    Given I have created 1 bulk subscription
      # Replace item
    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
    And I have following request payload :
    """
              {
              "item": {
              "sku": "---data:-:env_sku1---"
              },
              "replacementItem": {
                  "item": {
                      "sku": "---data:-:env_swapproduct---",
                      "quantity": 2,
                      "weight": 10,
                      "weightUnit": "lb",
                      "itemPrice": {
                          "price": 100.00,
                          "currencyCode": "USD"
                      }
                  }
              }
          }
        """
    When I run post call
    Then I see response code 200
    And I wait for 10 sec
    # sawp again
    Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
    And I have following request payload :
    """
              {
              "item": {
                  "sku": "---data:-:env_swapproduct---"
              },
              "replacementItem": {
                  "item": {
                      "sku": "---data:-:env_sku1---",
                      "quantity": 2,
                      "weight": 10,
                      "weightUnit": "lb",
                      "itemPrice": {
                          "price": 100.00,
                          "currencyCode": "USD"
                      }
                  }
              }
          }
        """
        When I run post call
        Then I see response code 200

    @error_unknown_error @regression_
    Scenario: sku should not be replace if it is not present in the system
        Given I have endpoint "/data-subscription/v1/subscriptions/replace-items"
        And I have following request payload :
    """
          {
          "item": {
              "sku": "1dfe"
          },
          "replacementItem": {
              "item": {
                  "sku": "1dddd",
                  "quantity": 1,
                  "weight": 10,
                  "weightUnit": "lb",
                  "itemPrice": {
                      "price": 100.00,
                      "currencyCode": "USD"
                  }
              }
          }
      }
    """
        When I run post call
        Then I see response code 404
