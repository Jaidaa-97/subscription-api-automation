@v2 @create_cancellation_reason
  Business Need: Create cancellation Reason

    @create_success_scenario @regression_
    Scenario: Success Scenario
      Given I have endpoint "/data-subscription/v1/cancelation-reasons"
      And I have following request payload :
      """
      [
           {
             "code" : 9,
              "reason": "cancelation reason. 9"
             },
            {
              "code" : 10,
               "reason": "cancelation reason. 10"
              }
      ]
      """
      And I run post call
      Then I see response code 200

    @create_partial_success_scenario
    Scenario: Success partial Scenario
      Given I have endpoint "/data-subscription/v1/cancelation-reasons"
      And I have following request payload :
      """
      [
           {
             "code" : 23,
              "reason": "cancelation reason. 23"
             },
            {
              "code" : 25,
               "reason": "cancelation reason. 25"
              }
      ]
      """
      And I run post call
      Then I see response code 200

    @all_code_are_duplicates
    Scenario: all code are duplicates
      Given I have endpoint "/data-subscription/v1/cancelation-reasons"
      And I have following request payload :
      """
      [
        {
          "code" : 11,
          "reason": "cancelation reason. 9"
        },
        {
          "code" : 11,
          "reason": "cancelation reason. 11"
        }
        ]

      """
      And I run post call
      Then I see response code 400
      Then I see property value "All codes are duplicates" is present in the response property "message"


