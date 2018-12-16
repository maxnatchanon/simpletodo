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
    
    var updateTitle: ((String)->())?
    
    init(item: TodoItem) {
        self.title = item.title
        self.note = item.note
        self.finished = item.finished
    }
    
    init() {
        self.title = ""
        self.note = ""
        self.finished = false
    }
    
    func saveItem() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ManagedTodoItem", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        newItem.setValue(self.title, forKey: "title")
        newItem.setValue(self.note, forKey: "note")
        newItem.setValue(self.finished, forKey: "finished")
        do {
            try context.save()
        } catch {
            print("Saving failed")
        }
    }
}
