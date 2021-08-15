//
//  UserDefaultsItems.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 14/8/21.
//

import Foundation

struct UserDefaultsItems {
    
    //create variable emailRegistered in UserDefault to save email is registered
    var emailRegistered: String {
        get {
            return UserDefaults.standard.string(forKey: "emailRegistered") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "emailRegistered")
        }
    }
    
}
