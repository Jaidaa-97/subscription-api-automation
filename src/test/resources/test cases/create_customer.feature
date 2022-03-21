Business Need: Create/Update Customer

  Scenario: New subscription with a new customer email
  Given A customer checks out with a subscription product and the customer is new
  When the subscription is created in the subscription platform
  Then A new customer should also be created as part of this process

  Scenario: New subscription with old customer email
  Given An existing customer checks out with a subscription product
  When The subscription is created in the subscription platform
  Then The subscription should get added to the existing customer a new customer should not be created

    Scenario: Create customer 
      Given I have endpoint "/dev/v1/customer"
      And I have following request payload :
      """
          {
            "customerReferenceId": "606f01f441b8fc0008529916", // GNC customer id
              "locale": "en_US", // possible values: fr_ca, en_US
              "email": "customer@mail.com",
              "contactNumber": "+92 3333709568", // optional
              "firstName": "John",
              "lastName": "Doe",
              "middleName": "",  // optional
              "segment": [ "employee" ], //optional : possible values: proUser, regularUser
              "employeeId": 1 // optional

          }
      """
      When I run post call
      Then Customer should get created
      
      Scenario: Update customer details
        Given I have endpoint "/dev/v1/customer/622a0de7ae9e5129b8e796aa"
        And I have following request payload :
        """
              {
              "locale": "en_US", // possible values: fr_ca, en_US
              "email": "customer@mail.com",
              "contactNumber": "+92 3333709568", // optional
              "firstName": "John",
              "lastName": "Doe",
              "middleName": "",  // optional
              "segment": [ "employee" ], //optional : possible values: proUser, regularUser
              "employeeId": 1 // Ideally this should not be updated.

          }
        """
        When I run put call
        Then I see that the customer details get updated

