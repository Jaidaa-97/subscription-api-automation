@webhook @regression
Business Need: Webhooks

  Background: Delete All the webhooks
    Given I delete all the webhooks

  @create_webhooks @sanity
  Scenario: Create Webhooks
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "SUBSCRIPTION_CREATE",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "SUBSCRIPTION_CREATE" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "SUBSCRIPTION_UPDATE",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "SUBSCRIPTION_UPDATE" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "SUBSCRIPTION_CANCEL",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "SUBSCRIPTION_CANCEL" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "SUBSCRIPTION_RESUMED",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "SUBSCRIPTION_RESUMED" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "CHARGE_SUCCESS",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CHARGE_SUCCESS" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "CHARGE_FAILURE",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CHARGE_FAILURE" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "CHARGE_RETRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CHARGE_RETRY" is present in the response property "data.event"

    And I have following request payload :
    """
        {
          "event": "CHARGE_UPCOMMING",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CHARGE_UPCOMMING" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "CARD_EXPIRED",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CARD_EXPIRED" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "CARD_CREATE",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "CARD_CREATE" is present in the response property "data.event"


  @invalid_webhook_event
  Scenario: Verify error message for invalid webhook
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY1",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
    "event" must be one of [SUBSCRIPTION_CREATE, SUBSCRIPTION_UPDATE, SUBSCRIPTION_CANCEL, SUBSCRIPTION_RESUMED, CHARGE_SUCCESS, CHARGE_FAILURE, CHARGE_RETRY, CHARGE_UPCOMMING, CARD_EXPIRED, CARD_CREATE, TRIAL_EXPIRY]
    """


  @error_webhooks_already_exist
  Scenario: Verify error message if webhook is already created
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "data" :
    """
        Webhook with the event 'TRIAL_EXPIRY' already exists
    """


  @invalid_url_webhook
  Scenario: Verify error message if we pass invalid url
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "sdfsef"
        }
    """
    And I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
        "url" must be a valid uri
    """

  @get_list_of_all_webhooks
  Scenario: Get list of webhooks
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    Given I have endpoint "/data-subscription/webhooks?limit=25&page=1"
    And I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.totalDocs"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.docs[0].event"
    Then I see property value "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa" is present in the response property "data.docs[0].url"


  @get_single_webhook @sanity
  Scenario: Get single webhook
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    Then I have saved property "data._id" as "webhookId"
    Given I have endpoint "/data-subscription/webhooks?limit=25&page=1"
    And I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.totalDocs"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.docs[0].event"
    Then I see property value "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa" is present in the response property "data.docs[0].url"
    Given I have endpoint "/data-subscription/webhooks/{SavedValue::webhookId}"
    And I run get call api
    Then I see response code 200
    Then I see property value "{SavedValue::webhookId}" is present in the response property "data._id"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"


  @update_webhook
  Scenario: Update webhook
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    Then I have saved property "data._id" as "webhookId"
    Given I have endpoint "/data-subscription/webhooks/{SavedValue::webhookId}"
    When I have following request payload :
    """
        {
            "event": "SUBSCRIPTION_CREATE",
            "url": "http://google.com"
        }
    """
    And I run patch call
    Then I see response code 200
    Then I see property value "SUBSCRIPTION_CREATE" is present in the response property "data.event"
    Then I see property value "http://google.com" is present in the response property "data.url"


  @get_webhook_events
  Scenario: Get webhooks events
    Given I have endpoint "/data-subscription/webhooks/available-events"
    And I run get call api
    Then I see response code 200
    Then I see "SUBSCRIPTION_CREATE" value inside property array "data"
    Then I see "SUBSCRIPTION_UPDATE" value inside property array "data"
    Then I see "SUBSCRIPTION_CANCEL" value inside property array "data"
    Then I see "SUBSCRIPTION_RESUMED" value inside property array "data"
    Then I see "CHARGE_SUCCESS" value inside property array "data"
    Then I see "CHARGE_FAILURE" value inside property array "data"
    Then I see "CHARGE_RETRY" value inside property array "data"
    Then I see "CHARGE_UPCOMMING" value inside property array "data"
    Then I see "CARD_EXPIRED" value inside property array "data"
    Then I see "CARD_CREATE" value inside property array "data"
    Then I see "TRIAL_EXPIRY" value inside property array "data"

  @delete_webhook
  Scenario: Delete webhooks
    Given I have endpoint "/data-subscription/webhooks"
    And I have following request payload :
    """
        {
          "event": "TRIAL_EXPIRY",
          "url": "https://webhook.site/4cbcaea9-53fa-4ba9-b168-511232dadasdfasdddaa"
        }
    """
    And I run post call
    Then I see response code 200
    Then validate schema "createWebHook.json"
    Then I see property value "TRIAL_EXPIRY" is present in the response property "data.event"
    Then I have saved property "data._id" as "webhookId"
    Given I have endpoint "/data-subscription/webhooks/{SavedValue::webhookId}"
    And I run delete call
    Then I see property value "true" is present in the response property "data.isDeleted"
    Given I have endpoint "/data-subscription/webhooks/{SavedValue::webhookId}"
    And I run get call api
    Then I see property value "null" is present in the response property "data"

