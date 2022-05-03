Business Need: Create Customer segment

  @728 @createEmployeeSegment @sanity
  Scenario: Create an employee customer segment
    Given I have endpoint "/segment"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
      {
        "segment":"employee"
      }
    """
    And I run post call
    Then I see response code 200
    Then I see employee customer segment is created.

  @728 @E2E
  Scenario: Create customer segment for GNC employee
    Given I have endpoint "/segment"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
      {
        "segment":"employee"
      }
    """
    And I run post call
    Then I see response code 200
    Then I see employee customer segment is created.
    When I created discount for this customer segment
    Then I see extra 10% discount is applied as this customer segment is created for GNC employee along with created discount.

  @728 @E2E
  Scenario: Remove an associated discount when they are no longer active employee.
    Given Customer is no longer GNC employee
    Given I have endpoint "/segment"
    And I have header "x-site-context"
    And I have header "Authorization"
    And I have following request payload :
    """
      {
        "segment":"employee"
      }
    """
    And I run post call
    Then I see response code 200
    Then I see employee customer segment is created.
    When I created discount for this customer segment
    Then I see no extra 10% discount is applied as this customer is no longer GNC employee
