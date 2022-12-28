@v2 @update_customer
  Business Need: Update Customer


    @update_customer_details @regression_ @non_enterprise
    Scenario: Update Customer details
      Given I have created customer for gnc
      And I have saved property "data.id" as "customerID"
      Given I have endpoint "/data-subscription/v1/customer/{SavedValue::customerID}"
      And I have following request payload :
      """
          {
              "segment": [
                      "gymTrainer"
                  ]
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "gymTrainer" is present in the response property "data.segment[0]"
      # update customerReferenceID
      And I have following request payload :
      """
          {
            "customerReferenceId":"234nffg428a3kbe4"
          }
      """
      When I run put call
      Then I see response code 400
    # update locale
      And I have following request payload :
      """
          {
            "locale":"en_US"
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "en_US" is present in the response property "data.locale"
    # update email
      And I have following request payload :
      """
          {
            "email": "tempcustomer{RandomNumber::4}@mail.com"
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "tempcustomer" is contains in the response property "data.email"
    # update contact number
      And I have following request payload :
      """
          {
            "contactNumber": "+91 8899223344"
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "+91 8899223344" is present in the response property "data.contactNumber"
    # update employeeID
      And I have following request payload :
      """
          {
            "employeeId": "A123"
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "A123" is present in the response property "data.employeeId"
    # update fistName,lastName,middleName
      And I have following request payload :
      """
          {
            "firstName": "Shubham",
            "middleName": "Ram",
            "lastName": "Doe"
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "Shubham" is present in the response property "data.firstName"
      And I see property value "Ram" is present in the response property "data.middleName"
      And I see property value "Doe" is present in the response property "data.lastName"
     # update communicationPreference
      And I have following request payload :
      """
          {
            "communicationPreference": {
              "email":true
            }
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "true" is present in the response property "data.communicationPreference.email"
     # remove communicationPreference
      And I have following request payload :
      """
          {
            "communicationPreference": {

            }
          }
      """
      When I run put call
      Then I see response code 200
      And I see property value "null" is present in the response property "data.communicationPreference.email"
