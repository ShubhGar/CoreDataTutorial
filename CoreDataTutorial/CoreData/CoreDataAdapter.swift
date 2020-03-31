//
//  CoreDataAdapter.swift
//  CoreDataTutorial
//
//  Created by shubham Garg on 31/03/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import Foundation


import Foundation
import CoreData

extension CoreDataStack: PersistentStoreAdapter {
    

    func object(for anEntity: String) -> AnyObject {
        return self.managedObject(for: anEntity)
    }
    
    func save() {
        self.saveContext()
    }
    
    // MARK:- CREATE
    func create(with name: String, completion: @escaping (Any) -> Void) {
        self.initialize(with: name, completion: completion)
    }
    
    
    // MARK:- UPDATE
    func update(_ object: AnyObject, with predicate: NSPredicate? = nil, of entity: String) {
        var managedObject = self.fetchResults(from: entity, with: predicate, sortDescriptor: nil).first
        if let object = object as? NSManagedObject {
            managedObject = object
            self.saveContext()
        }
    }
    
    // MARK:- DELETE
    func delete(from entity: String, with predicate: NSPredicate? = nil) {
        self.deleteData(from: entity, with: predicate)
    }
    
    func deleteAll() {
        self.clearAll()
    }
    
    // MARK: - Member Functions
    
    private func managedObject(for anEntityName: String) -> NSManagedObject {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: anEntityName, into: (self.mainManagedObjectContext))
        return managedObject
    }
    
    
   
    
    // MARK:- READ
    func fetchResults(from entity: String, with predicate: NSPredicate? = nil, sortDescriptor: NSSortDescriptor? = nil) -> [NSManagedObject] {
        return self.fetch(from: entity, with: predicate, sortDescriptor: sortDescriptor)
    }
    
    
    
    private func fetch(from entity: String, with predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> [NSManagedObject] {
        var managedObjects = [NSManagedObject]()
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if let predicate = predicate {
            fetchrequest.predicate = predicate
        }
        if let sortDescriptor = sortDescriptor {
            fetchrequest.sortDescriptors?.append(sortDescriptor)
        }
        do {
            managedObjects = try self.mainManagedObjectContext.fetch(fetchrequest) as! [NSManagedObject]
        } catch {
             // Log.error?.message("\(#function):Error:\(error.localizedDescription)")
        }
        return managedObjects
    }
    
    private func deleteData(from entity: String, with predicate: NSPredicate?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            _ = try self.mainManagedObjectContext.execute(deleteRequest)
            self.saveContext()
        } catch {
             print(error.localizedDescription)
        }
    }
    
    
    private func clearAll() {
        if let entities = self.entities {
            for entity in entities {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                do {
                    _ = try self.mainManagedObjectContext.execute(deleteRequest)
                    self.saveContext()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
