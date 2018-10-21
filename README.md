# SimpleToDo
This is a simple to-do list app for iOS. Created to practice MVVM pattern and Core Data.

**Project status : Planing**

## 1. UI DESIGN
First step is deign a user interface.
I will use Sketch for all the design process.

Here's my first design. (Sketch file avaliable in the repository)
![](https://i.imgur.com/8rcU6C1.png)
From left to right, start screen, main screen, view to-do screen, and add to-do screen.  
When the to-do item is tapped, the popup with detail of the item will show and dim the background.  
Each to-do item will has only a title and a not-so-long note for simplicity.  

## 2. PLAN
The project will usำ MVVM pattern and store data using Apple's Core Data.

**List of main functions**
- **VIEW** to-do item : when user taps any items in table view, show popup with item detail as designed.
- **ADD** new to-do item : when DONE button in add screen is tapped, create and save new item using Core Data.
- **EDIT** to-do item : when EDIT button in popup is tapped, bring user to edit screen. (Edit screen is almost the same as add screen, just change the header to 'Edit item' and change the  button label to 'SAVE')
- **DELETE** to-do item : when DELETE button in popup is tapped, ask for confirmation then delete that item, close the popup and update the table.

*working . . .
