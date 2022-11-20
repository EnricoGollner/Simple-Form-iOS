//
//  ContentView.swift
//  TrainingClone
//
//  Created by Enrico Gollner on 08/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var lastName = ""
    @State private var birthdate = only18s
    
    @State private var sendNews = false
    @State private var likes = 0
        
    @FocusState private var showKeyboard: Bool
    
    static var updatingDate: DateComponents {
        let currentDate = Date.now
        let components = Calendar.current.dateComponents([.day, .month], from: currentDate)
        
        return components
    }
    
    static var only18s: Date {
        var components = DateComponents()
        components.year = 2004
        components.month = updatingDate.month
        components.day = updatingDate.day
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Personal information")){
                    TextField("First Name", text: $name)
                        .focused($showKeyboard)
                    TextField("Last Name", text: $lastName)
                        .focused($showKeyboard)
                    DatePicker("Birthdate", selection: $birthdate, in: ...birthdate, displayedComponents: .date)
                }
                
                Section(header: Text("Actions")){
                    Toggle("Should send NewsLetter", isOn: $sendNews)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    
                    Stepper("Number of Likes", value: $likes, in: 1...100)
                    Text("This video has \(likes) \(likes == 1 ? "like" : "likes")")
                    Link("Terms of Service", destination: URL(string: "https://enricogollner.netlify.app/")!)
                }
            }
            .navigationTitle("Account")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: save)
                }
                
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        showKeyboard = false
                    }
                }
            }
        }
        .accentColor(.red)
    }
    func save(){
        print("saved")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
