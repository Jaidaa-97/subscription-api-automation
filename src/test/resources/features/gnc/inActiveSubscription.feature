@create_bulk
Business Need: Create Bulk Subscription


  @Duplicate_subscription_with_same_order_id_should_not_be_created
  @can_not_create_duplicate_subscription
  Scenario: Duplicate subscription with same order id should not be created
    Given I have endpoint "/data-subscription/v1/subscriptions/bulk"
    And I have following request payload :