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
    # Validar estructura de respuesta y autenticación exitosa
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
    # Validar que el ID del usuario existe (indica autenticación exitosa)
    * assert response.id > 0
    # Validar que el header CF-RAY exista y no sea nulo (validación adicional)
    * def cfRay = responseHeaders['CF-RAY'][0]
    And match cfRay != null
    * print 'Login successful. User ID:', response.id, 'CF-RAY header:', cfRay
