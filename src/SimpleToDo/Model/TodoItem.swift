//
//  TodoItem.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import Foundation

struct TodoItem {
    let title: String
    let note: String
    var finished: Bool
    let date: Date
    
    init(title: String, note: String, finished: Bool, date: Date) {
        self.title = title
        self.note = note
        self.finished = finished
        self.date = date
    }
}
