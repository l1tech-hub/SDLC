package StockScreenMockup {
    private import ScalarValues::*;
    private import CafeCalcUI::*;

    doc /* Мокап 1. Главное окно, вкладка «Склад».
         Трассировка: REQ-INT-001, REQ-FUNC-001, REQ-FUNC-002, REQ-FUNC-003,
         REQ-FUNC-006, REQ-FUNC-007, REQ-FUNC-008. */

    part stockWindow : Window {
        :>> title = "CafeCalc — Склад";
        :>> width = 1280;
        :>> height = 760;

        /* Вкладки */
        part tabStock : Tab   { :>> caption = "Склад";           :>> active = true; :>> x = 20;  :>> y = 40; :>> width = 170; :>> height = 38; }
        part tabMenu : Tab    { :>> caption = "Меню блюд";       :>> x = 210; :>> y = 40; :>> width = 170; :>> height = 38; }
        part tabJournal : Tab { :>> caption = "Журнал списаний"; :>> x = 400; :>> y = 40; :>> width = 170; :>> height = 38; }

        /* Поиск и добавление */
        part searchBox : TextBox {
            :>> x = 20; :>> y = 96; :>> width = 520; :>> height = 38;
            :>> placeholder = "Поиск по названию…  (например: мук)";
        }
        part addProductButton : Button {
            :>> x = 1030; :>> y = 96; :>> width = 230; :>> height = 38;
            :>> caption = "+ Добавить продукт";
            :>> kind = ButtonKind::primary;
        }

        /* Список продуктов */
        part productGrid : DataGrid {
            :>> x = 20; :>> y = 150; :>> width = 830; :>> height = 560;

            part colImage : GridColumn { :>> header = "";           :>> x = 12; }
            part colName : GridColumn  { :>> header = "Продукт";    :>> x = 80; }
            part colStock : GridColumn { :>> header = "Остаток, г"; :>> x = 680; }

            part row01 : ProductRow { :>> productName = "Мука пшеничная";   :>> stockGrams = 5000;  :>> selected = true; }
            part row02 : ProductRow { :>> productName = "Сахар";            :>> stockGrams = 3200; }
            part row03 : ProductRow { :>> productName = "Яйца куриные";     :>> stockGrams = 1500; }
            part row04 : ProductRow { :>> productName = "Молоко";           :>> stockGrams = 8000; }
            part row05 : ProductRow { :>> productName = "Масло сливочное";  :>> stockGrams = 1200; }
            part row06 : ProductRow { :>> productName = "Сливки 20%";       :>> stockGrams = 150;   :>> lowStock = true; }
            part row07 : ProductRow { :>> productName = "Сыр моцарелла";    :>> stockGrams = 2000; }
            part row08 : ProductRow { :>> productName = "Томаты";           :>> stockGrams = 2500; }
            part row09 : ProductRow { :>> productName = "Куриное филе";     :>> stockGrams = 4000; }
            part row10 : ProductRow { :>> productName = "Картофель";        :>> stockGrams = 10000; }
            part row11 : ProductRow { :>> productName = "Соль";             :>> stockGrams = 800; }
        }

        part counter : Label {
            :>> x = 20; :>> y = 722; :>> width = 300; :>> height = 20;
            :>> text = "Найдено: 11 из 11";
        }

        /* Панель сведений о выбранном продукте */
        part detailsTitle : Label { :>> x = 890; :>> y = 165; :>> width = 300; :>> height = 24; :>> text = "Сведения о продукте"; :>> bold = true; }
        part productImage : ImageBox {
            :>> x = 890; :>> y = 200; :>> width = 350; :>> height = 200;
            :>> source = "images/products/flour.jpg";
            :>> placeholder = "Изображение отсутствует";
        }
        part productName : Label  { :>> x = 890; :>> y = 418; :>> width = 350; :>> height = 28; :>> text = "Мука пшеничная"; :>> bold = true; }
        part stockCaption : Label { :>> x = 890; :>> y = 455; :>> width = 350; :>> height = 20; :>> text = "Остаток на складе"; }
        part stockValue : Label   { :>> x = 890; :>> y = 475; :>> width = 350; :>> height = 24; :>> text = "5 000 г"; :>> bold = true; }

        part replenishButton : Button { :>> x = 890;  :>> y = 520; :>> width = 170; :>> height = 38; :>> caption = "Пополнить"; }
        part editButton : Button      { :>> x = 1070; :>> y = 520; :>> width = 170; :>> height = 38; :>> caption = "Изменить"; }
        part deleteButton : Button    { :>> x = 890;  :>> y = 570; :>> width = 350; :>> height = 38; :>> caption = "Удалить продукт"; :>> kind = ButtonKind::danger; }
    }

    /* Поведение экрана */
    state def StockScreenStates {
        entry; then browsing;

        state browsing;
        state filtered;
        state productSelected;

        transition first browsing accept TextEntered then filtered;
        transition first browsing accept RowSelected then productSelected;
        transition first filtered accept RowSelected then productSelected;
        transition first productSelected accept TextEntered then filtered;
    }
}
