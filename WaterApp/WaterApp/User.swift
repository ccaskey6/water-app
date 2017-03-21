//
//  User.swift
//  WaterApp
//
//  Created by Corey Caskey on 3/19/17.
//  Copyright © 2017 Corey Caskey. All rights reserved.
//

import UIKit

public class User {
    
    private var username = ""
    private var password = ""
    private var accountType: AccountType
    private var email = ""
    
    public init(username: String, password: String, accountType: AccountType) {
        self.username = username
        self.password = password
        self.accountType = accountType
    }
    
    public func getName() -> String {
        return self.username
    }
    
    public func getPassword() -> String {
        return self.password
    }
    
    public func getEmail() -> String {
        return self.email
    }
    
    public func getAccountType() -> AccountType {
        return self.accountType
    }
    
    public func setName(username: String) {
        self.username = username
    }
    
    public func setPassword(password: String) {
        self.password = password
    }
    
    public func setEmail(email: String) {
        self.email = email
    }
    
    public func setAccountType(accountType: AccountType) {
        self.accountType = accountType
    }
    
    public func toString() -> String {
        return "\(accountType)" + ": " + "\(username)"
    }
    
    
    
    
}
