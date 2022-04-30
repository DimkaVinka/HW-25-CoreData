//
//  UserInfoViewModel.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedUsers: [User] = []
    
    init() {
        container = NSPersistentContainer(name: "UsersModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading container \(error.localizedDescription)")
            }
        }
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<User>(entityName: "User")
        
        do {
            savedUsers = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addUser(name: String, birthdateDate: Date?, gender: Float?) {
        let newUser = User(context: container.viewContext)
        newUser.name = name
        newUser.birthdate = birthdateDate
        newUser.gender = gender ?? 2
        
        saveUser()
    }
    
    func saveUser() {
        do {
            try container.viewContext.save()
            fetchUsers()
        } catch let error {
            print("error to save data: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedUsers[index]
        container.viewContext.delete(entity)
        saveUser()
    }
}
