@parabank_billpay
Feature: Payment failed due to insufficient funds

  Background:
    * url 'https://parabank.parasoft.com/parabank/services/bank'
    * header Accept = 'application/json'
    * def fromAccountId = 13122
    * def montoInsuficiente = 1000000

  Scenario: Payment failed due to insufficient funds
    Given path 'billpay'
    And param accountId = fromAccountId
    And param amount = montoInsuficiente
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
        "phoneNumber": "3333333333333",
        "accountNumber": "13344"
      }
      """
    When method post

    * print 'Status recibido:', responseStatus
    * print 'Respuesta recibida:', response
    * assert responseStatus == 400 || responseStatus == 422




