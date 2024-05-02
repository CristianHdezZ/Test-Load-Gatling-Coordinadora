package APITestSolicitudRecogida

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration._

class SolicitudTestStimulation extends Simulation {

  val protocol = karateProtocol()

  val solictarRecogida = scenario("Solicitar recogida").exec(karateFeature("classpath:APITestSolicitudRecogida/PostSolicitudRecogidaAPI.feature"))

  setUp(solictarRecogida.inject(rampUsers(300) during(60 seconds)).protocols(protocol))

}
