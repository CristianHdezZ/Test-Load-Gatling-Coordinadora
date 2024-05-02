package APITestSolicitudRecogida;

import com.intuit.karate.junit5.Karate;

public class RecogidaRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("PostSolicitudRecogidaAPI").relativeTo(getClass());
    }
}
