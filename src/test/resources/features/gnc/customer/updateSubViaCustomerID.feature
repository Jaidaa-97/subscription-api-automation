@v2 @Update_Bulk_via_customerID
  Business Need: Update bulk via customer ID

    @update_shipping
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
                    "number": "+91 3333709512"
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


    @update_billing
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
                    "number": "+91 3333709512"
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
                    "number": "+91 3333709512"
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


