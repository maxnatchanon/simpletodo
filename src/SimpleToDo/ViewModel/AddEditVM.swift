//
//  AddEditVM.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import Foundation

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
        // TODO: Update item in database
        print(title, note, finished)
    }
}
