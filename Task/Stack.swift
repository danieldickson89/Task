//
//  Stack.swift
//  Task
//
//  Created by Daniel Dickson on 2/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class Stack {
    
    static let sharedStack = Stack()
    
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() -> NSManagedObjectContext {
        let bundle = NSBundle.mainBundle()
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle]) else {
            fatalError("model not found") }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL(), options: nil)
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        return context
    }
    
    static func storeURL() -> NSURL? {
        let documentDirectory: NSURL?
        do {
            documentDirectory = try NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
        } catch {
            documentDirectory = nil
        }
        
        return documentDirectory?.URLByAppendingPathComponent("db.sqlite")
    }
}
