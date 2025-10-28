@parabank_accounts
Feature: List all accounts of a user

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def user_id = '12212'

  Scenario: Succesful List of Accounts
    Given path 'customers'
    And path user_id
    And path 'accounts'
    When method GET
    Then status 200
    And match response ==
    """
    {
      "accounts": '#[0]',
    }
    """
    And match each response.accounts ==
    """
    {
      "id": '#number',
      "customerId": '#number',
      "type": '#string',
      "balance": '#string'
    }
    """


