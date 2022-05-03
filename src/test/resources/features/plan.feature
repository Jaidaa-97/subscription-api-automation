@plan @regression @wip
Business Need: Create Plan

  Background:
    Given Delete subscriptions
    Given Delete plans

  @create_plan @sanity
  Scenario: Create Plan
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE

  @plan_status_draft
  Scenario: Create a Plan with status as DRAFT
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT

  @duplicate_frequency
  Scenario: Verify that Plan should not be created with frequency(e.g 1 weekly) if added product is already a part of another plan with same frequency(e.g 1 weekly)
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    And I have copied planId
    When I run the create plan api again
    Then I see that error message is showing while creating plan with product which already part of another plan

  @shipping_cost
  Scenario: Verify shipping cost can not be less than 0
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated shipping cost to -1
    When I run the create plan api
    Then I see error message for shipping cost which can not be less than 0

  @plan_status_other_than_active_or_draft
  Scenario: Verify that if the status of the plan is set to SCHEDULED or anything other than DRAFT or ACTIVE then the Plan should not be allowed to create.
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "SCHEDULED"
    When I run the create plan api
    Then I see error message if try to create a plan with status other than active or draft

  @invalid_plan_attribute
  Scenario: Verify error response if the attribute's title is entered as Some random string which is not present or created before.
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have added new attributes in payload
    When I run the create plan api
    Then I see error message for invalid plan attribute

  @invalid_plan_frequency
  Scenario: Verify error message if frequency is set to 0 or negative
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan frequency to -1
    When I run the create plan api
    Then I see error message for invalid plan frequency
    And I have updated plan frequency to 0
    When I run the create plan api
    Then I see error message for invalid plan frequency

  @invalid_plan_discount
  Scenario: Verify error message if discount is set to negative value
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan discount to -1
    When I run the create plan api
    Then I see error message for invalid plan discount

  @plan_title_greater_than_60_char
  Scenario: Verify error message if plan name is greater than 6o char
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan title to "plan name greater that 60 chars plan name greater that 60 chars plan name greater that 60 chars plan name greater that 60 chars plan name greater that 60 chars plan name greater that 60 chars"
    When I run the create plan api
    Then I see error message for plan title with greater that 60 characters

  @plan_description_greater_than_2000_char
  Scenario: Verify error message if plan name is greater than 6o char
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan description to "SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES v SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES SUB-595 - INCORRECT SCHEDULE DATES"
    When I run the create plan api
    Then I see error message for plan description with greater that 2000 characters

  @response_without_title
  Scenario: Verify error message if try to create a plan without title
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "title" from payload
    When I run the create plan api
    Then I see error message for missing property title

  @response_without_description
  Scenario: Verify error message if try to create a plan without description
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "description" from payload
    When I run the create plan api
    Then I see error message for missing property description

  @response_without_frequency
  Scenario: Verify error message if try to create a plan without frequency
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "frequency" from payload
    When I run the create plan api
    Then I see error message for missing property frequency

  @response_without_frequencyType
  Scenario: Verify error message if try to create a plan without frequencyType
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "frequencyType" from payload
    When I run the create plan api
    Then I see error message for missing property frequencyType

  @response_without_products
  Scenario: Verify error message if try to create a plan without products
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "products" from payload
    When I run the create plan api
    Then I see error message for missing property products

  @response_without_status
  Scenario: Verify error message if try to create a plan without status
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have removed "status" from payload
    When I run the create plan api
    Then I see error message for missing property status

    ############################################## Update Plan #################################################################

  @update_plan_new_product @sanity
  Scenario: Update plan with new product
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    When I have updated product in update plan api
    And I run the update plan api
    Then I see that the plan gets updated with new product

  @add_new_frequency_in_plan @sanity
  Scenario: Create Plan
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload to add new frequency plan api
    And I run the update plan api
    Then I see property value 1 is present in the response property "data.plans[1].frequency"
    Then I see property value "Monthly" is present in the response property "data.plans[1].frequencyType"
    Then I see property value "---data:-:env_productItem1---" is present in the response property "data.plans[1].products[0].itemId"

  @update_all_properties @sanity
  Scenario: Update title,description,shippingCost,frequency,discount and frequencyType of plan
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I run the update plan api
    Then I see that the title gets updated to "Updated Plan Name"
    Then I see that the description gets updated to "Updated plan description"
    Then I see that the shippingCost gets updated to "10"
    Then I see that the frequency gets updated to "2"
    Then I see that the discount gets updated to "30"
    Then I see that the frequencyType gets updated to "Monthly"

  @can_not_change_status_draft_from_active
  Scenario: Update plan status from Active to Draft and verify that the Active plan can not be moved to Draft
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "DRAFT" in update plan payload
    And I run the update plan api
    Then I see invalid plan status response

  @update_status_from_active_to_archived_vice_versa
  Scenario: Update plan status from Active to Archived and vice versa
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "ARCHIVED" in update plan payload
    And I run the update plan api
    Then I see property value "ARCHIVED" is present in the response property "data.plans[0].status"
    #Then I see plan status updated to ARCHIVED
    And I have updated plan status to "ACTIVE" in update plan payload
    And I run the update plan api
    Then I see property value "ACTIVE" is present in the response property "data.plans[0].status"
    #Then I see plan status updated to ACTIVE

  @change_plan_status_from_draft_to_active
  Scenario: Update plan status from Draft to Active
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "ACTIVE" in update plan payload
    And I run the update plan api
    Then I see property value "ACTIVE" is present in the response property "data.plans[0].status"
    #Then I see plan status updated to ACTIVE

  @error_plan_status_from_draft_to_archived
  Scenario: Plan status from DRAFT to ARCHIVED can not be change
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "ARCHIVED" in update plan payload
    And I run the update plan api
    Then I see invalid plan status response

  @error_plan_status_from_draft_to_deleted
  Scenario: Plan status from DRAFT to DELETED can not be change
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "DELETED" in update plan payload
    And I run the update plan api
    Then I see invalid plan status response for DELETED

  @error_response_status_change_to_deleted
  Scenario: Verify that the plan status can not be allowed to change to DELETED
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "DELETED" in update plan payload
    And I run the update plan api
    Then I see invalid plan status response for DELETED

  ######################### GET API ####################################
  @plan_count @sanity
  Scenario: Get all the plans based on status
    Given I have get plan count endpoint
    And I have access token
    When I run get call api
    Then I verify the plan status count

  @get_plan_v3 @sanity
  Scenario: Get all the plans using v3 api
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan v3 endpoint
    When I run get call api
    Then I see property value "Automation Subscription Plan" is present in the response property "data.docs[0].Plan.title"

  @get_plan_based_on_pageSize
  Scenario: Get all the plans with particular pageSize
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan v3 endpoint
    When I run get call api with following param:
      | pageSize | pageNumber |
      | 10       | 1          |
    Then I see only 10 plans on page number 1

  @get_active_plan
  Scenario: Get all the plans with Status ACTIVE
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan v3 endpoint
    When I run get call api with following param:
      | pageSize | pageNumber | status |
      | 10       | 1          | ACTIVE |
    Then I see only "ACTIVE" plans in response

  @get_plans_created_today
  Scenario: Get all the plans created today
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan v3 endpoint
    When I run get call api with following param:
      | pageSize | pageNumber | days |
      | 10       | 1          | 1    |
    Then I see property value "Automation Subscription Plan" is present in the response property "data.docs[0].Plan.title"

  @get_inactive_plan
  Scenario: Get all the plans with Status INACTIVE
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | status   |
      | 10       | 1          | INACTIVE |
    Then I see only "INACTIVE" plans in response

  @get_archive_plan
  Scenario: Get all the plans with Status ARCHIVE
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | status  |
      | 10       | 1          | ARCHIVE |
    Then I see only "ARCHIVE" plans in response

  @get_plan_by_itemid @no_plans_invalid_itemId @sanity
  Scenario: Get all the plans contains the particular Product using itemId(product id)
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    And I have get by itemid endpoint
    And I have request payload for get by itemid endpoint as key "productItem1" from data property
    When I run post call
    Then I verify response of getByItemId plans
    And I have request payload for get by itemid endpoint as key "invalidProductId" from data property
    When I run post call
    Then I verify empty response of getByItemId plans

  @get_plans_created_from_last_week
  Scenario: Get all the plans created in last 7 days
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days |
      | 10       | 1          | 7    |
    Then I verify that plans are showing only for last 7 days

  @get_plans_created_from_last_1month
  Scenario: Get all the plans created in last 1 month
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days |
      | 10       | 1          | 30   |
    Then I verify that plans are showing only for last 30 days

  @get_active_plan_last_1month
  Scenario: Get all the active plans created in last 1 month
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 30   | ACTIVE |
    Then I see only "ACTIVE" plans in response
    Then I verify that plans are showing only for last 30 days

  @get_archived_plan_last_1month
  Scenario: Get all the archived plans created in last 1 month
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status   |
      | 10       | 1          | 30   | ARCHIVED |
    Then I see only "ARCHIVED" plans in response
    Then I verify that plans are showing only for last 30 days

  @get_draft_plan_last_1month
  Scenario: Get all the draft plans created in last 1 month
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 30   | DRAFT  |
    Then I see only "DRAFT" plans in response
    Then I verify that plans are showing only for last 30 days

  @get_active_plan_last_7_days
  Scenario: Get all the active plans created in last 7 days
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 7    | ACTIVE |
    Then I see only "ACTIVE" plans in response
    Then I verify that plans are showing only for last 7 days

  @get_archived_plan_last_7_days
  Scenario: Get all the archived plans created in last 7 days
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status   |
      | 10       | 1          | 7    | ARCHIVED |
    Then I see only "ARCHIVED" plans in response
    Then I verify that plans are showing only for last 7 days

  @get_draft_plan_last_7_days
  Scenario: Get all the draft plans created in last 7 days
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 7    | DRAFT  |
    Then I see only "DRAFT" plans in response
    Then I verify that plans are showing only for last 7 days

  @get_draft_plan_created_today
  Scenario: Get all the draft plans created today
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    And I have updated plan status to "DRAFT"
    When I run the create plan api
    Then I see that the plan is created with status DRAFT
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 1    | DRAFT  |
    Then I see only "DRAFT" plans in response
    Then I verify that plans are showing only for last 1 days

  @get_active_plan_created_today
  Scenario: Get all the active plans created today
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status |
      | 10       | 1          | 1    | ACTIVE |
    Then I see only "ACTIVE" plans in response
    Then I verify that plans are showing only for last 1 days

  @get_archived_plan_created_today
  Scenario: Get all the archived plans created today
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    When I have update plan endpoint
    And I have request payload for update plan api
    And I have updated plan status to "ARCHIVED" in update plan payload
    And I run the update plan api
    Given I have get plan v3 endpoint
    And I have access token
    When I run get call api with following param:
      | pageSize | pageNumber | days | status   |
      | 10       | 1          | 1    | ARCHIVED |
    Then I see only "ARCHIVED" plans in response
    Then I verify that plans are showing only for last 1 days

  @get_plan_by_id @sanity
  Scenario: Get the individual plan using it's id
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan by id endpoint
    When I run get call api
    Then I see property value "Automation Subscription Plan" is present in the response property "data.plan.title"

  @invalid_plan_id
  Scenario: Verify error message if incorrect plan id is passed
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan by id endpoint
    And I have added incorrect plan id in the endpoint
    When I run get call api
    Then I see error message "Invalid Plan ID. Please provide the valid one!"

  @get_plan_by_groupId @sanity
  Scenario: Get the individual plan using it's group id
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan by groupId endpoint
    When I run get call api
    Then I see property value "Automation Subscription Plan" is present in the response property "data.plan.Plan.title"

  @invalid_plan_groupId
  Scenario: Verify error message if incorrect plan group id is passed
    Given I have create plan endpoint
    And I have access token
    And I have request payload for create plan api
    When I run the create plan api
    Then I see that the plan is created with status ACTIVE
    Given I have get plan by groupId endpoint
    And I have added incorrect group id in the endpoint
    When I run get call api
    Then I see error message "Plan not found."

