package com.example.idealslimming.model;

public final class UserInputValidator {

    private static final int MIN_AGE = 10;
    private static final int MAX_AGE = 100;
    private static final int MIN_RESTING_HEART_RATE = 40;
    private static final int MAX_RESTING_HEART_RATE = 120;
    private static final int MAX_HEART_RATE_BASE = 220;

    private UserInputValidator() {
    }

    public static void validate(int age, int restingHeartRate) {
        if (age < MIN_AGE || age > MAX_AGE) {
            throw new ValidationException(
                    "Возраст должен быть в диапазоне от " + MIN_AGE + " до " + MAX_AGE + " лет");
        }

        if (restingHeartRate < MIN_RESTING_HEART_RATE || restingHeartRate > MAX_RESTING_HEART_RATE) {
            throw new ValidationException(
                    "Пульс покоя должен быть в диапазоне от " + MIN_RESTING_HEART_RATE
                            + " до " + MAX_RESTING_HEART_RATE + " уд/мин");
        }

        int maxHeartRate = MAX_HEART_RATE_BASE - age;
        if (restingHeartRate >= maxHeartRate) {
            throw new ValidationException(
                    "Пульс покоя не может быть больше или равен максимальному пульсу (" + maxHeartRate + ")");
        }
    }
}
