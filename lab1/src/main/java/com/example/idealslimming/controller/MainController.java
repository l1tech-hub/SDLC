package com.example.idealslimming.controller;

import com.example.idealslimming.model.AppModel;
import javafx.beans.binding.Bindings;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;

public class MainController {

    @FXML
    private Label lblStartPulse;

    @FXML
    private Label lblTargetPulse;

    private final AppModel model = new AppModel();

    @FXML
    private void initialize() {
        lblStartPulse.textProperty().bind(Bindings.createStringBinding(
                () -> model.zonesProperty().get() != null
                        ? String.valueOf(model.zonesProperty().get().startPulse())
                        : "—",
                model.zonesProperty()));

        lblTargetPulse.textProperty().bind(Bindings.createStringBinding(
                () -> model.zonesProperty().get() != null
                        ? String.valueOf(model.zonesProperty().get().targetPulse())
                        : "—",
                model.zonesProperty()));
    }

    @FXML
    private void onInputButtonClick() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(
                    "/com/example/idealslimming/fxml/input-view.fxml"));
            Parent root = loader.load();

            InputController inputController = loader.getController();
            inputController.setModel(model);

            Stage stage = new Stage();
            stage.setTitle("Ввод данных");
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setScene(new Scene(root));
            stage.showAndWait();
        } catch (IOException e) {
            throw new RuntimeException("Не удалось открыть форму ввода данных", e);
        }
    }
}
