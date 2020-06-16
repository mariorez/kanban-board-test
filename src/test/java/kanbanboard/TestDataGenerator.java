package kanbanboard;

import com.github.javafaker.Faker;

import java.util.Locale;
import java.util.UUID;

public class TestDataGenerator {
    private static final String defaultLocale = "en-US";

    public static String uuid() {
        return UUID.randomUUID().toString();
    }

    public static Faker faker() {
        return TestDataGenerator.faker(TestDataGenerator.defaultLocale);
    }

    public static Faker faker(String locale) {
        return new Faker(new Locale(locale));
    }
}