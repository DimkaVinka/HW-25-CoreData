//
//  UserInfoView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @State var user: UserViewModel
    @State var viewModel: CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var isEdit = false
    
//    @State var name = ""
    
    @State private var birthdate = "Birthday"
//    @State var birthdateDate = Date()
    
    let gendersArray = ["Male", "Female", "Others"]
//    @State var gendersIndex: Float = 0
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.getAllUsers()
        }) {
            Image(systemName: "xmark")
        }
    }
    
    
    var body: some View {
        NavigationView {
            
            if self.isEdit == true {
                // РЕЖИМ РЕДАКТИРОВАНИЯ ИНФОРМАЦИИ
                VStack {
                    Image("EXKx77VHXm4")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipShape(Circle())
                        .padding()
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                            TextField("Type your name", text: $user.user.name.toUnwrapped(defaultValue: "NONAME"))
                        }
                        Divider()
                    }.padding()
                    VStack {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            TextField("Birthday", text: $birthdate)
                            DatePicker("", selection: $user.user.birthdate.toUnwrapped(defaultValue: .now), displayedComponents: .date)
                        }
                        
                        Divider()
                    }.padding()
                    VStack(alignment: .leading) {
                        HStack() {
                            Image(systemName: "person.2.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text("Gender")
                            Spacer()
                            Picker(selection: $user.user.gender, label: Text("Gender")) {
                                ForEach(0..<3) {
                                    Text(self.gendersArray[$0])
                                }
                            }
                        }
                        Divider()
                    }.padding()
                        Spacer()
                }
                
                // MARK: - Toolbar for Save
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        backButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack {
                            Button {
                                viewModel.getAllUsers()
                                self.isEdit.toggle()
                            } label: {
                                Text("Save")
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .frame(width: 90, height: 40, alignment: .center)
                                    }
                            }
                        }.padding()
                    }
                }
                
            } else if self.isEdit == false {
            // РЕЖИМ ОТОБРАЖЕНИЯ ИНФОРМАЦИИ
                VStack {
                    Image("EXKx77VHXm4")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipShape(Circle())
                        .padding()
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text(user.user.name ?? "NONAME")
                            Spacer()
                        }
                        Divider()
                    }.padding()
                    VStack {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text("\(birthdate)")
                            Spacer()
                            Text(user.user.birthdate ?? .now, format: Date.FormatStyle().day().month().year())
                        }
                        Divider()
                    }.padding()
                    VStack(alignment: .leading) {
                        HStack() {
                            Image(systemName: "person.2.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text("Gender")
                            Spacer()
                            Text(gendersArray[Int(user.user.gender)])
                        }
                        Divider()
                    }.padding()
                        Spacer()
                }
                
                // MARK: - Toolbar for Edit
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        backButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack {
                            Button {
                                self.isEdit.toggle()
                                viewModel.getAllUsers()
                            } label: {
                                Text("Edit")
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .frame(width: 90, height: 40, alignment: .center)
                                    }
                            }
                        }.padding()
                    }
                }
            }
                
        }.navigationBarBackButtonHidden(true)
        .accentColor(Color.gray)
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(user: UserViewModel(user: User()), viewModel: CoreDataViewModel())
    }
}
