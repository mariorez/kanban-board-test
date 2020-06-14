package kanbanboard.bucket;

import com.intuit.karate.junit5.Karate;

class BucketRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("bucket").relativeTo(getClass());
    }
}
