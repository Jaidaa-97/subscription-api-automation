@sub @regression @wip
Business Need: subscription

  Background:
    Given Delete subscriptions
    Given Delete plans

  @create_active_subscription @create_sub @sanity
  Scenario: Create active subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And validate schema "createSubscription.json"
    Then I verify ACTIVE subscription is created

  @create_inactive_subscription @create_sub
  Scenario: Create inactive subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create INACTIVE subscription api
    And I run post call
    And validate schema "createSubscription.json"
    Then I verify INACTIVE subscription is created

  @can_not_create_cancel_subscription @create_sub
  Scenario: Verify that the cancel subscription can not be created.
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "status" as "CANCEL" in subscription payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "status" must be one of [INACTIVE, ACTIVE]
    """

  @error_orderReferenceID_missing @create_sub
  Scenario: Verify error message if Order reference is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "orderReferenceId" from payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "orderReferenceId" is required
    """

  @error_customerReferenceId_missing @create_sub
  Scenario: Verify error message of customerReferenceId is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "customerReferenceId" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "data.errors.customerReferenceId.message" :
    """
    Path `customerReferenceId` is required.
    """

  @error_planID_missing @create_sub
  Scenario: Verify error message of planID is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "planID" from payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "value" must contain at least one of [planID, planId]
    """

  @error_itemID_missing @create_sub
  Scenario: Verify error message of itemID is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "itemID" from payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "value" must contain at least one of [itemID, itemId]
    """

  @error_quantity_missing @create_sub
  Scenario: Verify error message of quantity is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "quantity" from payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "quantity" is required
    """

  @error_negative_quantity @create_sub
  Scenario: Verify error message if negative quantity is passed in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "quantity" as "-1" in subscription payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    "quantity" must be greater than -1
    """

  @error_negative_quantity1 @create_sub
  Scenario: Verify error message if try to create a subscription for invalid plan
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "planID" as "se523jn234jn23k4j" in subscription payload
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    Invalid Plan ID. Please provide the valid one!
    """

  @create_sub_with_child_item @create_sub
  Scenario: Create Subscription with child items
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added child items
    And I run post call
    And I see response code 200
    Then I see property value "---data:-:env_productItem2---" is present in the response property "data.childItems[0].itemID"
    Then I see property value 3 is present in the response property "data.childItems[0].quantity"

  @error_create_subscription_on_drafted_plan @create_sub
  Scenario: Verify Error response if we pass the plan id which is not active e.g DRAFT
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    Provided plan is not active!
    """

  @error_create_subscription_on_archived_plan @create_sub
  Scenario: Verify Error response if we pass the plan id which is not active ARCHIVED
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "ARCHIVED" in update plan payload
    And I run the update plan api
    And I see response code 200
    Then I see property value "ARCHIVED" is present in the response property "data.plans[0].status"
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And validate schema "error.json"
    And I see response code 400
    Then I see following value for property "message" :
    """
    Provided plan is not active!
    """

  @error_invalid_item_id @create_sub
  Scenario: Verify error response if we pass the product id which is not associated with passed plan id
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "itemID" as "110" in subscription payload
    And I run post call
    And I see response code 400
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    Provided item ID doesnot associate with the requested plan
    """

  @error_negative_tax @create_sub
  Scenario: Verify error response if tax value is set to negative
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "tax" as "-1" in subscription payload
    And I run post call
    And I see response code 400
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    "tax" must be greater than -1
    """

  @gift_subscription
  Scenario: Gift Subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added property "isGift" as "true" value in payload
    And I have added giftSettings in subscription payload
    And I run post call
    And I see response code 200
    Then I see property value "true" is present in the response property "data.isGift"
    Then I see property value "Jitendra Pisal" is present in the response property "data.giftSettings.recipientName"
    Then I see property value "ar1@shopdev.co" is present in the response property "data.giftSettings.recipientEmail"

  @error_empty_gift_settings @create_sub
  Scenario: Gift Subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added property "isGift" as "true" value in payload
    And I have added empty giftSettings in subscription payload
    And I run post call
    And I see response code 400
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    "giftSettings.recipientName" is not allowed to be empty
    """

  @error_empty_gift_settings @create_sub @wip
  Scenario: Verify error message if name and email for giftSettings is set to empty
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added giftSettings in subscription payload
    And I run post call
    And I see response code 400
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    "value" contains [giftSettings] without its required peers [isGift]
    """
    When I have removed "giftSettings" from payload
    And I have added property "isGift" as "true" value in payload
    And I run post call
    And I see response code 400
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    "value" contains [isGift] without its required peers [giftSettings]
    """

  @update_quantity @update_sub
  Scenario: Update product quantity
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    { "quantity": "10" }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 10 is present in the response property "data.quantity"

  @update_negative_quantity @update_sub
  Scenario: Update product quantity with negative value
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    { "quantity": "-10" }
    """
    When I run put call
    And validate schema "error.json"
    Then I see following value for property "message" :
    """
    "quantity" must be greater than -1
    """

  @update_payment_method @update_sub
  Scenario: Update product quantity with negative value
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    { "paymentMethod": "master card" }
    """
    When I run put call
    Then I see property value "master card" is present in the response property "data.paymentMethod"

  @update_frequency_and_frequencyType_weekly @update_sub @sanity
  Scenario: Update frequency and frequencyType weekly and daily
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    When I have saved property "data.nextPaymentDate" as "nextPaymentDate"
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    {"frequency":2,"frequencyType":"Weekly"}
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 2 is present in the response property "data.frequency"
    Then I see property value "Weekly" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "2" weeks
    Then I verify "data.nextShipDate" date updated is after "2" weeks
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    {"frequency":1,"frequencyType":"Daily"}
    """
    When I run put call
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" days
    Then I verify "data.nextShipDate" date updated is after "1" days

  @update_frequency_and_frequencyType_Daily  @update_sub
  Scenario: Update frequency and frequencyType daily
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    When I have saved property "data.nextPaymentDate" as "nextPaymentDate"
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    {"frequency":1,"frequencyType":"Daily"}
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" days
    Then I verify "data.nextShipDate" date updated is after "1" days

  @update_frequency_and_frequencyType_Monthly @update_sub
  Scenario: Update frequency and frequencyType Monthly
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    {"frequency":1,"frequencyType":"Monthly"}
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Monthly" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" months
    Then I verify "data.nextShipDate" date updated is after "1" months

  @update_frequency_and_frequencyType_Yearly @update_sub
  Scenario: Update frequency and frequencyType Yearly
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
    {"frequency":1,"frequencyType":"Yearly"}
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Yearly" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" years
    Then I verify "data.nextShipDate" date updated is after "1" years

  @update_nextPaymentDate @update_sub
  Scenario: Update next payment date
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    When I have saved property "data.nextPaymentDate" as "nextPaymentDate"
    And I have update subscription endpoint
    And I have set the nextPaymentDate as "increasedNextPaymentDate" by 1 days
    And I have following request payload for update subscription api :
    """
    {"nextPaymentDate":"{SavedValue::increasedNextPaymentDate}"}
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "{SavedValue::increasedNextPaymentDate}" is contains in the response property "data.nextPaymentDate"
    Then I see property value "{SavedValue::increasedNextPaymentDate}" is contains in the response property "data.nextShipDate"

  @update_shipping_billing_details @update_sub
  Scenario: Update shipping/billing details
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
      {
          "shipTo": {
             "name": {
                 "firstName": "Jitendra",
                 "middleName": "Dilip",
                  "lastName": "Pisal"
             },
              "streetAddress": {
                  "street1": "KP",
                  "street2": "Second"
              },
              "city": "PUNE",
              "state": "MH",
              "zipCode": "02127",
              "country": "US",
              "phone": {
                  "number": "345345345345"
              }
          }
      }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "Jitendra" is present in the response property "data.shipTo.name.firstName"
    Then I see property value "Dilip" is present in the response property "data.shipTo.name.middleName"
    Then I see property value "Pisal" is present in the response property "data.shipTo.name.lastName"
    Then I see property value "KP" is present in the response property "data.shipTo.streetAddress.street1"
    Then I see property value "Second" is present in the response property "data.shipTo.streetAddress.street2"
    Then I see property value "PUNE" is present in the response property "data.shipTo.city"
    Then I see property value "MH" is present in the response property "data.shipTo.state"
    Then I see property value "02127" is present in the response property "data.shipTo.zipCode"
    Then I see property value "US" is present in the response property "data.shipTo.country"
    Then I see property value "345345345345" is present in the response property "data.shipTo.phone.number"
    And I have following request payload for update subscription api :
    """
      {
          "billTo": {
             "name": {
                 "firstName": "Jitendra",
                 "middleName": "Dilip",
                  "lastName": "Pisal"
             },
              "streetAddress": {
                  "street1": "KP",
                  "street2": "Second"
              },
              "city": "PUNE",
              "state": "MH",
              "zipCode": "02127",
              "country": "US",
              "phone": {
                  "number": "345345345345"
              }
          }
      }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "Jitendra" is present in the response property "data.billTo.name.firstName"
    Then I see property value "Dilip" is present in the response property "data.billTo.name.middleName"
    Then I see property value "Pisal" is present in the response property "data.billTo.name.lastName"
    Then I see property value "KP" is present in the response property "data.billTo.streetAddress.street1"
    Then I see property value "Second" is present in the response property "data.billTo.streetAddress.street2"
    Then I see property value "PUNE" is present in the response property "data.billTo.city"
    Then I see property value "MH" is present in the response property "data.billTo.state"
    Then I see property value "02127" is present in the response property "data.billTo.zipCode"
    Then I see property value "US" is present in the response property "data.billTo.country"
    Then I see property value "345345345345" is present in the response property "data.billTo.phone.number"

  @update_tax @update_sub
  Scenario: Update tax
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "tax": 10
        }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value 10 is present in the response property "data.tax"

  @swap_products_with_same_plan_product @update_sub @sanity
  Scenario: Swap product with another product belongs to same plan
    Given I have created active plan with multiple products
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "itemID": "---data:-:env_productItem2---"
        }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "---data:-:env_productItem2---" is present in the response property "data.itemID"

  @error_update_product_not_belong_to_same_plan @update_sub
  Scenario: Swap product with another product belongs to same plan
    Given I have created active plan with multiple products
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "itemID": "0000"
        }
    """
    When I run put call
    Then validate schema "error.json"
    Then I see following value for property "message" :
    """
    Provided item ID doesnot associate with the requested plan
    """

  @update_status_to_cancel @update_sub
  Scenario: Update status of subscription from Active to Cancel
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "status": "CANCEL"
        }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "CANCEL" is present in the response property "data.status"

  @update_status_to_inactive @update_sub
  Scenario: Update status of subscription from Active to inactive
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "status": "INACTIVE"
        }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "INACTIVE" is present in the response property "data.status"

  @update_status_from_inactive_to_active @update_sub
  Scenario: Update status of subscription from inactive to active
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create INACTIVE subscription api
    And I run post call
    Then I verify INACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "status": "ACTIVE"
        }
    """
    When I run put call
    Then validate schema "updateSubscription.json"
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @error_update_status @update_sub
  Scenario: Verify that the subscription status can not updated apart from active, inactive, cancel
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have update subscription endpoint
    And I have following request payload for update subscription api :
    """
        {
           "status": "PAUSE"
        }
    """
    When I run put call
    Then validate schema "error.json"
    Then I see following value for property "message" :
    """
      "status" must be one of [INACTIVE, ACTIVE, CANCEL]
    """

  @skipNextSubscription
  # in the response of subscription api, expireDate is set on what basis?
  Scenario: Skip next delivery
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.id" as "subscriptionId"
    When I have saved property "data.nextShipDate" as "nextShipDate"
    And I have skip subscription subscription endpoint
    And I have following request payload :
    """
        {
            "skipDate": "{SavedValue::nextShipDate}",
            "skip": true
        }
    """
    And I run post call
    Then validate schema "skipSubscription.json"
    Then I see response code 200
    Then I see property value "{SavedValue::nextShipDate}" is present in the response property "data.skipDate"
    Then I see property value "{Date::uuu-MM-dd:::d=0}" is contains in the response property "data.createdAt"
    Then I see property value "{Date::uuu-MM-dd:::d=0}" is contains in the response property "data.updatedAt"
    Then I see property value "{SavedValue::subscriptionId}" is contains in the response property "data.subscriptionId"


  @error_skipNextSubscription
  Scenario: Skip delivery by passing the past skipDate
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have skip subscription subscription endpoint
    And I have following request payload :
    """
        {
            "skipDate": "2022-01-09T05:41:54.950Z",
            "skip": true
        }
    """
    And I run post call
    Then validate schema "skipSubError.json"
    Then I see response code 400
    Then I see following value for property "message" :
    """
      Invalid skip date
    """

  @error_skipNextSubscription_paid_date
  Scenario: Skip delivery by passing the paid date
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data.lastPaymentDate" as "lastPaymentDate"
    And I have skip subscription subscription endpoint
    And I have following request payload :
    """
        {
            "skipDate": "{SavedValue::lastPaymentDate}",
            "skip": true
        }
    """
    And I run post call
    Then validate schema "skipSubError.json"
    Then I see response code 400
    Then I see following value for property "message" :
    """
      Invalid skip date
    """

  @delete_subscription
  Scenario: Delete subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have saved property "data.id" as "subId"
    And I have delete subscription endpoint
    And I run delete call
    Then validate schema "deleteSubscription.json"
    Then I see property value "true" is present in the response property "data.isDeleted"
    And I have get by id subscription endpoint
    And I have added path parameter "{SavedValue::subId}"
    And I run get call api
    Then I see following value for property "message" :
    """
      Invalid Subscription ID. Please provide the valid one!
    """

  @get_subscriptions_on_pageNumber_and_PageSize @sanity @wip
  Scenario: Get all the subscriptions based on page number and page size
    And I have create subscription endpoint
    When I run get call api with following param:
      | pageSize | pageNumber |
      | 10       | 1          |
    Then I see property value 10 is present in the response property "data.count"
    Then I verify 10 records are present in the response against the property "data.subscriptions"
    When I run get call api with following param:
      | pageSize | pageNumber |
      | 6        | 3          |
    Then I see property value 6 is present in the response property "data.count"
    Then I verify 6 records are present in the response against the property "data.subscriptions"
    When I run get call api with following param:
      | pageSize | pageNumber |
      | 4        | 4          |
    Then I see property value 4 is present in the response property "data.count"
    Then I verify 4 records are present in the response against the property "data.subscriptions"

  @get_subscriptions_between_date_range @get_sub
  Scenario: Get all the subscription between range of the dates
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have create subscription endpoint
    When I run get call api with following param:
      | startDate                | endDate                  | pageSize |
      | {Date::MM-dd-uuuu:::d=0} | {Date::MM-dd-uuuu:::d=0} | 100      |
    Then I see value "{Date::uuu-MM-dd:::d=0}" is contains in property "createdAt" inside the property array "data.subscriptions"

  @get_subscriptions_for_customer @get_sub
  Scenario: Get all the subscriptions of particular customer
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    Then I have saved property "data.customerID" as "customerId"
    And I have create subscription endpoint
    When I run get call api with following param:
      | customerID               | pageSize |
      | {SavedValue::customerId} | 100      |
    Then I see value "{SavedValue::customerId}" is contains in property "customerID.id" inside the property array "data.subscriptions"

  @error_customer_not_found @get_sub
  Scenario: Verify error message if operator requesting for subscriptions which are belongs to customer which is not present or created yet
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    Then I have saved property "data.customerID" as "customerId"
    And I have create subscription endpoint
    When I run get call api with following param:
      | customerID               | pageSize |
      | 61d6978407912e00099c818b | 100      |
    Then I see following value for property "data.message" :
    """
      customer doesnot exist so no subscription found
    """
    Then I see following value for property "data.error" :
    """
      subscription does not exist for this customer
    """

  @get_all_subscription_of_itemId @get_sub
  Scenario: Get subscriptions using itemId
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I run get call api with following param:
      | itemID                        | pageSize |
      | ---data:-:env_productItem2--- | 100      |
    Then I see value "---data:-:env_productItem2---" is contains in property "itemID" inside the property array "data.subscriptions"

  @get_all_subscription_of_itemId_with_no_subscription @get_sub
  Scenario: Verify response if particular product is not part of any subscription
    Given I have created active plan
    And I have create subscription endpoint
    When I run get call api with following param:
      | itemID                        | pageSize |
      | ---data:-:env_productItem2--- | 100      |
    Then I see property value 0 is present in the response property "data.count"

  @noRecords_endDate_less_than_start_date @get_sub
  Scenario: Verify that we should not get subscriptions in the response if end date is less that start date in the query parameter
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have create subscription endpoint
    When I run get call api with following param:
      | startDate                | endDate                   | pageSize |
      | {Date::MM-dd-uuuu:::d=0} | {Date::MM-dd-uuuu:::d=-1} | 100      |
    Then I see property value 0 is present in the response property "data.count"

  @get_single_subscription @get_sub @sanity
  Scenario: Get single subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have saved property "data.id" as "subId"
    And I have get by id subscription endpoint
    And I have added path parameter "{SavedValue::subId}"
    And I run get call api
    Then I see property value 1 is present in the response property "data.subscription.frequency"
    Then I see property value "Weekly" is present in the response property "data.subscription.frequencyType"
    Then I see property value "---data:-:env_productItem1---" is present in the response property "data.subscription.itemId"
    # TO DO Validate entire response once removed duplicate fields

  @error_invalid_sub_id @get_sub
  Scenario: Verify error message in the repsonse if we pass the invalid subscription id as a path parameter
    And I have get by id subscription endpoint
    And I have added path parameter "6149b314d0ec4b001183des3"
    And I run get call api
    Then I see following value for property "message" :
    """
      Invalid Subscription ID. Please provide the valid one!
    """

  @get_order_by_id @get_sub @sanity
  Scenario: Get single order by its id
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have saved property "data.lastOrderReferenceId" as "orderId"
    And I have get by order id subscription endpoint
    And I have added path parameter "{SavedValue::orderId}"
    And I run get call api
    Then I see property value 1 is present in the response property "data.order.frequency"
    Then I see property value "Weekly" is present in the response property "data.order.frequencyType"
    Then I see property value "---data:-:env_productItem1---" is present in the response property "data.order.itemId"

  @get_orders_for_incorrect_orderId @get_sub
  Scenario: Verify response for invalid order id
    And I have get by order id subscription endpoint
    And I have added path parameter "0000-0000-00"
    And I run get call api
    Then I see property value "null" is present in the response property "data.order"

  @get_order_by_subscriptionId @get_sub @sanity
  Scenario: Get all the orders of subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have saved property "data.id" as "subId"
    And I have get order by subId subscription endpoint
    And I have added path parameter "{SavedValue::subId}"
    And I run get call api
    Then I see property value "{SavedValue::subId}" is present in the response property "data.subscription.id"
    Then I see property value "Weekly" is present in the response property "data.subscription.frequencyType"
    Then I see property value 1 is present in the response property "data.subscription.frequency"
    Then I see property value "---data:-:env_productItem1---" is present in the response property "data.subscription.itemId"

  @get_order_by_customer_ref_id @get_sub @sanity @wip
  Scenario: Get all orders by customer reference id
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have saved property "data.id" as "subId"
    And I have get order by customerId subscription endpoint
    And I have added path parameter "606f01f441b8fc8208049255"
    And I run get call api
    Then validate schema "getByCustomer.json"
    Then I see value "606f01f441b8fc8208049255" is contains in property "customerReferenceId" inside the property array "data.orders"

  @error_incorrect_sub_id @get_sub
  Scenario: Verify error message in the response if we pass incorrect subscription id while getting the orders by sub id
    And I have get order by subId subscription endpoint
    And I have added path parameter "61dfaea0a4527a000996f38d"
    And I run get call api
    Then I see following value for property "message" :
    """
      Provided merchant account ID doesnot associate with the requested Subscription
    """

  @get_schedules_by_customerRefId @get_sub @sanity @wip
  Scenario: Get all orders by customer reference id
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    And I have get by order id subscription endpoint
    And I have added path parameter "scheduled/get-by-customerId/606f01f441b8fc8208049255"
    And I run get call api
    Then I see response code 200
    Then validate schema "scheduledSubscription.json"