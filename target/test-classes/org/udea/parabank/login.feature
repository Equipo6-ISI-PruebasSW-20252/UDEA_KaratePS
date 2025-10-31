@parabank_login
Feature: Login to Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Customer Login
    Given path 'login'
    And path 'john' //userName
    And path 'demo' //password
    When method GET
    Then status 200
    And match response ==
    """
    {
       "id": '#number',
       "firstName": '#string',
       "lastName": '#string',
       "address": {
            "street": '#string',
            "city": '#string',
            "state": '#string',
            "zipCode": '#string'
        },
       "phoneNumber": '#string',
       "ssn": '#string'
    }
    """

# Validar que el header CF-RAY exista y no sea nulo (Criterio de aceptación #3)
* def cfRay = responseHeaders['CF-RAY'][0]
    And match cfRay != null
    * print 'Login successful. CF-RAY header:', cfRay
