# Simulación de Pruebas de Rendimiento con Gatling, Maven y Scala

Este repositorio contiene una simulación de pruebas de rendimiento utilizando Gatling, 
Maven y Scala para la API "solicitud-recogida". La simulación representa una carga basica de usuarios que incluye el consumo al servicio para solicitar una recogida exitosa(cuando se cumple con fecha y parametros requeridos) y una fallida (Cuando no se cumple con fecha y los parametros requeridos).


## Requisitos

Asegúrate de tener instalados los siguientes componentes antes de ejecutar las pruebas:

- [Gatling](https://docs.gatling.io/reference/install/)
- [Maven](https://maven.apache.org/install.html)
- [Scala](https://www.scala-lang.org/download/)
- [Cucumber - Gherkin syntax](https://cucumber.io/docs/gherkin/reference/)



## Pasos de los Escenarios de pruebas

``` gherkin
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
```

## Configuración

La simulación está configurada para interactuar o en su defecto consumir la API "solicitud-recogida". Puedes ajustar la configuración según tus necesidades modificando el código en `SolicitudTestStimulation.scala`. En particular, presta atención a la configuración del protocolo HTTP y las acciones de la simulación.

```scala
val protocol = karateProtocol()

val solicitarRecogida: ScenarioBuilder = scenario("Solicitar recogida").exec(karateFeature("classpath:APITestSolicitudRecogida/PostSolicitudRecogidaAPI.feature"))
//.. en esta parte se configuran la cantidad de usuario que se necesitan para la prueba de performance y el tiempo 
setUp(solicitarRecogida.inject(rampUsers(30) during(60 seconds)).protocols(protocol))
```

## Instalación

Para instalar las dependencias y ejecutar las pruebas, sigue estos pasos:

1. Clona el repositorio:

```sh
git clone (repo)
```
2. instalar las dependencias

```sh
mvn clean install -U
```
3. Ejecutar tu Simulacion

```sh
mvn gatling:test -Dgatling.simulationClass=APITestSolicitudRecogida.SolicitudTestStimulation
```

4. Ejecución en gitHub - Actions
```sh
https://github.com/CristianHdezZ/Test-Load-Gatling-Coordinadora/actions/runs/8919780411
```



## Reporter
https://github.com/CristianHdezZ/Test-Load-Gatling-Coordinadora/actions/runs/8931792647/artifacts/1469006922

---


**Firma:** Cristian Hernandez Zabala 
