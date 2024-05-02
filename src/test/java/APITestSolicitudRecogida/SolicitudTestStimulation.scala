package APITestSolicitudRecogida

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.concurrent.duration._
import scala.language.postfixOps

class SolicitudTestStimulation extends Simulation {

  val protocol = karateProtocol()

  val solicitarRecogida: ScenarioBuilder = scenario("Solicitar recogida").exec(karateFeature("classpath:APITestSolicitudRecogida/PostSolicitudRecogidaAPI.feature"))

  setUp(solicitarRecogida.inject(rampUsers(1200) during(600 seconds)).protocols(protocol))

}
