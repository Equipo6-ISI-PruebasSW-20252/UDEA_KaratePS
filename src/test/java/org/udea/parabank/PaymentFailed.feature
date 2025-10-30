@parabank_billpay
Feature: Payment failed due to insufficient funds

  Background:
    * url 'https://parabank.parasoft.com/parabank/services/bank'
    * header Accept = 'application/json'
    * def fromAccountId = 12456
    * def montoInsuficiente = 1000000

  Scenario: Payment failed due to insufficient funds
    Given path 'billpay'
    And request
      """
      {
        "name": "Pago de prueba",
        "address": {
          "street": "direccion de prueba",
          "city": "Medellin",
          "state": "Antioquia",
          "zipCode": "5002"
        },
        "phoneNumber": "333333333",
        "accountNumber": "13344",
        "amount": #montoInsuficiente,
        "fromAccountId": #fromAccountId
      }
      """
    When method post
    * assert responseStatus == 400 || responseStatus == 422
    And match response contains /(?i)insufficient|fondos|saldo/
    * karate.log('Status:', responseStatus, 'Body:', response)





