//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Shomil Singh on 22/03/24.
//
import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user : User
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("Name", text: $user.name)
                    TextField("City" , text: $user.city)
                    DatePicker("Join date", selection: $user.date)
                }
            }
        }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Save"){
                    dismiss()
                }
            }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    do{
        let container = try ModelContainer(for: User.self, configurations: config)
        let newUser = User(name: "Demo", city: "Demo", date: .now)
        return EditUserView(user: newUser)
            .modelContainer(container)
    }catch{
        return Text("Failed")
    }
    
}
