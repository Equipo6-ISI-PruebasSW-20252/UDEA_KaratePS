@parabank_accounts
Feature: List all accounts of a user

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fakerObj = new faker()
    * def user_id = '12212'
    * def random_user_id = fakerObj.number().randomNumber(5, true)

  Scenario: Succesful List of Accounts
    Given path 'customers'
    And path user_id
    And path 'accounts'
    When method GET
    Then status 200
    And match each response ==
    """
    {
      id: '#number',
      customerId: '#number',
      type: '#string',
      balance: '#number'
    }
    """
  Scenario: Non existent user
    Given path 'customers'
    And path random_user_id
    And path 'accounts'
    When method GET
    Then status 400
    And match response == "Could not find customer #" + random_user_id

