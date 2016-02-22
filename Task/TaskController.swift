//
//  TaskController.swift
//  Task
//
//  Created by Daniel Dickson on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    private let tasksKey = "tasks"
    
    static let sharedController = TaskController()
    
    var taskArray: [Task] {
        let request = NSFetchRequest(entityName: "Task")
        
        do {
            return try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Task]
        } catch {
            return []
        }
    }
    
    var completedTasks: [Task] {
        return taskArray.filter() {$0.isComplete!.boolValue}
    }
    
    var incompleteTasks: [Task] {
        return taskArray.filter() {!$0.isComplete!.boolValue}
    }
    
    func addTask(task: Task) {
        saveToPersistence()
    }
    
    func removeTask(task: Task) {
        task.managedObjectContext?.deleteObject(task)
        saveToPersistence()
    }
    
    func saveToPersistence() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
        
    }
    
//    func filePath(key: String) -> String {
//        
//        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
//        
//        let documentPath: AnyObject = directorySearchResults[0]
//        
//        let entriesPath = documentPath.stringByAppendingString("/\(key).plist")
//        
//        return entriesPath
//    }
    
}