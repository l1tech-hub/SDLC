package AddDishWindowMockup {
    private import ScalarValues::*;
    private import CafeCalcUI::*;

    doc /* Мокап 4. Отдельное модальное окно «Новое блюдо»: название, изображение,
         состав (продукт выбирается из склада, граммы на 1 порцию), текстовый рецепт.
         Трассировка: REQ-INT-001, REQ-FUNC-011, REQ-FUNC-013, REQ-FUNC-006. */

    part addDishWindow : Window {
        :>> title = "Новое блюдо";
        :>> width = 820;
        :>> height = 700;
        :>> modal = true;

        part nameLabel : Label { :>> x = 30; :>> y = 55; :>> width = 300; :>> height = 20; :>> text = "Название *"; }
        part nameBox : TextBox { :>> x = 30; :>> y = 77; :>> width = 760; :>> height = 36; :>> text = "Омлет с сыром"; }

        part dishImage : ImageBox {
            :>> x = 30; :>> y = 135; :>> width = 200; :>> height = 150;
            :>> placeholder = "Изображение отсутствует";
        }
        part chooseImageButton : Button { :>> x = 30; :>> y = 295; :>> width = 200; :>> height = 34; :>> caption = "Выбрать изображение…"; }

        /* Состав */
        part compositionLabel : Label { :>> x = 260; :>> y = 135; :>> width = 400; :>> height = 20; :>> text = "Состав на 1 порцию *"; }
        part productPicker : TextBox {
            :>> x = 260; :>> y = 157; :>> width = 300; :>> height = 34;
            :>> placeholder = "Выберите продукт…";
        }
        part gramsBox : TextBox { :>> x = 570; :>> y = 157; :>> width = 100; :>> height = 34; :>> text = "30"; }
        part gramsUnit : Label  { :>> x = 678; :>> y = 165; :>> width = 20; :>> height = 20; :>> text = "г"; }
        part addIngredientButton : Button { :>> x = 700; :>> y = 157; :>> width = 90; :>> height = 34; :>> caption = "Добавить"; }

        part compositionGrid : DataGrid {
            :>> x = 260; :>> y = 205; :>> width = 530; :>> height = 130;
            :>> rowHeight = 30;

            part colProduct : GridColumn { :>> header = "Продукт";       :>> x = 10; }
            part colGrams : GridColumn   { :>> header = "Количество, г"; :>> x = 300; }

            part ing1 : IngredientRow { :>> productName = "Яйца куриные";    :>> gramsPerPortion = 120; }
            part ing2 : IngredientRow { :>> productName = "Молоко";          :>> gramsPerPortion = 50; }
            part ing3 : IngredientRow { :>> productName = "Сыр моцарелла";   :>> gramsPerPortion = 30; }
            part ing4 : IngredientRow { :>> productName = "Масло сливочное"; :>> gramsPerPortion = 10; }
        }

        /* Рецепт */
        part recipeLabel : Label { :>> x = 30; :>> y = 350; :>> width = 400; :>> height = 20; :>> text = "Рецепт приготовления *"; }
        part recipeText : TextArea {
            :>> x = 30; :>> y = 372; :>> width = 760; :>> height = 200;
            :>> text = "1. Взбейте яйца с молоком и солью до однородности. 2. Разогрейте сковороду, растопите масло. 3. Влейте смесь, готовьте на среднем огне 2–3 минуты. 4. Посыпьте тёртым сыром, сложите пополам и готовьте ещё 1 минуту под крышкой. 5. Подавайте горячим.";
        }

        part cancelButton : Button { :>> x = 520; :>> y = 638; :>> width = 130; :>> height = 38; :>> caption = "Отмена"; }
        part saveButton : Button   { :>> x = 660; :>> y = 638; :>> width = 130; :>> height = 38; :>> caption = "Сохранить"; :>> kind = ButtonKind::primary; }
    }

    state def AddDishWindowStates {
        attribute isValid : Boolean;   // название, ≥1 продукт, граммы > 0, непустой рецепт

        entry; then editing;

        state editing;
        state validationError;
        state saved;
        state cancelled;

        transition first editing accept AddClicked then editing;   // добавление продукта в состав
        transition first editing accept SaveClicked if isValid == true then saved;
        transition first editing accept SaveClicked if isValid == false then validationError;
        transition first validationError accept TextEntered then editing;
        transition first editing accept CancelClicked then cancelled;
    }
}
