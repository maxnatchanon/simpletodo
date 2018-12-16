//
//  AddEditVM.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddEditVM {
    var title: String
    var note: String
    var finished: Bool
    var date: Date
    
    var managedItem: NSManagedObject!
    
    var updateTitle: ((String)->())?
    
    init(item: TodoItem) {
        self.title = item.title
        self.note = item.note
        self.finished = item.finished
        self.date = item.date
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTodoItem")
        request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        do {
            let data = try context.fetch(request) as! [ManagedTodoItem]
            managedItem = data[0]
        } catch {
            print("Fetching at edit page failed")
        }
    }
    
    init() {
        self.title = ""
        self.note = ""
        self.finished = false
        self.date = Date()

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ManagedTodoItem", in: context)
        managedItem = NSManagedObject(entity: entity!, insertInto: context)
    }
    
    func saveItem() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedItem.setValue(self.title, forKey: "title")
        managedItem.setValue(self.note, forKey: "note")
        managedItem.setValue(self.finished, forKey: "finished")
        managedItem.setValue(Date(), forKey: "date")
        do {
            try context.save()
        } catch {
            print("Saving at edit page failed")
        }
    }

}
