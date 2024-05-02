Feature: Post API Solicitud de Recogida distintos escenarios de pruebas

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def bodyRequestInput = read("requestSolicitudRecogida.json")
    * def currentDate = Java.type('java.time.LocalDate').now()
    * def futureDate = currentDate.plusDays(5)
    * print 'Fecha actual:', currentDate
    * print 'Fecha futura en 5 dias: ', futureDate
    * def dataFaker = Java.type("com.github.javafaker.Faker")
    * def dataFakerObject = new dataFaker()
    * def valueEmpty = ""


  @SolicitudRecogidaFechaValida
  Scenario: Solicitud de Recogida Exitosa, ingresando una fecha futura dentro de los 5 días hábiles siguientes
    Given request bodyRequestInput
    * set bodyRequestInput.fechaRecogida = ""+futureDate
    * set bodyRequestInput.documento = dataFakerObject.number().digits(10)
    * print 'Número aleatorio:', bodyRequestInput.documento
    When method post
    Then status 200
    * def expectedJson = { "isError": false,"data": { "id_recogida": { "idRecogida": "#ignore", "error": false, "message": "Solicitud recogida programada exitosamente"}},"timestamp": "#ignore","id": "#string"}
    And match response == expectedJson
    And print response

  @SolicitudRecogidaFechaInvalida
  Scenario: Solicitud de Recogida fallida, ingresando una fecha futura fuera de los 5 días hábiles siguientes
    Given request bodyRequestInput
    * set bodyRequestInput.fechaRecogida = ""+currentDate.plusDays(10)
    When method post
    Then status 200
    * def expectedJson = {"isError": true,"data": {"message": "#regex .*, no debe ser mayor a la fecha:.*","idRecogidaAnterior": "#regex .*, no debe ser mayor a la fecha.*","recogida_anterior": true},"timestamp": "#ignore","id": "#string"}
    And match response == expectedJson
    And print response
