package com.example.idealslimming.model;

import javafx.beans.property.BooleanProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleObjectProperty;

public class AppModel {

    private final ObjectProperty<UserInput> userInput = new SimpleObjectProperty<>();
    private final ObjectProperty<HeartRateZones> zones = new SimpleObjectProperty<>();
    private final BooleanProperty dataEntered = new SimpleBooleanProperty(false);

    public AppModel() {
        userInput.addListener((obs, oldValue, newValue) -> {
            if (newValue != null) {
                zones.set(KarvonenCalculator.calculate(newValue));
                dataEntered.set(true);
            }
        });
    }

    public void updateUserInput(int age, int restingHeartRate) {
        UserInputValidator.validate(age, restingHeartRate);
        userInput.set(new UserInput(age, restingHeartRate));
    }

    public UserInput getUserInput() {
        return userInput.get();
    }

    public ObjectProperty<UserInput> userInputProperty() {
        return userInput;
    }

    public ObjectProperty<HeartRateZones> zonesProperty() {
        return zones;
    }

    public BooleanProperty dataEnteredProperty() {
        return dataEntered;
    }
}
