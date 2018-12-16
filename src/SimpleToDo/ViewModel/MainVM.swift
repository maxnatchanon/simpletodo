//
//  MainVM.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class MainVM {
    
    var reloadTableViewClosure: (()->())?
    var todoList : [TodoItem] = [TodoItem]() {
        didSet {
            reloadTableViewClosure?()
        }
    }
    var numberOfCells : Int {
        return todoList.count
    }
    
    // Fetch the data from CoreData then add to todoList array
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTodoItem")
        let dateSort = NSSortDescriptor(key: #keyPath(ManagedTodoItem.date), ascending: false)
        request.sortDescriptors = [dateSort]
        do {
            let fetchedData = try context.fetch(request) as! [ManagedTodoItem]
            self.todoList.removeAll()
            for item in fetchedData {
                if let title = item.title, let note = item.note, let date = item.date {
                    self.todoList.append(TodoItem(title: title, note: note, finished: item.finished, date: date))
                }
            }
        } catch {
            print("Fetching at main page failed")
        }
    }
    
    // Return item at indexPath
    func getItem(at indexPath: IndexPath) -> TodoItem {
        return todoList[indexPath.row]
    }
    
    func deleteItem(at indexPath: IndexPath, completion: () -> Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTodoItem")
        request.predicate = NSPredicate(format: "date = %@", todoList[indexPath.row].date as CVarArg)
        do {
            let data = try context.fetch(request) as! [ManagedTodoItem]
            context.delete(data[0])
        } catch {
            print("Deleting at main page failed")
        }
        completion()
    }
    
    // Will be called when user tap the circle in front of each item
    // Fetch that item from CoreData - edit - then save
    func toggleFinished(at indexPath: IndexPath) {
        todoList[indexPath.row].finished = !todoList[indexPath.row].finished
        reloadTableViewClosure?()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTodoItem")
        request.predicate = NSPredicate(format: "title = %@", todoList[indexPath.row].title)
        do {
            let data = try context.fetch(request) as! [ManagedTodoItem]
            data[0].setValue(todoList[indexPath.row].finished, forKey: "finished")
            try context.save()
        } catch {
            print("Editing at main page failed")
        }
    }
    
    // Return AddEditVM for the item at indexPath
    func getAddEditVM(at indexPath: IndexPath) -> AddEditVM {
        return AddEditVM(item: todoList[indexPath.row])
    }

}
