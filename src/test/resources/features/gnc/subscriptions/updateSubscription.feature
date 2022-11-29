@subscription_v2 @v2
Business Need: Update Subscription

  @update_subscription @regression_
  Scenario: Update customer details, shipping and billing address, payment details by updating subscription and verify
  that the orders also gets updated
    # Create subscription
    Given I have created bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId1"
    And I have saved property "data.subscriptions[1].id" as "subId2"
#    When I have saved static property "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}" as "customerReferenceId"
    When I have saved static property "custom{RandomNumber::4}-{RandomNumber::4}@gmail.com" as "email"
    And I wait for 10 sec
    # Update customer details
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    And I have following request payload :
          """
                {
                  "item":{},
                    "customer": {
                      "locale": "en_US",
                      "email": "{SavedValue::email}",
                      "contactNumber": "91574594335",
                      "firstName": "James",
                      "middleName": "Patric",
                      "lastName": "Pics",
                      "segment": ["employee1"],
                      "employeeId": "123482y73"
                  }
              }
          """
    When I run patch call
    Then I see response code 200
    # Verify if customer gets updated or not
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    Then I see property value "employee1" is present in the response property "data.subscription.customer.segment[0]"
    Then I see property value "en_US" is present in the response property "data.subscription.customer.locale"
    Then I see property value "{SavedValue::email}" is present in the response property "data.subscription.customer.email"
    Then I see property value "91574594335" is present in the response property "data.subscription.customer.contactNumber"
    Then I see property value "James" is present in the response property "data.subscription.customer.firstName"
    Then I see property value "Pics" is present in the response property "data.subscription.customer.lastName"
    Then I see property value "123482y73" is present in the response property "data.subscription.customer.employeeId"
    Then I see property value "Patric" is present in the response property "data.subscription.customer.middleName"
    #Update Shipping and billing address
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    And I have following request payload :
          """
                {
                  "item":{},
                  "shipTo": {
                      "name": {
                      "firstName": "Jitendra",
                      "middleName": "Dilip",
                      "lastName": "Pisal"
                      },
                      "streetAddress": {
                          "street1": "kOREGAON PARK",
                          "street2": "Hindu sena marg"
                      },
                      "phone": {
                          "number": "913333709512"
                      },
                      "city": "Pune",
                      "state": "MH",
                      "postalCode": "411001",
                      "country": "IN"
                  },
                  "billTo": {
                      "name": {
                      "firstName": "Jitendra",
                      "middleName": "Dilip",
                      "lastName": "Pisal"
                  },
                  "streetAddress": {
                      "street1": "kOREGAON PARK",
                      "street2": "Hindu sena marg"
                  },
                  "phone": {
                      "number": "913333709512"
                  },
                  "city": "Pune",
                  "state": "MH",
                  "postalCode": "411001",
                  "country": "IN"
                  },
                  "paymentDetails": {
                    "paymentIdentifier": {
                        "cardIdentifier": "5674",
                        "expiryDate": "04/25"
                    },
                    "paymentMethod": "rupay",
                    "paymentKind": "CARD_PAYPAL"
                  }
                }
          """
    When I run patch call
    Then I see response code 200
    # Verify if shipping and billing address gets updated or not
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.subscription.customer.id" as "customerId"
    And I see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.billTo.city"
    And I see property value "MH" is present in the response property "data.subscription.billTo.state"
    And I see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
    And I see property value "IN" is present in the response property "data.subscription.billTo.country"
    # validate shipTo details
    And I see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.subscription.shipTo.city"
    And I see property value "MH" is present in the response property "data.subscription.shipTo.state"
    And I see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
    And I see property value "IN" is present in the response property "data.subscription.shipTo.country"
    # Validate if payment details gets updated or not
    And I see property value "5674" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "04/25" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
    # Validate other subscription details should not get updated
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId2}"
    When I run get call api
    Then I see response code 200
    And I do not see property value "Jitendra" is present in the response property "data.subscription.billTo.name.firstName"
    And I do not see property value "Dilip" is present in the response property "data.subscription.billTo.name.middleName"
    And I do not see property value "Pisal" is present in the response property "data.subscription.billTo.name.lastName"
    And I do not see property value "kOREGAON PARK" is present in the response property "data.subscription.billTo.streetAddress.street1"
    And I do not see property value "Hindu sena marg" is present in the response property "data.subscription.billTo.streetAddress.street2"
    And I do not see property value "Pune" is present in the response property "data.subscription.billTo.city"
    And I do not see property value "MH" is present in the response property "data.subscription.billTo.state"
    And I do not see property value "411001" is present in the response property "data.subscription.billTo.postalCode"
    And I do not see property value "IN" is present in the response property "data.subscription.billTo.country"
    #validate shipTo
    And I do not see property value "Jitendra" is present in the response property "data.subscription.shipTo.name.firstName"
    And I do not see property value "Dilip" is present in the response property "data.subscription.shipTo.name.middleName"
    And I do not see property value "Pisal" is present in the response property "data.subscription.shipTo.name.lastName"
    And I do not see property value "kOREGAON PARK" is present in the response property "data.subscription.shipTo.streetAddress.street1"
    And I do not see property value "Hindu sena marg" is present in the response property "data.subscription.shipTo.streetAddress.street2"
    And I do not see property value "Pune" is present in the response property "data.subscription.shipTo.city"
    And I do not see property value "MH" is present in the response property "data.subscription.shipTo.state"
    And I do not see property value "411001" is present in the response property "data.subscription.shipTo.postalCode"
    And I do not see property value "IN" is present in the response property "data.subscription.shipTo.country"
    # Verify paymentDetails should not be updated in another subscription
    And I do not see property value "5674" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.cardIdentifier"
    And I do not see property value "04/25" is present in the response property "data.subscription.paymentDetails.paymentIdentifier.expiryDate"
    And I do not see property value "rupay" is present in the response property "data.subscription.paymentDetails.paymentMethod"
    # Get order id from get orders by customer id api
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders"
    When I run get call api
    Then I see response code 200
    And I get the index of order for subscription "{SavedValue::subId1}" as "index1"
    And I get the index of order for subscription "{SavedValue::subId2}" as "index2"
    And I get the order id of subscription at index "{SavedValue::index1}" and saved it as "orderId1"
    And I get the order id of subscription at index "{SavedValue::index2}" and saved it as "orderId2"
    # Verify order 1 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId1}"
    And I run get call api
    Then I see response code 200
    And I see property value "Jitendra" is present in the response property "data.order.billTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.billTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.billTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.billTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.billTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.billTo.city"
    And I see property value "MH" is present in the response property "data.order.billTo.state"
    And I see property value "411001" is present in the response property "data.order.billTo.postalCode"
    And I see property value "IN" is present in the response property "data.order.billTo.country"
    # verify shipTo gets updated on order
    And I see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I see property value "MH" is present in the response property "data.order.shipTo.state"
    And I see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I see property value "IN" is present in the response property "data.order.shipTo.country"
    # Verify payment details gets updated in Order
    And I see property value "5674" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
    And I see property value "04/25" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
    And I see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"
    # Verify Order 2 gets updated or not
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId2}"
    And I run get call api
    Then I see response code 200
    And I do not see property value "Jitendra" is present in the response property "data.order.billTo.name.firstName"
    And I do not see property value "Dilip" is present in the response property "data.order.billTo.name.middleName"
    And I do not see property value "Pisal" is present in the response property "data.order.billTo.name.lastName"
    And I do not see property value "kOREGAON PARK" is present in the response property "data.order.billTo.streetAddress.street1"
    And I do not see property value "Hindu sena marg" is present in the response property "data.order.billTo.streetAddress.street2"
    And I do not see property value "Pune" is present in the response property "data.order.billTo.city"
    And I do not see property value "MH" is present in the response property "data.order.billTo.state"
    And I do not see property value "411001" is present in the response property "data.order.billTo.postalCode"
    And I do not see property value "IN" is present in the response property "data.order.billTo.country"
    And I do not see property value "Jitendra" is present in the response property "data.order.shipTo.name.firstName"
    And I do not see property value "Dilip" is present in the response property "data.order.shipTo.name.middleName"
    And I do not see property value "Pisal" is present in the response property "data.order.shipTo.name.lastName"
    And I do not see property value "kOREGAON PARK" is present in the response property "data.order.shipTo.streetAddress.street1"
    And I do not see property value "Hindu sena marg" is present in the response property "data.order.shipTo.streetAddress.street2"
    And I do not see property value "Pune" is present in the response property "data.order.shipTo.city"
    And I do not see property value "MH" is present in the response property "data.order.shipTo.state"
    And I do not see property value "411001" is present in the response property "data.order.shipTo.postalCode"
    And I do not see property value "IN" is present in the response property "data.order.shipTo.country"
    # Verify payment details should not get updated in Order 2
    And I do not see property value "5674" is present in the response property "data.order.paymentDetails.paymentIdentifier.cardIdentifier"
    And I do not see property value "04/25" is present in the response property "data.order.paymentDetails.paymentIdentifier.expiryDate"
    And I do not see property value "rupay" is present in the response property "data.order.paymentDetails.paymentMethod"

  @update_sku @regression_
  Scenario: Swap the product in subscription with another product which is present in the list of swappable
    Given I have created bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId1"
    And I have saved property "data.subscriptions[1].id" as "subId2"
      # Update sku
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    And I have following request payload :
          """
                {
                    "item":{
                        "sku":"---data:-:env_swapproduct---"
                    }
                }
          """
    When I run patch call
    Then I see response code 200
    And I see property value "---data:-:env_swapproduct---" is present in the response property "data.subscription.item.sku"

  @swap_incorrect_product @regression_
  Scenario: Product should not be swapped/updated in the subscription if the swapping product is not a part of swappable list of the product
    Given I have created bulk subscription
    And I have saved property "data.subscriptions[0].id" as "subId1"
    And I have saved property "data.subscriptions[1].id" as "subId2"
      # Update sku
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId1}"
    And I have following request payload :
          """
                {
                    "item":{
                        "sku":"---data:-:env_sku2---"
                    }
                }
          """
    When I run patch call
    Then I see response code 400
    And I see property value "---data:-:env_sku2--- is not a apart of the swappable SKU list of ---data:-:env_sku1---" is present in the response property "message"
