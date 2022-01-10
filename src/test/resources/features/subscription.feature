@sub @regression
Business Need: subscription


  @create_active_subscription
  Scenario: Create active subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created

  @create_inactive_subscription
  Scenario: Create inactive subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create INACTIVE subscription api
    And I run post call
    Then I verify INACTIVE subscription is created

  @can_not_create_cancel_subscription
  Scenario: Verify that the cancel subscription can not be created.
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "status" as "CANCEL" in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "status" must be one of [INACTIVE, ACTIVE]
    """

  @error_orderReferenceID_missing
  Scenario: Verify error message if Order reference is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "orderReferenceId" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "orderReferenceId" is required
    """

  @error_customerReferenceId_missing
  Scenario: Verify error message of customerReferenceId is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "customerReferenceId" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "customerReferenceId" is required
    """

  @error_planID_missing
  Scenario: Verify error message of planID is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "planID" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "planID" is required
    """

  @error_itemID_missing
  Scenario: Verify error message of itemID is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "itemID" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "itemID" is required
    """

  @error_quantity_missing
  Scenario: Verify error message of quantity is missing in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have removed "quantity" from payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "quantity" is required
    """

  @error_negative_quantity
  Scenario: Verify error message if negative quantity is passed in the request payload
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "quantity" as "-1" in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "quantity" must be greater than -1
    """

  @error_negative_quantity
  Scenario: Verify error message if try to create a subscription for invalid plan
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "planID" as "se523jn234jn23k4j" in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    Invalid Plan ID. Please provide the valid one!
    """

  @create_sub_with_child_item
  Scenario: Create Subscription with child items
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added child items
    And I run post call
    And I see response code 200
    Then I see property value "1000000047" is present in the response property "data.childItems[0].itemID"
    Then I see property value 3 is present in the response property "data.childItems[0].quantity"
    Then I see property value "1000000094" is present in the response property "data.childItems[1].itemID"
    Then I see property value 4 is present in the response property "data.childItems[1].quantity"

  @error_create_subscription_on_drafted_plan
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
    And I see response code 400
    Then I see following value for property "message" :
    """
    Provided plan is not active!
    """

  @error_create_subscription_on_archived_plan
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
    Then I see property value "ARCHIVED" is present in the response property "data._original.plan.status"
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    Provided plan is not active!
    """

  @error_invalid_item_id
  Scenario: Verify error response if we pass the product id which is not associated with passed plan id
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "itemID" as "110" in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    Provided item ID doesnot associate with the requested plan
    """

  @error_negative_tax
  Scenario: Verify error response if tax value is set to negative
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have updated property "tax" as "-1" in subscription payload
    And I run post call
    And I see response code 400
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

  @error_empty_gift_settings
  Scenario: Gift Subscription
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added property "isGift" as "true" value in payload
    And I have added empty giftSettings in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "giftSettings.recipientName" is not allowed to be empty
    """

  @error_empty_gift_settings
  Scenario: Verify error message if name and email for giftSettings is set to empty
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I have added giftSettings in subscription payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "value" contains [giftSettings] without its required peers [isGift]
    """
    When I have removed "giftSettings" from payload
    And I have added property "isGift" as "true" value in payload
    And I run post call
    And I see response code 400
    Then I see following value for property "message" :
    """
    "value" contains [isGift] without its required peers [giftSettings]
    """

  @update_quantity
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
    Then I see property value 10 is present in the response property "data.quantity"

  @update_negative_quantity
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
    Then I see following value for property "message" :
    """
    "quantity" must be greater than -1
    """

  @update_frequency_and_frequencyType_weekly
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

  @update_frequency_and_frequencyType_Daily
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
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Daily" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" days
    Then I verify "data.nextShipDate" date updated is after "1" days

  @update_frequency_and_frequencyType_Monthly
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
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Monthly" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" months
    Then I verify "data.nextShipDate" date updated is after "1" months

  @update_frequency_and_frequencyType_Yearly
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
    Then I see property value 1 is present in the response property "data.frequency"
    Then I see property value "Yearly" is present in the response property "data.frequencyType"
    Then I verify "data.nextPaymentDate" date updated is after "1" years
    Then I verify "data.nextShipDate" date updated is after "1" years

  @update_nextPaymentDate
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
    Then I see property value "{SavedValue::increasedNextPaymentDate}" is contains in the response property "data.nextPaymentDate"
    Then I see property value "{SavedValue::increasedNextPaymentDate}" is contains in the response property "data.nextShipDate"

  @update_shipping_billing_details
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

  @update_tax
  Scenario: Update tax
    Given I have created active plan with multiple products
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
    Then I see property value 10 is present in the response property "data.tax"

  @swap_products_with_same_plan_product
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
    Then I see property value "---data:-:env_productItem2---" is present in the response property "data.itemID"

  @error_update_product_not_belong_to_same_plan
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
    Then I see following value for property "message" :
    """
    Provided item ID doesnot associate with the requested plan
    """

  @update_status_to_cancel
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
    Then I see property value "CANCEL" is present in the response property "data.status"

  @update_status_to_inactive
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
    Then I see property value "INACTIVE" is present in the response property "data.status"

  @update_status_from_inactive_to_active
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
    Then I see property value "ACTIVE" is present in the response property "data.status"

  @error_update_status
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
    Then I see following value for property "message" :
    """
      "status" must be one of [INACTIVE, ACTIVE, CANCEL]
    """

  @issue @skipNextSubscription
  # in the response of subscription api, expireDate is set on what basis?
  Scenario: Skip next delivery
    Given I have created active plan
    And I have create subscription endpoint
    And I have request payload for create ACTIVE subscription api
    And I run post call
    Then I verify ACTIVE subscription is created
    When I have saved property "data._id" as "subscriptionId"
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
    Then I see response code 200
    Then I see property value "{SavedValue::nextShipDate}" is present in the response property "data.skipDate"
    Then I see property value "{SavedValue::nextShipDate}" is contains in the response property "data.createdAt"
    Then I see property value "{SavedValue::nextShipDate}" is contains in the response property "data.updatedAt"
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
    Then I see response code 400
    Then I see following value for property "message" :
    """
      Invalid skip date
    """
