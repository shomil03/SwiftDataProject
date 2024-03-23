//
//  UserView.swift
//  SwiftDataProject
//
//  Created by Shomil Singh on 23/03/24.
//
import SwiftData
import SwiftUI

struct UserView: View {
    @Query var users : [User]
    var body: some View {
        List(users){user in
            NavigationLink("\(user.name)", value: user)
        }
    }
    init(sortOrder : [SortDescriptor<User>]){
        _users = Query(filter: #Predicate<User>{user in
            user.name.localizedStandardContains("k")
        }, sort: sortOrder)
    }
    init(minimumJoinDate : Date ,sortOrder : [SortDescriptor<User>]){
        _users = Query(filter: #Predicate<User>{user in
            user.date >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UserView(minimumJoinDate: .now , sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
