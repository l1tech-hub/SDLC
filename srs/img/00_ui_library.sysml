package CafeCalcUI {
    private import ScalarValues::*;

    doc /* Библиотека элементов GUI для мокапов CafeCalc.
         Координаты и размеры заданы в пикселях, начало отсчёта — левый верхний угол
         содержимого окна. Все количества продуктов — только граммы (REQ-FUNC-009). */

    enum def ButtonKind {
        enum primary;
        enum secondary;
        enum danger;
        enum success;
    }

    /* ---------- Базовые элементы интерфейса ---------- */

    abstract part def Widget {
        attribute x : Integer;
        attribute y : Integer;
        attribute width : Integer;
        attribute height : Integer;
        attribute enabled : Boolean = true;
    }

    part def Window {
        attribute title : String;
        attribute width : Integer;
        attribute height : Integer;
        attribute modal : Boolean = false;
    }

    part def Tab :> Widget {
        attribute caption : String;
        attribute active : Boolean = false;
    }

    part def Label :> Widget {
        attribute text : String;
        attribute bold : Boolean = false;
        attribute isError : Boolean = false;
    }

    part def TextBox :> Widget {
        attribute text : String;
        attribute placeholder : String;
        attribute hasError : Boolean = false;
        attribute errorText : String;
    }

    part def TextArea :> Widget {
        attribute text : String;
    }

    part def Button :> Widget {
        attribute caption : String;
        attribute kind : ButtonKind = ButtonKind::secondary;
    }

    part def ImageBox :> Widget {
        attribute source : String;       // путь к файлу изображения
        attribute placeholder : String;  // заглушка, если изображения нет
    }

    part def DataGrid :> Widget {
        attribute rowHeight : Integer = 46;
    }

    part def GridColumn {
        attribute header : String;
        attribute x : Integer;
    }

    /* ---------- Строки данных, показываемые в таблицах ---------- */

    part def ProductRow {
        attribute productName : String;
        attribute stockGrams : Integer;           // остаток, г
        attribute selected : Boolean = false;
        attribute lowStock : Boolean = false;     // остаток < 300 г -> красный
    }

    part def DishRow {
        attribute dishName : String;
        attribute selected : Boolean = false;
    }

    part def IngredientRow {
        attribute productName : String;
        attribute gramsPerPortion : Integer;      // г на 1 порцию
    }

    part def ShortageRow {
        attribute productName : String;
        attribute requiredGrams : Integer;
        attribute availableGrams : Integer;
        attribute shortageGrams : Integer;
    }

    /* ---------- События пользователя (для описания поведения) ---------- */

    item def TextEntered;
    item def RowSelected;
    item def AddClicked;
    item def SaveClicked;
    item def CancelClicked;
    item def WriteOffClicked;
    item def CloseClicked;
}
