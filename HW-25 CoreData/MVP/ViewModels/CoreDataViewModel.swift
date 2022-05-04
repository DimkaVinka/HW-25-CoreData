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
    @Published var savedEntities: [User] = []
    
    init() {
        container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR TO LOAD CD Container: \(error)")
            } else {
                print("Successfuly load core data!")
            }
        }
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<User>(entityName: "User")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func addUser(name: String, gender: String, date: String) {
        let newUser = User(context: container.viewContext)
        newUser.name = name
        newUser.gender = gender
        newUser.date = date
        saveData()
    }
    
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateUser(user: User, _ complitionHandler: @escaping ((User) -> Void)) {
        complitionHandler(user)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchUsers()
        } catch let error {
            print("Saving error: \(error)")
        }
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: date)
    }
    
    func convertStringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.date(from: string) ?? .now
    }
}


