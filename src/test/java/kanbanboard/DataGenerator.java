package kanbanboard;

import com.github.javafaker.Faker;

import java.util.Locale;
import java.util.UUID;

public class DataGenerator {
    private static final String defaultLocale = "en-US";

    public static String uuid() {
        return UUID.randomUUID().toString();
    }

    public static int randomNumber() {
        return faker().number().numberBetween(1, 1000);
    }

    public static String randomName() {
        return faker().pokemon().name();
    }

    public static Faker faker() {
        return DataGenerator.faker(DataGenerator.defaultLocale);
    }

    public static Faker faker(String locale) {
        return new Faker(new Locale(locale));
    }
}