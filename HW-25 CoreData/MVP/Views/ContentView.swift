//
//  ContentView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    @State private var showModalView = false
    private var birthdateDate = Date()
    private var gendersIndex: Float = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User().entity, sortDescriptors: [NSSortDescriptor(key: "name", ascending: false)]) private var allUsers: FetchedResults<User>
    
    private func saveUser() {
        do {
            let user = User(context: viewContext)
            user.name = name
            user.birthdate = birthdateDate
            user.gender = gendersIndex
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteTask(at offset: IndexSet) {
        offset.forEach { index in
            let user = allUsers[index]
            viewContext.delete(user)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type your name here", text: $name)
                    .textFieldStyle(.roundedBorder)
                    
                    .padding()
                Button {
                    saveUser()
                } label: {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .padding(.horizontal)
                            Text("Press to add new user")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            
                        }
                        Spacer().frame(height: 20)
                    }
                }
                List {
                    
                    ForEach(allUsers) { user in
                        Button {
                            self.showModalView.toggle()
                        } label: {
                            Text(user.name ?? "ERROR DATA")
                        }.sheet(isPresented: $showModalView) {
                            UserInfoView(name: name, birthdateDate: birthdateDate, gendersIndex: gendersIndex)
                        }
                    }
                    
                    

                }
            }
            .navigationTitle(Text("Users"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
