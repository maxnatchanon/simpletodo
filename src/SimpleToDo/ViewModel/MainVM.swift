//
//  MainVM.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import Foundation

class MainVM {
    
    var todoList : [TodoItem] = [TodoItem]() {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure : (()->())?
    
    var numberOfCells : Int {
        return todoList.count
    }
    
    func initFetch() {
        // Test data
        todoList.append(TodoItem(title: "Watch Dexter SS5", note: "Please watch it.", finished: false))
        todoList.append(TodoItem(title: "Take a shower!", note: "It's been 5 days!!", finished: false))
        todoList.append(TodoItem(title: "Write some test data", note: "I will use them before working on Core Data.", finished: false))
    }
    
    func getItem(at indexPath : IndexPath) -> TodoItem {
        return todoList[indexPath.row]
    }
    
    func toggleFinished(at indexPath : IndexPath) {
        todoList[indexPath.row].finished = !todoList[indexPath.row].finished
        reloadTableViewClosure?()
    }
    
}
