//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Manjeet Kumar on 30/03/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tempCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func btnActionAddItem(_ sender: UIButton) {
        do {
            try PersistentStoreCoordinator.shared.createItem(withID: "ID \(tempCounter)", name: "Name \(Date().timeIntervalSince1970)")
            tempCounter += 1
        } catch {
            assertionFailure("Error Adding Item \(error)")
        }
    }
    
    @IBAction func btnActionPrintData(_ sender: UIButton) {
            let items = PersistentStoreCoordinator.shared.fetchItems()
            printItems(data: items)
    }
    
 
    
    func printItems(data: [ContentItem]) {
        for element in data {
            print("\(element.id ?? "") \(element.content_name ?? "") \(element.status)")
        }
    }
    
   
}

