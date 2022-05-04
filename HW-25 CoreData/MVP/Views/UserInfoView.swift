//
//  UserInfoView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    let viewModel: CoreDataViewModel
    let user: User
    
    @State var date = Date()
    @State var textFieldText: String = ""
    @State var genderChoice: Int = 2
    let genderArray = ["Male", "Female", "Other"]
    
    var body: some View {
        NavigationView {
            
//            if self.isEdit == true {
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
                            TextField(user.name ?? "NO NAME", text: $textFieldText)
                        }
                        Divider()
                    }.padding()
                    VStack {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text(user.date ?? "NO DATE")
                            DatePicker("", selection: $date, displayedComponents: .date)
                        }
                        
                        Divider()
                    }.padding()
                    VStack(alignment: .leading) {
                        HStack() {
                            Image(systemName: "person.2.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            Text(user.gender ?? "NO GENDER")
                            Spacer()
                            Picker(selection: $genderChoice, label: Text("Gender")) {
                                ForEach(0..<3) {
                                    Text(self.genderArray[$0])
                                }
                            }
                        }
                        Divider()
                    }.padding()
                        Spacer()
                }
                
                // MARK: - Toolbar for Save
                
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        backButton
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        ZStack {
//                            Button {
//                                viewModel.getAllUsers()
//                                self.isEdit.toggle()
//                            } label: {
//                                Text("Save")
//                                    .padding()
//                                    .overlay {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.black, lineWidth: 2)
//                                            .frame(width: 90, height: 40, alignment: .center)
//                                    }
//                            }
//                        }.padding()
//                    }
//                }
                
//            } else if self.isEdit == false {
//            // РЕЖИМ ОТОБРАЖЕНИЯ ИНФОРМАЦИИ
//                VStack {
//                    Image("EXKx77VHXm4")
//                        .resizable()
//                        .frame(width: 200, height: 200, alignment: .center)
//                        .clipShape(Circle())
//                        .padding()
//                    VStack {
//                        HStack {
//                            Image(systemName: "person")
//                                .resizable()
//                                .frame(width: 25, height: 25, alignment: .center)
//                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
//                            Text(user.user.name ?? "NONAME")
//                            Spacer()
//                        }
//                        Divider()
//                    }.padding()
//                    VStack {
//                        HStack {
//                            Image(systemName: "calendar")
//                                .resizable()
//                                .frame(width: 25, height: 25, alignment: .center)
//                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
//                            Text("\(birthdate)")
//                            Spacer()
//                            Text(user.user.birthdate ?? .now, format: Date.FormatStyle().day().month().year())
//                        }
//                        Divider()
//                    }.padding()
//                    VStack(alignment: .leading) {
//                        HStack() {
//                            Image(systemName: "person.2.circle")
//                                .resizable()
//                                .frame(width: 25, height: 25, alignment: .center)
//                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
//                            Text("Gender")
//                            Spacer()
//                            Text(gendersArray[Int(user.user.gender)])
//                        }
//                        Divider()
//                    }.padding()
//                        Spacer()
//                }
//
//                // MARK: - Toolbar for Edit
//
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        backButton
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        ZStack {
//                            Button {
//                                self.isEdit.toggle()
//                                viewModel.getAllUsers()
//                            } label: {
//                                Text("Edit")
//                                    .padding()
//                                    .overlay {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.black, lineWidth: 2)
//                                            .frame(width: 90, height: 40, alignment: .center)
//                                    }
//                            }
//                        }.padding()
//                    }
//                }
            }
            .accentColor(Color.gray)
            .onDisappear {
                viewModel.updateUser(user: user) { user in
                    if !textFieldText.isEmpty {
                        user.name = textFieldText
                    }
                    if viewModel.convertDateToString(date: date) != viewModel.convertDateToString(date: Date.now) {
                        user.date = viewModel.convertDateToString(date: date)
                    }
                    if user.gender == genderArray[2] {
                        user.gender = genderArray[genderChoice]
                    }
                }
            }
        }
        
    }


struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: CoreDataViewModel(), user: User())
    }
}
