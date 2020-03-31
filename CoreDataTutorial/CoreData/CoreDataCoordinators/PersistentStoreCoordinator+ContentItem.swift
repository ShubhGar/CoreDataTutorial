//
//  PersistentStoreCoordinator+ContentItem.swift
//  CoreDataTutorial
//
//  Created by shubham Garg on 31/03/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import Foundation


extension PersistentStoreCoordinator{
    
    
    func fetchItems() -> [ContentItem] {
        return  self.persistentStoreAdapter?.fetchResults(from: Entity.ContentItem.rawValue, with: nil, sortDescriptor: nil) as? [ContentItem] ?? []
    }
    
    func createItem(withID id: String, name: String) throws {
        let item = self.persistentStoreAdapter?.object(for: Entity.ContentItem.rawValue) as? ContentItem
        item?.id = id
        item?.content_name = name
        self.persistentStoreAdapter?.save()
    }
}
