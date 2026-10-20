package com.example.idealslimming.controller;

import com.example.idealslimming.model.AppModel;
import com.example.idealslimming.model.UserInput;
import com.example.idealslimming.model.ValidationException;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class InputController {

    @FXML
    private TextField tfAge;

    @FXML
    private TextField tfRestingHeartRate;

    @FXML
    private Button btnOk;

    @FXML
    private Button btnCancel;

    private AppModel model;

    public void setModel(AppModel model) {
        this.model = model;
        restorePreviousInput();
    }

    private void restorePreviousInput() {
        UserInput previous = model.getUserInput();
        if (previous != null) {
            tfAge.setText(String.valueOf(previous.age()));
            tfRestingHeartRate.setText(String.valueOf(previous.restingHeartRate()));
        }
    }

    @FXML
    private void onOkClick() {
        try {
            int age = Integer.parseInt(tfAge.getText().trim());
            int restingHeartRate = Integer.parseInt(tfRestingHeartRate.getText().trim());

            model.updateUserInput(age, restingHeartRate);

            closeWindow();
        } catch (NumberFormatException e) {
            showError("Возраст и пульс покоя должны быть целыми числами");
        } catch (ValidationException e) {
            showError(e.getMessage());
        }
    }

    @FXML
    private void onCancelClick() {
        closeWindow();
    }

    private void closeWindow() {
        Stage stage = (Stage) btnOk.getScene().getWindow();
        stage.close();
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ошибка ввода");
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }
}
