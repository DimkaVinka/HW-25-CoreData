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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type your name here", text: $name)
                    .textFieldStyle(.roundedBorder)
                    
                    .padding()
                Button {
                    
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
                    Button {
                        self.showModalView.toggle()
                    } label: {
                        Text("First")
                    }.sheet(isPresented: $showModalView) {
                        UserInfoView()
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
