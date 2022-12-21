@discount_filter
 Business Need: Filter discount

   Scenario: Search by passing discountType percentage
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?discountType=percentage"
     When I run get call api
     And I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     Then I see property value "percentage" is contains in the response property "data.discounts[0].discount"

   Scenario: Search by passing discountType amount
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?discountType=amount"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     Then I see property value "amount" is contains in the response property "data.discounts[0].discount"

   Scenario: Search by passing status INACTIVE
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?status=INACTIVE"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     Then I see property value "INACTIVE" is contains in the response property "data.discounts[0].status"

   Scenario: Search by passing status ACTIVE
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?status=ACTIVE"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     And I see property value "ACTIVE" is contains in the response property "data.discounts[0].status"

   Scenario: Search by passing the discountId
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?search=63393c2c4a3f7e00091b6aad"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     And I see property value "63393c2c4a3f7e00091b6aad" is contains in the response property "data.discounts[0].id"

   Scenario: Search by passing part of the discountId
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?search=63393c2"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     And I see property value "63393c2c4a3f7e00091b6aad" is contains in the response property "data.discounts[0].id"

   Scenario: Search by passing the offer code
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?search=63393c2c4a3f7e00091b6aad"
     When I run get call api
     Then I have saved property "data.discounts[0].offerCode" as "offerCode"
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?search={SavedValue::offerCode}"
     When I run get call api
     Then I see response code 200
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     And I see property value "{SavedValue::offerCode}" is contains in the response property "data.discounts[0].offerCode"

   Scenario: Search by passing part of offer code
     Given I have endpoint "/data-subscription/v1/subscriptionDiscounts?search=6426"
     When I run get call api
     Then I see response code 200
     Then I have saved property "data.discounts[0].offerCode" as "offerCode"
     Then I see following value for property "message" :
      """
        Request processed successfully.
      """
     And I see property value "{SavedValue::offerCode}" is contains in the response property "data.discounts[0].offerCode"

