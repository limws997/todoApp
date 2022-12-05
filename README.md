# technical_assessment

A Flutter TodoApp.

## Structure Definition

This project is develop with architecture around Riverpod. There are 5 main folder in lib which is

1. components -> Keep customise functions
2. models -> class to define todo list Object
3. provider -> Keep & setup provider
4. repos -> Used as a repository, for database (todo list) usage, setup database related getter and setter
5. screen -> a. homescreen -> homescreen UI
             b. todoscreen -> todoscreen UI

## Getting Started
1. First screen is homescreen, second screen is todoscreen.

# Home screen
2. To display todo list, will display empty text when empty todo list.
3. Todo list is clickable, clicking on it will navigate to Todo screen where able to view the relavent detail. User can update the data, and the updated data will reflect on the todo list on the home screen. 
4. Checkbox of todo item is editable, text will be incomplete when no-checked while complete when checked.

# Todo screen
5. All items are required to fill up and validator is available.
6. Start Date must earlier than End Date and validator is available.
7. Appbar title and button text is affected by "create new" or "update" todo list.
8. Changes will be updated and will reflect on home screen todo list.

No unit test implemented, 
Regards, thank you. :)



# todoApp
