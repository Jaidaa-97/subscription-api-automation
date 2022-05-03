Business Need: Create/Get cancellation reason

  # Create cancellation reason

  @SUB-748
  Scenario: Create cancellation reason
    Given I have endpoint "/data-subscription/cancelation-reasons"
    And I have following request payload :
    """
          {
              "code" : {RandomNumber::number},
              "reason": "cancellation reason"
          }
    """
    And I run post call
    Then I see response code 200
    Then I see property value "Got similar products for cheaper" is contains in the response property "data.cancellationReasons[0]"

  @SUB-748
  Scenario: Create bulk cancellation reason
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "Got similar products for cheaper",
           "code": 12
         },
         {
           "reason": "Product is too expensive",
           "code": 13
         }
        ]
    """
    And I run post call
    Then I see response code 200
    Then I should able to create more than 1 cancellation reasons

  @SUB-748
  Scenario: Partial creation of cancellation reason if one of the cancellation reason is already created
    Given I have cancellation reason created with code 12
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "Got similar products for cheaper",
           "code": 12
         },
         {
           "reason": "Product is too expensive",
           "code": 13
         }
        ]
    """
    And I run post call
    Then I see response code 200
    Then I should able to create cancellation reasons for code 13 and resonse should throw error message saying that the code 12 is already created

  @SUB-748
  Scenario: Error message duplicate cancellation code
    Given I have endpoint "/data-subscription/cancelation-reasons"
    And I have created x-site-context header and saved it into "context"
    And I have created Authorization token and saved it into "access_token"
    And set header "x-site-context={SavedValue::context}"
    And set header "Authorization={SavedValue::access_token}"
    And request payload :
    """
        [
         {
           "reason": "Got similar products for cheaper",
           "code": 12
         }
        ]
    """
    And I run post call
    And run post call
    Then I see response code 400
    #Then I should see duplicate cancellation code error message

  @SUB-748
  Scenario: Verify cancellation code should not be more than 2 digits
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "Got similar products for cheaper",
           "code": 123
         }
        ]
    """
    And I run post call
    Then I see response code 400
    Then I should see error message saying that the cancellation code can not be more than 2 digits

  @SUB-748
  Scenario: Verify cancellation code should not be in other than integer
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "Got similar products for cheaper",
           "code": "123"
         }
        ]
    """
    And I run post call
    Then I see response code 400
    Then I should see error message saying that the code must be in integer, string is not allowed.

  @SUB-748
  Scenario: Verify error message if cancellation code or cancellation reason is not passed
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "code": 1
         },
         {
           "reason": "product quality is not good"
         }
        ]
    """
    And I run post call
    Then I see response code 400
    Then I should see error message saying that the cancellation code/reason is required

  @SUB-748
  Scenario: Create default cancellation reason for GNC
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "This product is too expensive.",
           "code": 12
         },
         {
           "reason": "This product is different from what I ordered.",
           "code": 13
         },
         {
           "reason": "This product is out of stock.",
           "code": 14
         },
         {
           "reason": "I did not intend to join a subscription program.",
           "code": 15
         },
         {
           "reason": "I did not receive my order as expected.",
           "code": 16
         },
         {
           "reason": " I have too many of this product.",
           "code": 17
         },
         {
           "reason": "Other - (Please provide feedback)",
           "code": 18
         }
        ]
    """
    And I run post call
    Then I see response code 200
    Then I should able to create cancellation reason

  @SUB-748
  Scenario: Create cancellation reason in french
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": "Vous avez des produits similaires pour moins cher",
           "code": 12
         }
        ]
    """
    And I run post call
    Then I see response code 200
    Then I should be able to create a cancellation reason in french

  @SUB-748
  Scenario: Verify error message if cancellation reason is more that 64 characters
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
        [
         {
           "reason": " Vous avez des produits similaires pour moins cher Vous avez des produits similaires pour moins cher Vous avez des produits similaires pour moins cher Vous avez des produits similaires pour moins cher Vous avez des produits similaires pour moins cher vVous avez des produits similaires pour moins cher",
           "code": 12
         }
        ]
    """
    And I run post call
    Then I see response code 400
    Then I should be able see error response saying that the cancellation reason can not be more that 64 characters.

    # Get cancellation reason

  @SUB-749
  Scenario: Get cancellation reason
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 200
    Then I see following response :
    """
      {
        "responseStatus": "OK",
        "message": "Request processed successfully.",
        "data": {
            "cancellationReasons": [
              {
                "code": "12",
                "reason": "Got similar products for cheaper"
              }
            ]
        }
      }
    """

  @SUB-749
  Scenario: Get cancellation reason with 0 cancellation reason
    Given I have endpoint "/cancellation-reasons"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I run get call api
    Then I see response code 200
    Then I see following response :
    """
      {
        "responseStatus": "OK",
        "message": "Request processed successfully.",
        "data": {
            "cancellationReasons": []
        }
      }
    """


