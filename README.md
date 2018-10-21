# SimpleToDo  
![](https://i.imgur.com/PI32pKS.png)  
This is a simple to-do list app for iOS. Created to practice MVVM pattern and Core Data.

**Project status : Working**

## 1. UI DESIGN
First step is to design a user interface.
I will use Sketch for all the design process.

Here's the first design. (Sketch file avaliable in the repository)
![](https://i.imgur.com/DPazsTw.png)
From left to right, start screen, main screen, view to-do screen, and add to-do screen.  
When the to-do item is tapped, the popup with detail of the item will show and dim the background.  
Each to-do item will has only a title and a not-so-long note for simplicity purpose.  

## 2. PLAN
The project will use MVVM pattern and store data using Apple's Core Data.

**List of main functions**
- **VIEW** to-do item : when user taps any items in table view, show popup with item detail as designed.
- **ADD** new to-do item : when DONE button in add screen is tapped, create and save new item using Core Data.
- **EDIT** to-do item : when EDIT button in popup is tapped, bring user to edit screen. (Edit screen is almost the same as add screen, just change the header to 'Edit item' and change the  button label to 'SAVE')
- **DELETE** to-do item : when DELETE button in popup is tapped, ask for confirmation then delete that item, close the popup and update the table.

## 3. CODE
Now I start working on Xcode project.  
First, I quickly reconstruct the designed UI in storyboard.  
It is still missing something, e.g. popup or styled textfield/textview, but I will come back for it later.  
These are the only three view controllers needed for this project.  
![](https://i.imgur.com/oGLsH0v.png)

*working . . .*
