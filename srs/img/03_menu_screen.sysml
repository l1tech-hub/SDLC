package MenuScreenMockup {
    private import ScalarValues::*;
    private import CafeCalcUI::*;

    doc /* Мокап 3. Главное окно, вкладка «Меню блюд»: список блюд, карточка блюда,
         состав в граммах, текстовый рецепт, кнопка «Списать».
         Трассировка: REQ-FUNC-010, REQ-FUNC-012, REQ-FUNC-013, REQ-FUNC-014. */

    part menuWindow : Window {
        :>> title = "CafeCalc — Меню блюд";
        :>> width = 1280;
        :>> height = 760;

        part tabStock : Tab   { :>> caption = "Склад";           :>> x = 20;  :>> y = 40; :>> width = 170; :>> height = 38; }
        part tabMenu : Tab    { :>> caption = "Меню блюд";       :>> active = true; :>> x = 210; :>> y = 40; :>> width = 170; :>> height = 38; }
        part tabJournal : Tab { :>> caption = "Журнал списаний"; :>> x = 400; :>> y = 40; :>> width = 170; :>> height = 38; }

        part searchBox : TextBox { :>> x = 20; :>> y = 96; :>> width = 380; :>> height = 38; :>> placeholder = "Поиск блюда…"; }
        part addDishButton : Button {
            :>> x = 1030; :>> y = 96; :>> width = 230; :>> height = 38;
            :>> caption = "+ Добавить блюдо";
            :>> kind = ButtonKind::primary;
        }

        /* Список блюд */
        part dishGrid : DataGrid {
            :>> x = 20; :>> y = 150; :>> width = 420; :>> height = 560;
            :>> rowHeight = 70;

            part colImage : GridColumn { :>> header = ""; :>> x = 12; }
            part colName : GridColumn  { :>> header = "Блюдо"; :>> x = 105; }

            part row1 : DishRow { :>> dishName = "Омлет с сыром";      :>> selected = true; }
            part row2 : DishRow { :>> dishName = "Куриный суп"; }
            part row3 : DishRow { :>> dishName = "Панкейки"; }
            part row4 : DishRow { :>> dishName = "Салат с курицей"; }
            part row5 : DishRow { :>> dishName = "Картофельное пюре"; }
        }

        /* Карточка выбранного блюда */
        part dishImage : ImageBox {
            :>> x = 480; :>> y = 170; :>> width = 260; :>> height = 190;
            :>> source = "images/dishes/omelette.jpg";
            :>> placeholder = "Изображение отсутствует";
        }
        part dishTitle : Label { :>> x = 760; :>> y = 176; :>> width = 480; :>> height = 30; :>> text = "Омлет с сыром"; :>> bold = true; }
        part compositionCaption : Label {
            :>> x = 760; :>> y = 215; :>> width = 480; :>> height = 20;
            :>> text = "Состав на 1 порцию (в граммах)";
        }

        part compositionGrid : DataGrid {
            :>> x = 760; :>> y = 240; :>> width = 480; :>> height = 160;
            :>> rowHeight = 26;

            part colProduct : GridColumn { :>> header = "Продукт";        :>> x = 10; }
            part colGrams : GridColumn   { :>> header = "Количество, г";  :>> x = 340; }

            part ing1 : IngredientRow { :>> productName = "Яйца куриные";    :>> gramsPerPortion = 120; }
            part ing2 : IngredientRow { :>> productName = "Молоко";          :>> gramsPerPortion = 50; }
            part ing3 : IngredientRow { :>> productName = "Сыр моцарелла";   :>> gramsPerPortion = 30; }
            part ing4 : IngredientRow { :>> productName = "Масло сливочное"; :>> gramsPerPortion = 10; }
            part ing5 : IngredientRow { :>> productName = "Соль";            :>> gramsPerPortion = 2; }
        }

        part recipeCaption : Label { :>> x = 480; :>> y = 382; :>> width = 300; :>> height = 20; :>> text = "Рецепт приготовления"; :>> bold = true; }
        part recipeText : TextArea {
            :>> x = 480; :>> y = 408; :>> width = 760; :>> height = 140;
            :>> enabled = false;   // только просмотр
            :>> text = "1. Взбейте яйца с молоком и солью до однородности. 2. Разогрейте сковороду, растопите масло. 3. Влейте смесь, готовьте на среднем огне 2–3 минуты. 4. Посыпьте тёртым сыром, сложите пополам и готовьте ещё 1 минуту под крышкой. 5. Подавайте горячим.";
        }

        /* Списание */
        part portionsLabel : Label { :>> x = 480; :>> y = 585; :>> width = 200; :>> height = 20; :>> text = "Количество порций"; }
        part portionsBox : TextBox { :>> x = 480; :>> y = 608; :>> width = 120; :>> height = 38; :>> text = "2"; }
        part writeOffButton : Button {
            :>> x = 620; :>> y = 608; :>> width = 200; :>> height = 38;
            :>> caption = "Списать продукты";
            :>> kind = ButtonKind::success;
        }
        part writeOffPreview : Label {
            :>> x = 480; :>> y = 665; :>> width = 760; :>> height = 20;
            :>> text = "Будет списано: яйца 240 г, молоко 100 г, сыр 60 г, масло 20 г, соль 4 г";
        }

        part editDishButton : Button   { :>> x = 1000; :>> y = 608; :>> width = 110; :>> height = 38; :>> caption = "Изменить"; }
        part deleteDishButton : Button { :>> x = 1120; :>> y = 608; :>> width = 120; :>> height = 38; :>> caption = "Удалить"; :>> kind = ButtonKind::danger; }
    }

    /* Поведение: выбор блюда и списание (REQ-FUNC-014, REQ-FUNC-015) */
    state def WriteOffStates {
        attribute enoughStock : Boolean;

        entry; then idle;

        state idle;
        state dishSelected;
        state checkingStock;
        state writtenOff;
        state shortageShown;

        transition first idle accept RowSelected then dishSelected;
        transition first dishSelected accept RowSelected then dishSelected;
        transition first dishSelected accept TextEntered then dishSelected;   // смена числа порций
        transition first dishSelected accept WriteOffClicked then checkingStock;
        transition first checkingStock if enoughStock == true then writtenOff;
        transition first checkingStock if enoughStock == false then shortageShown;
        transition first shortageShown accept CloseClicked then dishSelected;
        transition first writtenOff accept RowSelected then dishSelected;
    }
}
