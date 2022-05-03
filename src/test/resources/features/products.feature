@products @regression @wip
Business Need: Get all Products

  @get_products_v2
  Scenario: Get all v2 products
    Given I have endpoint "/data-subscription/products/v2?limit=15&offset=15"
    When I run get call api
    Then validate schema "getProducts.json"
    Then I see response code 200
    Given I have endpoint "/data-subscription/products/v2?limit=15&offset=30"
    When I run get call api
    Then validate schema "getProducts.json"
    Then I see response code 200

  @get_products_v2_firstPage @sanity @wip
  Scenario: Get all v2 products
    Given I have endpoint "/data-subscription/products/v2?limit=15&offset=0"
    When I run get call api
    Then validate schema "getProducts.json"
    Then I see response code 200