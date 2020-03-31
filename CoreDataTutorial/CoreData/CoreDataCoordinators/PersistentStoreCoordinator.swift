//
//  PersistentStoreCoordinator.swift
//  CoreDataTutorial
//
//  Created by shubham Garg on 31/03/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import Foundation



class PersistentStoreCoordinator: NSObject {
    static let shared = PersistentStoreCoordinator()
    var persistentStoreAdapter: PersistentStoreAdapter? = nil
    private override init() {
        super.init()
        self.configureCoreData(named: "OfflineVideo")
    }
    
    
    private func configureCoreData(named: String){
        CoreDataStack().create(with: named) { (adapter) in
            self.persistentStoreAdapter = adapter as? PersistentStoreAdapter
        }
    }
}


enum Entity:String{
    case ContentItem
}
