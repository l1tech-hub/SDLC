package com.example.idealslimming.model;

public final class KarvonenCalculator {

    private static final double START_INTENSITY = 0.5;
    private static final double TARGET_INTENSITY = 0.7;
    private static final int MAX_HEART_RATE_BASE = 220;

    private KarvonenCalculator() {
    }

    public static HeartRateZones calculate(UserInput input) {
        UserInputValidator.validate(input.age(), input.restingHeartRate());

        int maxHeartRate = MAX_HEART_RATE_BASE - input.age();
        int heartRateReserve = maxHeartRate - input.restingHeartRate();

        int startPulse = round(input.restingHeartRate() + heartRateReserve * START_INTENSITY);
        int targetPulse = round(input.restingHeartRate() + heartRateReserve * TARGET_INTENSITY);

        return new HeartRateZones(startPulse, targetPulse);
    }

    private static int round(double value) {
        return (int) Math.round(value);
    }
}