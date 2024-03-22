//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Shomil Singh on 22/03/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<User>{user in
        user.name.localizedStandardContains("s") &&
        user.city.localizedStandardContains("u")
    },
        sort: \User.name) var users : [User]
    @State private var path = [User]()
    var body: some View {
        NavigationStack(path: $path){
            List(users){user in
                NavigationLink("\(user.name)", value: user)
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self){user in
                EditUserView(user: user)
            }
            .toolbar{
                ToolbarItemGroup(placement : .topBarTrailing){
                    Button("Add user" , systemImage: "plus"){
                        let newUser = User(name: "", city: "", date: .now)
                        modelContext.insert(newUser)
                        path = [newUser]
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Add sample" , systemImage: "plus")
                    {
                        let sample1 = User(name: "Shomil", city: "Punjab", date: .now.addingTimeInterval(86400 * -10))
                        let sample2 = User(name: "Kushagra", city: "Gujrat", date: .now.addingTimeInterval(86400 * -5))
                        let sample3 = User(name: "Kushlendra", city: "Bihar", date: .now.addingTimeInterval(86400 * 10))
                        let sample4 = User(name: "Manav", city: "Kanpur", date: .now.addingTimeInterval(86400 * 5))
                        modelContext.insert(sample1)
                        modelContext.insert(sample2)
                        modelContext.insert(sample3)
                        modelContext.insert(sample4)
                        
                    }
                }
            }
        }
        
    
    }
    func addpeople(){
        let user1 = User(name: "first", city: "kanpur", date: .now)
        let user2 = User(name: "Second", city: "agra", date: .now)
        path = [user1 , user2]
    }
}

#Preview {
    ContentView()
}
