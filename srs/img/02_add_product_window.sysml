package AddProductWindowMockup {
    private import ScalarValues::*;
    private import CafeCalcUI::*;

    doc /* Мокап 2. Отдельное модальное окно «Новый продукт».
         Два состояния макета: ввод данных и ошибки проверки.
         Трассировка: REQ-INT-001, REQ-INT-005, REQ-FUNC-004, REQ-FUNC-005,
         REQ-FUNC-006, REQ-FUNC-009. */

    /* Состояние «ввод данных» */
    part addProductWindow : Window {
        :>> title = "Новый продукт";
        :>> width = 720;
        :>> height = 560;
        :>> modal = true;

        part nameLabel : Label { :>> x = 30; :>> y = 60; :>> width = 300; :>> height = 20; :>> text = "Название *"; }
        part nameBox : TextBox { :>> x = 30; :>> y = 82; :>> width = 660; :>> height = 38; :>> text = "Сливки 20%"; }

        part gramsLabel : Label { :>> x = 30; :>> y = 140; :>> width = 300; :>> height = 20; :>> text = "Количество на складе, г *"; }
        part gramsBox : TextBox { :>> x = 30; :>> y = 162; :>> width = 300; :>> height = 38; :>> text = "500"; }
        part gramsUnit : Label  { :>> x = 345; :>> y = 172; :>> width = 20; :>> height = 20; :>> text = "г"; }

        part imageLabel : Label { :>> x = 30; :>> y = 220; :>> width = 300; :>> height = 20; :>> text = "Изображение"; }
        part imagePreview : ImageBox {
            :>> x = 30; :>> y = 245; :>> width = 200; :>> height = 150;
            :>> placeholder = "Изображение отсутствует";
        }
        part chooseImageButton : Button { :>> x = 250; :>> y = 245; :>> width = 200; :>> height = 38; :>> caption = "Выбрать файл…"; }
        part removeImageButton : Button { :>> x = 250; :>> y = 293; :>> width = 200; :>> height = 38; :>> caption = "Убрать"; }
        part imageHint : Label { :>> x = 250; :>> y = 350; :>> width = 300; :>> height = 20; :>> text = "JPG, PNG, до 5 МБ"; }

        part requiredHint : Label {
            :>> x = 30; :>> y = 415; :>> width = 660; :>> height = 20;
            :>> text = "* — обязательные поля. Единица измерения — граммы.";
        }

        part cancelButton : Button { :>> x = 420; :>> y = 490; :>> width = 130; :>> height = 38; :>> caption = "Отмена"; }
        part saveButton : Button   { :>> x = 560; :>> y = 490; :>> width = 130; :>> height = 38; :>> caption = "Сохранить"; :>> kind = ButtonKind::primary; }
    }

    /* Состояние «ошибки проверки» (REQ-FUNC-005) */
    part addProductWindowWithErrors : Window {
        :>> title = "Новый продукт";
        :>> width = 720;
        :>> height = 560;
        :>> modal = true;

        part nameBox : TextBox {
            :>> x = 30; :>> y = 82; :>> width = 660; :>> height = 38;
            :>> text = "Мука пшеничная";
            :>> hasError = true;
            :>> errorText = "Продукт с таким названием уже существует";
        }
        part gramsBox : TextBox {
            :>> x = 30; :>> y = 182; :>> width = 300; :>> height = 38;
            :>> text = "12,5";
            :>> hasError = true;
            :>> errorText = "Введите целое неотрицательное число граммов";
        }
        part cancelButton : Button { :>> x = 420; :>> y = 505; :>> width = 130; :>> height = 38; :>> caption = "Отмена"; }
        part saveButton : Button   { :>> x = 560; :>> y = 505; :>> width = 130; :>> height = 38; :>> caption = "Сохранить"; :>> kind = ButtonKind::primary; }
    }

    /* Поведение окна */
    state def AddProductWindowStates {
        attribute hasErrors : Boolean;

        entry; then editing;

        state editing;
        state validationError;
        state saved;
        state cancelled;

        transition first editing accept SaveClicked if hasErrors == true then validationError;
        transition first editing accept SaveClicked if hasErrors == false then saved;
        transition first validationError accept TextEntered then editing;
        transition first editing accept CancelClicked then cancelled;
        transition first validationError accept CancelClicked then cancelled;
    }
}
