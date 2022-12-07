@v2 @batch_settings
Business Need: Update Batch Settings And Batching Orders

  @get_batch_settings @regression_
  Scenario: get batch settings
    Given I have endpoint "/data-subscription/v1/batchingsetting/GNC"
    When I run get call api
    Then I see response code 200
    Then I see property value "GNC" is present in the response property "data.client"

  @update_batch_settings @regression_
  Scenario: update batch settings
    Given I have endpoint "/data-subscription/v1/batchingsetting/GNC"
    And I have following request payload :
    """
      {
          "consolidationTime": 9,
          "timeFrame": 4
      }
    """
    When I run patch call
    Then I see response code 200
    Then I see property value 9 is present in the response property "data.consolidationTime"
    Then I see property value 4 is present in the response property "data.timeFrame"
    And I wait for 10 sec
    # update again to verify change
    Given I have endpoint "/data-subscription/v1/batchingsetting/GNC"
    And I have following request payload :
    """
      {
          "consolidationTime": 6,
          "timeFrame": 8
      }
    """
    When I run patch call
    Then I see response code 200
    Then I see property value 6 is present in the response property "data.consolidationTime"
    Then I see property value 8 is present in the response property "data.timeFrame"

  @get_batching_orders @regression_
  Scenario: get batching orders
    Given I have endpoint "/data-subscription/v1/productBatching"
    When I run get call api
    Then I see response code 200
    Then I see property value "Request processed successfully." is present in the response property "message"