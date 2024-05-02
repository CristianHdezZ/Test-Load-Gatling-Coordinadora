import com.intuit.karate.junit5.Karate;

public class APItest {
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}
