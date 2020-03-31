//
//  PersistentStoreAdapter.swift
//  CoreDataTutorial
//
//  Created by shubham Garg on 31/03/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import Foundation


import CoreData

protocol PersistentStoreAdapter {
    func create(with name: String, completion: @escaping (Any) -> Void)
    func update(_ object: AnyObject, with predicate: NSPredicate?, of entity: String)
    func delete(from entity: String, with predicate: NSPredicate?)
    func fetchResults(from entity: String, with predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> [NSManagedObject]
    func deleteAll()
    func object(for anEntity: String) -> AnyObject
    func save()
}
