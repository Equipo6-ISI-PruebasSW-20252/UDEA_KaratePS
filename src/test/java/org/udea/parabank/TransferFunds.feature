@parabank_transfer
Feature: Transfer funds in Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def val_fromAccountId = '54321'
    * def val_toAccountId = '15675'
    * def fakerObj = new faker()
    * def val_amount = fakerObj.number().numberBetween(1, 200)
    
  Scenario: Successful Transfer
    Given path 'transfer'
    And param fromAccountId = val_fromAccountId
    And param toAccountId = val_toAccountId
    And param amount = val_amount
    When method POST
    Then status 200
    
  
