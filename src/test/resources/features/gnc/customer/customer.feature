@create_customer_v2 @v2
Business Need: Create Customer

  @create_customer @regression_ @non_enterprise
  Scenario: Create Customer has an invalid url
    Given I have endpoint "/data-subscription/v1/customer"
    And I have following request payload :
    """
      {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
        "locale": "fr_CAB",
        "email": "custom{RandomNumber::4}@gmail.com",
        "contactNumber": "913333709568",
        "firstName": "Customer1F",
        "lastName": "Customer1L",
        "middleName":"JJ",
        "segment": [ "employee"],
        "employeeId": "345",
        "communicationPreference":{
            "email":true,
            "SMS":true
        }
      }
    """
    When I run post call
    Then I see response code 403

  @create_customer @regression_ @non_enterprise
  Scenario: Create Customer
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
      {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
        "locale": "fr_CAB",
        "email": "custom{RandomNumber::4}@gmail.com",
        "contactNumber": "913333709568",
        "firstName": "Customer1F",
        "lastName": "Customer1L",
        "middleName":"JJ",
        "segment": [ "employee"],
        "employeeId": "345",
        "communicationPreference":{
            "email":true,
            "SMS":true
        }
      }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "custom" is contains in the response property "data.email"

  @get_customer @regression_
  Scenario: Get customer has an invalid url
    Given I have endpoint "/data-subscription/v1/customer?id=63735f3fb8a42900088635d6"
    When I run get call api
    Then I see response code 403

  @verify_locale_on_create_customer @regression_
  Scenario: Verify error response if we don't pass locale while creating customer
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "606f01f441b8fc0008529916"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "locale" is required
    """

  Scenario: Search for payment details by passing customer id
    Given I have endpoint "/data-subscription/v1/paymentmethods?customerId=63735f3fb8a42900088635d6"
    When I run get call api
    Then I see response code 200
    Then I see following value for property "message" :
    """
      Request processed successfully.
    """


  @verify_email_on_create_customer @regression_
  Scenario: Verify error response if we don't pass email while creating customer
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "fr_CAB"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "email" is required
    """

  @verify_first_name_on_create_customer @regression_
  Scenario: Verify error response if we don't pass firstName while creating customer
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "fr_CAB",
        "email": "custom{RandomNumber::4}@gmail.com"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "firstName" is required
    """
#
  @verify_last_name_on_create_customer @regression_
  Scenario: Verify error response if we don't pass lastName while creating customer
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "606f01f441b8fc0008529916",
        "locale": "fr_CAB",
        "email": "custom{RandomNumber::4}@gmail.com",
        "firstName": "John"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
    """
      "lastName" is required
    """
#
  @create_customer_without_optional_fields @regression_
  Scenario: Create customer without passing optional fields such as segment, employeeId, middleName, communicationPreference, contactNumber
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
        "locale": "fr_CAB",
        "email": "custom{RandomNumber::4}-{RandomNumber::4}@gmail.com",
        "firstName": "John",
        "lastName": "Pisal"
    }
    """
    When I run post call
    Then I see response code 200
    Then I see property value "custom" is contains in the response property "data.email"

  @verify_max_length_for_customer_refId @regression_
  Scenario: Verify max length error for customerReferenceId
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
      {
          "customerReferenceId": "606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916606f01f441b8fc0008529916",
          "locale": "fr_CAB",
          "email": "custom{RandomNumber::4}@gmail.com",
          "firstName": "John",
          "lastName": "Pisal"
      }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "customerReferenceId" length must be less than or equal to 50 characters long
      """

  @verify_max_length_first_name @regression_
  Scenario: Verify max length error message for firstName
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": "fr_CAB",
          "email": "custom{RandomNumber::4}@gmail.com",
          "contactNumber": "913333709568",
          "firstName": "JohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohn",
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "firstName" length must be less than or equal to 150 characters long
      """

  @verify_max_length_last_name @regression_
  Scenario: Verify max length error message for lastName
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": "fr_CAB",
          "email": "custom{RandomNumber::4}@gmail.com",
          "contactNumber": "913333709568",
          "lastName": "JohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohn",
          "firstName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "lastName" length must be less than or equal to 150 characters long
      """

  @verify_max_length_email @regression_
  Scenario: Verify max length error message for email
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": "fr_CAB",
          "email": "customercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomercustomer@gmail.com",
          "contactNumber": "913333709568",
          "lastName": "John",
          "firstName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "email" must be a valid email
      """

  @verify_max_length_phone @regression_
  Scenario: Verify max length error message for phone
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": "fr_CAB",
          "email": "omer@mail.com",
          "contactNumber": "91333370956833337095683333709568333370956833337095683333709568333370956833337095683333709568333370956833337095683333709568",
          "lastName": "John",
          "firstName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "contactNumber" length must be less than or equal to 15 characters long
      """

  @verify_max_length_segment @regression_
  Scenario: Verify max length error message for segment
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
        "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": "fr_CAB",
          "email": "cmer@mail.com",
          "contactNumber": "913333709568",
          "lastName": "John",
          "firstName": "Doe",
          "middleName":"JJ",
          "segment": [ "ewjer"],
          "employeeId": "employeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployeeemployee"
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "employeeId" length must be less than or equal to 50 characters long
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of customerReferenceId
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": 12,
          "locale": "fr_CAB",
          "email": "custom{RandomNumber::4}@gmail.com",
          "contactNumber": "913333709568",
          "firstName": "John",
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "customerReferenceId" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of locale
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "{RandomNumber::4}-{RandomNumber::4}-{RandomNumber::4}",
          "locale": 11,
          "email": "custom{RandomNumber::4}@gmail.com",
          "contactNumber": "913333709568",
          "firstName": "John",
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "locale" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of email
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": 21,
          "contactNumber": "913333709568",
          "firstName": "John",
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "email" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of contactNumber
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": 234234,
          "firstName": "John",
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "contactNumber" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of firstName
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": 12,
          "lastName": "Doe",
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "firstName" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of lastName
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": 32,
          "middleName":"JJ",
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "lastName" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of middleName
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": "sdasd",
          "middleName":12,
          "segment": [ "employee"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "middleName" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of segment
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": "sdasd",
          "middleName":"sdsdf",
          "segment": [1],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "segment[0]" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of employeeId
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": "sdasd",
          "middleName":"sdsdf",
          "segment": ["segment"],
          "employeeId": 345,
          "communicationPreference": {
            "SMS": true,
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "employeeId" must be a string
      """

  @data_error @regression_
  Scenario: verify schema error message for invalid data type of communicationPreference
    Given I have endpoint "/data-subscription/v1/customers"
    And I have following request payload :
    """
    {
          "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": "sdasd",
          "middleName":"sdsdf",
          "segment": ["segment"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": "a",
            "email":true
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "communicationPreference.SMS" must be a boolean
      """
    And I have following request payload :
    """
    {
        "customerReferenceId": "dzdc434345",
          "locale": "fr_fab",
          "email": "asda@gmail.com",
          "contactNumber": "234234",
          "firstName": "werwer",
          "lastName": "sdasd",
          "middleName":"sdsdf",
          "segment": ["segment"],
          "employeeId": "345",
          "communicationPreference": {
            "SMS": true,
            "email":"a"
        }
    }
    """
    When I run post call
    Then I see response code 400
    Then I see following value for property "message" :
      """
        "communicationPreference.email" must be a boolean
      """

