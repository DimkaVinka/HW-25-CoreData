//
//  ContentView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    
    @State private var name = ""
    @State private var showModalView = false
    private var birthdateDate = Date()
    private var gendersIndex: Float = 0
        
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type your name here", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button {
                    guard !name.isEmpty else { return }
                    viewModel.addUser(name: name, birthdateDate: nil, gender: nil)
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
                    ForEach(viewModel.savedUsers) { user in
                        Button {
                            self.showModalView.toggle()
                        } label: {
                            Text(user.name ?? "NONAME")
                        }.sheet(isPresented: $showModalView) {
                            UserInfoView(user: user)
                        }
                    }.onDelete(perform: viewModel.deleteUser)
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
