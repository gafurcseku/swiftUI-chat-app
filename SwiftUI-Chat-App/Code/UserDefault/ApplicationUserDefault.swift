import Foundation

// Constants
let USER_TOKEN = "user_token"

// Struct to handle UserDefaults operations related to application settings
struct ApplicationUserDefault {
    
    // Set a boolean value in UserDefaults
    static func setBool(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize() // Ensure immediate synchronization
    }
    
    // Retrieve a boolean value from UserDefaults
    static func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    // Set a string value in UserDefaults
    static func setString(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize() // Ensure immediate synchronization
    }
    
    // Retrieve a string value from UserDefaults, returns an empty string if not found
    static func getString(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}



