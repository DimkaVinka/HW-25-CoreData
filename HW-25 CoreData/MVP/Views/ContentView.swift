//
//  ContentView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CoreDataViewModel()
    
    func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = viewModel.users[index]
            viewModel.delete(user)
        }
        viewModel.getAllUsers()
    }
        
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type your name here", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button {
                    guard !viewModel.name.isEmpty else { return }
                    viewModel.save()
                    viewModel.getAllUsers()
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
                    ForEach(viewModel.users, id: \.id) { user in
                        NavigationLink {
                            UserInfoView(user: user, viewModel: viewModel)
                        } label: {
                            Text(user.user.name ?? "NONAME")
                        }
                    }.onDelete(perform: deleteUser)
                }
            }
            .navigationTitle(Text("Users"))
        }.onAppear {
            viewModel.getAllUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
