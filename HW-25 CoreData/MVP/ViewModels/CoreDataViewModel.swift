//
//  UserInfoViewModel.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    var name: String = ""
    var birthdate: Date = .now
    var gender: Float = 2
    @Published var users: [UserViewModel] = []
    
    func save() {
        let user = User(context: CoreDataManager.shared.viewContext)
        user.name = name
        user.birthdate = birthdate
        user.gender = gender
        CoreDataManager.shared.save()
    }
    
    func getAllUsers() {
        users = CoreDataManager.shared.getAllUsers().map(UserViewModel.init)
    }
    
    func delete(_ user: UserViewModel) {
        let existingUser = CoreDataManager.shared.getUserByID(id: user.id)
        if let existingUser = existingUser {
            CoreDataManager.shared.deleteUser(user: existingUser)
        }
    }
}

struct UserViewModel {
    var user: User
    
    var id: NSManagedObjectID {
        return user.objectID
    }
    
    var name: String {
        return user.name ?? "NONAME"
    }
    
    var birthdate: Date {
        return user.birthdate ?? .now
    }
    
    var gender: Float {
        return user.gender
    }
}
