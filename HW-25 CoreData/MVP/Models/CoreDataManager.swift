//
//  CoreDataManager.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 01.05.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func getUserByID(id: NSManagedObjectID) -> User? {
        do {
            return try viewContext.existingObject(with: id) as? User
        } catch {
            return nil
        }
    }
    
    func deleteUser(user: User) {
        viewContext.delete(user)
        save()
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "UsersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
