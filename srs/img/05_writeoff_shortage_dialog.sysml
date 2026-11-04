package WriteOffShortageDialogMockup {
    private import ScalarValues::*;
    private import CafeCalcUI::*;

    doc /* Мокап 5. Модальное сообщение о нехватке продуктов при списании.
         Остатки не изменяются, списание не выполняется.
         Трассировка: REQ-FUNC-015, REQ-REL-001. */

    part shortageDialog : Window {
        :>> title = "Списание — Омлет с сыром × 2";
        :>> width = 720;
        :>> height = 380;
        :>> modal = true;

        part heading : Label {
            :>> x = 30; :>> y = 60; :>> width = 660; :>> height = 28;
            :>> text = "Недостаточно продуктов на складе";
            :>> bold = true;
            :>> isError = true;
        }

        part shortageGrid : DataGrid {
            :>> x = 30; :>> y = 100; :>> width = 660; :>> height = 90;
            :>> rowHeight = 28;

            part colProduct : GridColumn   { :>> header = "Продукт";        :>> x = 10; }
            part colRequired : GridColumn  { :>> header = "Требуется, г";   :>> x = 300; }
            part colAvailable : GridColumn { :>> header = "На складе, г";   :>> x = 440; }
            part colShortage : GridColumn  { :>> header = "Нехватка";       :>> x = 570; }

            part row1 : ShortageRow {
                :>> productName = "Сыр моцарелла";
                :>> requiredGrams = 60;
                :>> availableGrams = 40;
                :>> shortageGrams = 20;
            }
        }

        part resultNote : Label {
            :>> x = 30; :>> y = 200; :>> width = 660; :>> height = 20;
            :>> text = "Списание не выполнено, остатки не изменены.";
        }

        part closeButton : Button {
            :>> x = 560; :>> y = 318; :>> width = 130; :>> height = 38;
            :>> caption = "Закрыть";
            :>> kind = ButtonKind::primary;
        }
    }

    state def ShortageDialogStates {
        entry; then shown;
        state shown;
        state closed;
        transition first shown accept CloseClicked then closed;
    }
}
