//
//  ContentView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
//    @State var birthday: Date = .now
//    @State var date: String = "01.04.1976"
//    @State var gender = "Other"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Print your name here", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 50)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addUser(name: textFieldText, gender: "Other", date: "01.04.1976")
                    textFieldText = ""
                } label: {
                    Text("Press")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }.padding(.horizontal)
                List {
                    ForEach(vm.savedEntities) { user in
                        HStack {
                            Text(user.name ?? "NONAME")
                            NavigationLink {
                                UserInfoView(viewModel: vm, user: user)
                            } label: {
                                
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteUser)
                }
                .listStyle(InsetGroupedListStyle())
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
