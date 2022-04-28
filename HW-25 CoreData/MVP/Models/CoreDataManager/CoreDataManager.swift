//
//  CoreDataManager.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "UsersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading container \(error.localizedDescription)")
            }
        }
    }
}
