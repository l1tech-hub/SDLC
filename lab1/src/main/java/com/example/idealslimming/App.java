package com.example.idealslimming;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class App extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource(
                "/com/example/idealslimming/fxml/main-view.fxml"));
        Parent root = loader.load();

        Scene scene = new Scene(root, 450, 350); // ширина, высота в пикселях
        scene.getStylesheets().add(getClass().getResource(
                "/com/example/idealslimming/css/style.css").toExternalForm());

        primaryStage.setTitle("Идеальное похудение");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    public static void main(String[] args) {
        launch(args);
    }
}