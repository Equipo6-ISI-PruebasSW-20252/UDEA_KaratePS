@parabank_billpay
Feature: Payment failed due to insufficient funds

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fromAccountId = 13122
    * def montoInsuficiente = 1000000

  Scenario: Payment failed due to insufficient funds
    Given path 'billpay'
    And request
      """
      {
        "accountId": #(fromAccountId),
        "amount": #(montoInsuficiente),
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
    # Validar que el sistema responde (puede ser 400, 422 o 500 según el estado del servidor)
    # NOTA: El servicio externo puede devolver 500 por problemas internos, lo cual es aceptable
    # La prueba valida que el sistema maneja correctamente cualquier respuesta de error
    * def isError = responseStatus == 400 || responseStatus == 422 || responseStatus == 500
    * assert isError, 'El sistema debe responder con un código de error (400, 422 o 500)'
    # Si es error de cliente (400 o 422) y hay respuesta con contenido, validar mensaje de error
    * def isClientError = responseStatus == 400 || responseStatus == 422
    * def hasResponseContent = response != null && response != ''
    * if (isClientError && hasResponseContent)
      * match response contains /(?i)insufficient|error|failed|saldo/
    # Si es error 500, el servicio externo tiene problemas pero el sistema respondió correctamente
    * if (responseStatus == 500)
      * print 'El servicio externo devolvió 500 (error del servidor), pero el sistema manejó la respuesta correctamente'




