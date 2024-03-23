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
    @Query var users : [User]
    @State private var path = [User]()
    @State private var showingEveryone = true
    @State private var sortOrder = [SortDescriptor(\User.name) ,
                                    SortDescriptor(\User.date)]
    @State private var citySort = false
    var body: some View {
        NavigationStack(path: $path){
            
            UserView(minimumJoinDate: showingEveryone ? .distantPast : .now, sortOrder: sortOrder)
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
                        Button(showingEveryone ? "show upcoming" : "show all"){
                            showingEveryone.toggle()
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        Button("City"){
                            citySort.toggle()
                        }
                        Menu("Sort" , systemImage:"arrow.up.arrow.down"){
                            Picker("Sort" ,selection: $sortOrder){
                                Text("Sort by name")
                                    .tag([SortDescriptor(\User.name)])
                                Text("Sort by date")
                                    .tag([SortDescriptor(\User.date)])
                            }
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
