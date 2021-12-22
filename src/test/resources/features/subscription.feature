@sub @regression
Business Need: subscription

  Scenario: Create subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create subscription api
    And I run post call
