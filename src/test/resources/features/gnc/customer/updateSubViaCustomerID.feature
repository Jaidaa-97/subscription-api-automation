@v2 @Update_Bulk_via_customerID
  Business Need: Update bulk via customer ID

    @update_shipping @regression_
    Scenario: update shipping
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].customer.id" as "customerId"
      Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/subscriptions"
      And I have following request payload :
      """
         {
          "shipTo": {
                "name": {
                    "firstName": "customers",
                    "middleName": "Dilip",
                    "lastName": "customerl"
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
                "country": "US"
            }
        }
      """
      And I run patch call
      Then I see response code 200


    @update_billing @regression_
    Scenario: update billing
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].customer.id" as "customerId"
      Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/subscriptions"
      And I have following request payload :
      """
         {
          "billTo": {
                "name": {
                    "firstName": "customers",
                    "middleName": "Dilip",
                    "lastName": "customerl"
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
                "country": "US"
            }
        }
      """
      And I run patch call
      Then I see response code 200


    @update_invalid_customer
    Scenario: update invalid customer
      Given I have endpoint "/data-subscription/v1/customers/625cdcc328b33700090799rt/subscriptions"
      And I have following request payload :
      """
         {
          "billTo": {
                "name": {
                    "firstName": "customers",
                    "middleName": "Dilip",
                    "lastName": "customerl"
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
                "country": "US"
            }
        }
      """
      And I run patch call
      Then I see response code 400
      Then I see following value for property "message" :
      """
        Customer id required.
      """

