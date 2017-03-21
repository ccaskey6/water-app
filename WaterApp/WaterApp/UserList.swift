//
//  UserList.swift
//  WaterApp
//
//  Created by Corey Caskey on 3/20/17.
//  Copyright © 2017 Corey Caskey. All rights reserved.
//

import UIKit

public final class UserList {
    
    private init() {
    }
    
    private static var userList = [String : User]()
    
    public static var currentUser : String = ""
    
    public static func addUser(u : User) -> Bool {
        if Array(userList.keys).contains(u.getName()) {
            return false
        }
        userList[u.getName()] = u
        return true
    }
    
    public static func getUserList() -> Dictionary<String, User> {
        return userList
    }
    
    public static func getUser(username : String) -> User {
        return userList[username]!
    }
    
    public static func getUserListValues() -> Array<User> {
        return Array(userList.values)
    }
    
    public static func setUserList(userDict : Dictionary<String, User>) {
        userList = userDict
    }
    
    public static func getUserListKeys() -> Array<String> {
        return Array(userList.keys)
    }
    
    public static func getValue(key : String) -> String {
        return userList[key]!.getPassword()
    }
    
    public static func setCurrentUser(name: String) {
        currentUser = name
    }
    
    public static func getCurrentUser() -> String {
        return currentUser
    }
}
