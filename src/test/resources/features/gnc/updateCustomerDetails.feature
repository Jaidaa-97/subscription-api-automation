Business Need: Update Customer details

  @Update_Customer_Details_from_Create_Bulk
  Scenario: Update the customer details from Bulk
    Given I have created 1 bulk subscription
    And I have saved property "data.subscriptions[0].customer.id" as "customerId"
    Given I have endpoint "/data-subscription/v1/customer/{SavedValue::customerId}"
    And I have following request payload :
    """
    {
          "firstName": "Customer3",
          "middleName": "Ram",
          "lastName": "Customer3",
           "contactNumber": "+91 8899223344"
    }
    """
    When I run put call
    Then I see response code 200

  @Update_Customer_Details_from_Create_Customer
  Scenario: Update the customer details from Customer
    Given I have endpoint "/data-subscription/v1/customer"
    And I have following request payload :
    """
    {
        "customerReferenceId": "606f01f441b8fc0000529916",
          "locale": "fr_CAB",
          "email": "customer1@mail.com",
          "contactNumber": "+92 3333709568",
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
    Then I see response code 200
    And I have saved property "data.id" as "customerId"
    Given I have endpoint "/data-subscription/v1/customer/{SavedValue::customerId}"
    And I have following request payload :
    """
    {
          "firstName": "Customer8",
          "middleName": "Rami",
          "lastName": "Customer3",
          "contactNumber": "+91 8899223344"
    }
    """
    When I run put call
    Then I see response code 200

    @Update_Subscription_customer_Details
    Scenario: Update Subscription customer Details
      Given I have created 1 bulk subscription
      And I have saved property "data.subscriptions[0].id" as "SubId"
      Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::SubId}"
      And I have following request payload :
      """
      {
          "shipTo": {
              "name": {
                  "firstName": "Customer",
                  "middleName": "Dilip",
                  "lastName": "Customer"
              },
              "streetAddress": {
                  "street1": "ABC Chauk",
                  "street2": "Balgandharv mandir"
              },
              "phone": {
                  "number": "1234567895",
                  "kind": "mobile"
              },
              "city": "Pune",
              "state": "MH",
              "postalCode": "411001",
              "country": "IN"
          }
      }
      """
      When I run patch call
      Then I see response code 200

    @Update-Customer-Email
      Scenario: Update customer email
        Given I have endpoint "/data-subscription/v1/customer"
        And I have following request payload :
        """
        {
            "customerReferenceId": "606f01f441b8fc0000529916",
              "locale": "fr_CAB",
              "email": "customer1@mail.com",
              "contactNumber": "+92 3333709568",
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
        Then I see response code 200
        And I have saved property "data.id" as "customerId"
        Given I have endpoint "/data-subscription/v1/customer/{SavedValue::customerId}"
        And I have following request payload :
        """
        {
          "email": "customer99@mail.com"
        }
        """
        When I run put call
        Then I see response code 200

    @Error_First&Last_Name
      Scenario: Error First&Last Name
      Given I have endpoint "/data-subscription/v1/customer"
      And I have following request payload :
      """
      {
        "customerReferenceId": "606f01f441b8fc0008529916",
          "locale": "fr_CAB",
          "email": "custom{RandomNumber::4}@gmail.com",
          "contactNumber": "+92 3333709568",
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
      Then I see response code 400

    @Get_Order_By_CustomerID
    Scenario: Get order by customerId
      Given I have created 1 bulk subscription
      And I have saved property "data.subscriptions[0].id" as "SubId"

    @Create_Orch
    Scenario: Create Orchrastration
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].id" as "subId"
      When I have saved property "data.subscriptions[0].customer.id" as "customerId"
      And I wait for 10 sec
      Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
      When I run get call api
      Then I see response code 200
      When I have saved property "data.orders[0].id" as "orderId"
      Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
      When I run get call api
      Then I see response code 200
      Then I see property value "SUBMITTED" is present in the response property "data.order.status"
      Given I have endpoint "/data-subscription/v1/orchestration/response"
      And I have following request payload :
      """
        [
            {
                "order": {
                    "code": "SUCCESS",
                    "orderId": "{SavedValue::orderId}"
                }
            }
        ]
      """
      When I run post call
      Then I see response code 200
  @Agent_login
  Scenario: Agent login Failed
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].id" as "subId"
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    When I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value "SUBMITTED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
      """
          [
              {
                  "order":{
                  "code": "ERROR",
                  "orderId": "{SavedValue::orderId}",
                  "errorCode": 999,
                  "errorMsg": "Agent login failed"
                  }
              }
          ]
      """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 0 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 1 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "RETRY" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/trigger-now"
    When I run get call api
    Then I see response code 200
    Then I see property value 2 is present in the response property "data.order.retry.retryCount"
    Given I have endpoint "/data-subscription/v1/orchestration/response"
    And I have following request payload :
    """
    [
        {
            "order":{
            "code": "ERROR",
           "orderId": "{SavedValue::orderId}",
            "errorCode":999,
            "errorMsg":"Agent login failed"
            }
        }

    ]
    """
    When I run post call
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data[0].status"
    Then validate schema "/gnc/orchestration.json"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "CANCELED" is present in the response property "data.order.status"
    Given I have endpoint "/data-subscription/v1/subscriptions/{SavedValue::subId}"
    When I run get call api
    Then I see response code 200
    Then I see property value "INACTIVE" is present in the response property "data.subscription.status"


    @add_Item_To_Order
    Scenario: Add item to order
      Given I have created 1 bulk subscription
      When I have saved property "data.subscriptions[0].customer.id" as "customerId"
      And I wait for 10 sec
      Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
      When I run get call api
      Then I see response code 200
      And I have saved property "data.orders[0].id" as "orderId"
      Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
      And I have following request payload :
    """
    {
    "lineItems": [
        {

            "item": {
                "sku": "VITAMIN-A",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }
    """
      When I run post call
      Then I see response code 200

  @remove_Item_To_Order
  Scenario: Add item to order
    Given I have created 1 bulk subscription
     When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/add-items"
    And I have following request payload :
    """
    {
    "lineItems": [
        {

            "item": {
                "sku": "VITAMIN-A",
                "quantity": 3,
                "weight": 10,
                "weightUnit": "lb",
                "itemPrice": {
                    "price": 100.00,
                    "currencyCode": "USD"
                },
                "tax": {
                    "taxCode": "FR020000",
                    "taxAmount": 10.00,
                    "currencyCode": "USD"
                }
            },
            "shipping": {
                "shipmentCarrier": "USPS",
                "shipmentMethod": "Ground",
                "shipmentInstructions": "",
                "taxCode": "SHP020000",
                "shippingAmount": 10.00,
                "taxAmount": 1.00,
                "currencyCode": "USD"
            },
            "customAttributes": {
                "storeId": "60cb07fc20387b000821c5c3",
                "associateId": 1,
                "trackingUrl": "609436d21baded0008945b05"
            }
        }
    ]
    }
    """
    When I run post call
    Then I see response code 200
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/remove-items"
    And I have following request payload :
    """
        {
        "lineItemIds": [0]
        }
        """
    When I run post call
    Then I see response code 200

    @Skip_Order
    Scenario: Skip Order
    Given I have created 1 bulk subscription
    When I have saved property "data.subscriptions[0].customer.id" as "customerId"
    And I wait for 10 sec
    Given I have endpoint "/data-subscription/v1/customers/{SavedValue::customerId}/orders?offset=t"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.orders[0].id" as "orderId"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::orderId}/skip"
    When I run put call
    Then I see response code 200
    Then I see property value "SKIPPED" is present in the response property "data.Order.status"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::newOrderID}"
    When I run get call api
    Then I see response code 200
    And I have saved property "data.nextScheduledOrders.newOrders[0]" as "newOrderID"
    Given I have endpoint "/data-subscription/v1/orders/{SavedValue::newOrderID}"
    When I run get call api
    Then I see response code 200
    Then I see property value "{Date::uuu-MM-dd:::M=1}" is contains in the response property "data.order.scheduledDate"