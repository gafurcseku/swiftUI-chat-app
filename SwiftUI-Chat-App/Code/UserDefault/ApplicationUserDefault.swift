//
//  ApplicationUserDefault.swift
//  Qurais
//
//  Created by Md Abdul Gafur on 13/8/23.
//

import Foundation

let USER_TOKEN = "user_token"

struct ApplicationUserDefault {
    
    static func setBool(value:Bool, key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getBool(key:String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    static func setString(value:String, key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getString(key:String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
