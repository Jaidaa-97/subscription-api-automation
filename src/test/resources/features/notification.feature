@notification @regression
Business Need: Notification and orchestration settings

  @add_before_charge_date
  Scenario: Verify "Before charge date" is setting updated
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "notifyBeforeDays": 6
        }
    """
    When I run post call
    Then I see response code 200
    Then I see property value 6 is present in the response property "data.settings.notifyBeforeDays"


  @add_days
  Scenario: Verify "Time to retry failed payments" is setting updated
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "days": 24
        }
    """
    When I run post call
    Then I see response code 200
    Then I see property value 24 is present in the response property "data.settings.days"


  @add_retries
  Scenario: Verify "Attempts to retry failed payment" is setting updated
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "retries": 10
        }
    """
    When I run post call
    Then I see response code 200
    Then I see property value 10 is present in the response property "data.settings.retries"


  @add_all_fields
  Scenario: Verify all the settings gets updated
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "retries": 2,
            "days": 3,
            "notifyBeforeDays": 5,
            "notifyBeforeTrialExpiry":1
        }
    """
    When I run post call
    Then I see response code 200
    Then validate schema "createSettings.json"
    Then I see property value 2 is present in the response property "data.settings.retries"
    Then I see property value 3 is present in the response property "data.settings.days"
    Then I see property value 5 is present in the response property "data.settings.notifyBeforeDays"
    Then I see property value 1 is present in the response property "data.settings.notifyBeforeTrialExpiry"


  @error_for_negative_values
  Scenario: Verify error response if we pass negative values for fields in payload.
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "retries": -2
        }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "retries" must be greater than 0
    """
    And I have following request payload :
    """
        {
            "days": -3
        }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "days" must be greater than 0
    """
    And I have following request payload :
    """
        {
            "notifyBeforeDays": -5
        }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "notifyBeforeDays" must be greater than 0
    """
    And I have following request payload :
    """
        {
            "notifyBeforeTrialExpiry":-1
        }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "notifyBeforeTrialExpiry" must be greater than 0
    """

  @get_all_settings @get_setting_by_id
  Scenario: Get all Settings | Get settings by id
      # Create Settings
    Given I have endpoint "/data-subscription/orchestration/settings"
    And I have following request payload :
    """
        {
            "retries": 2,
            "days": 3,
            "notifyBeforeDays": 5,
            "notifyBeforeTrialExpiry":1
        }
    """
    When I run post call
    Then I see response code 200
    Then validate schema "createSettings.json"
    And I have saved property "data._id" as "settingID"
      # Get settings based on its _id
    Given I have endpoint "/data-subscription/orchestration/settings/{SavedValue::settingID}"
    When I run get call api
    Then I see response code 200
    Then validate schema "createSettings.json"
    Then I see property value 2 is present in the response property "data.settings.retries"
    Then I see property value 3 is present in the response property "data.settings.days"
    Then I see property value 5 is present in the response property "data.settings.notifyBeforeDays"
    Then I see property value 1 is present in the response property "data.settings.notifyBeforeTrialExpiry"
      # Get all the Settings
    Given I have endpoint "/data-subscription/orchestration/settings"
    When I run get call api
    Then I see response code 200
    Then validate schema "getSettings.json"
    Then I see property value 2 is present in the response property "data.settings.docs[0].settings.retries"
    Then I see property value 3 is present in the response property "data.settings.docs[0].settings.days"
    Then I see property value 5 is present in the response property "data.settings.docs[0].settings.notifyBeforeDays"
    Then I see property value 1 is present in the response property "data.settings.docs[0].settings.notifyBeforeTrialExpiry"
