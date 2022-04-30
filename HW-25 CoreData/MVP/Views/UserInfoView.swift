//
//  UserInfoView.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

struct UserInfoView: View {
    @State var user = User()
    @Environment(\.presentationMode) var presentationMode
    @State private var isEdit = false
    
    @State var name = ""
    
    @State private var birthdate = "Birthday"
    @State var birthdateDate = Date()
    
    let gendersArray = ["Male", "Female", "Others"]
    @State var gendersIndex: Float = 0
    
    var body: some View {
        NavigationView {
            
            if self.isEdit == true {
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
                            TextField("Type your name", text: $name)
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
                            DatePicker("", selection: $birthdateDate, displayedComponents: .date)
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
                            Picker(selection: $gendersIndex, label: Text("Gender")) {
                                ForEach(0..<gendersArray.count) {
                                    Text(self.gendersArray[$0])
                                }
                            }
                        }
                        Divider()
                    }.padding()
                        Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack {
                            Button {
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
                            Text(user.name ?? "")
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
                            Text(user.birthdate ?? Date(), format: Date.FormatStyle().day().month().year())
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
                            Text(gendersArray[Int(user.gender)])
                        }
                        Divider()
                    }.padding()
                        Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack {
                            Button {
                                self.isEdit.toggle()
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
        }
        .accentColor(Color.gray)
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
