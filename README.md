# SimpleToDo  
![](https://i.imgur.com/PI32pKS.png)  
This is a simple to-do list app for iOS. Created to practice MVVM pattern and Core Data.

**Project status : Working**

## UI DESIGN
First step is to design a user interface.
I will use Sketch for all the design process.

Here's the first design. (Sketch file avaliable in the repository)
![](https://i.imgur.com/DPazsTw.png)
From left to right, start screen, main screen, view to-do screen, and add to-do screen.  
When the to-do item is tapped, the popup with detail of the item will show and dim the background.  
Each to-do item will has only a title and a not-so-long note for simplicity purpose.  

## PLAN
The project will use MVVM pattern and store data using Apple's Core Data.

**List of main functions**
- **VIEW** to-do item : when user taps any items in table view, show popup with item detail as designed.
- **ADD** new to-do item : when DONE button in add screen is tapped, create and save new item using Core Data.
- **EDIT** to-do item : when EDIT button in popup is tapped, bring user to edit screen. (Edit screen is almost the same as add screen, just change the header to 'Edit item' and change the  button label to 'SAVE')
- **DELETE** to-do item : when DELETE button in popup is tapped, ask for confirmation then delete that item, close the popup and update the table.

## CODE
Now I will start working on Xcode project.  
First, I quickly reconstruct the designed UI in storyboard.  
It is still missing something, e.g. popup or styled textfield/textview, but I will come back for it later.  
These are the only three view controllers needed for this project.  
![](https://i.imgur.com/oGLsH0v.png)  
From left to right - Start screen, Main screen, Add/Edit screen  

After created view controller files and linked them to storyboard, I created view model for Main and Add/Edit screen.  
![](https://i.imgur.com/pfcf3bC.png)  

Start with Main screen, the MainVM will do a model-to-view transformation and MainVC will only display those data and handle user interaction then pass them to MainVM via data binding.  
For data binding, I will use closure like this.  
```swift
// MainVM.swift
var reloadTableViewClosure : (()->())?

var todoList : [TodoItem] = [TodoItem]() {
  didSet {
    reloadTableViewClosure?()
  }
}

// MainVC.swift
lazy var mainVM : MainVM = {
  return MainVM()
}()

mainVM.reloadTableViewClosure = { [weak self] () in
  self?.tableView.reloadData()
}
```
Now I have tableview set up and MainVC and MainVM are binded.  
User can now check/uncheck these test data on tableview but still can't add, edit or delete an item.  

*working . . .*
