//
//  UserViewModel.swift
//  MVVMExample
//
//  Created by Raphael Martin on 26/07/21.
//

import Foundation

enum UserValidationState {
    case Valid
    case Invalid(String)
}

class UserViewModel {
    private let minUsernameLength = 4
    private let minPasswordLength = 5
    private var user = User()
    
    var username: String {
        return user.username
    }
    
    var password: String {
        return user.password
    }
    
    var protectedUsername: String {
        if username.count >= minUsernameLength {
            var displayName = [Character]()
            for (index, character) in username.enumerated() {
                if index > username.count - minUsernameLength {
                    displayName.append(character)
                } else {
                    displayName.append("*")
                }
            }
            
            return String(displayName)
        }
        
        return username
    }
}

extension UserViewModel {
    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
    
    func validate() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            return .Invalid("Username and password are required")
        }
        
        if user.username.count < minUsernameLength {
            return .Invalid("Username needs to be at least \(minUsernameLength) characters long")
        }
        
        if user.password.count < minPasswordLength {
            return .Invalid("Password needs to be at least \(minPasswordLength) characters long")
        }
        
        return .Valid
    }
    
    func login(completion: (_ errorString: String?) -> Void) {
        LoginService.login(username: user.username, password: user.password) { success in
            if success {
                completion(nil)
            } else {
                completion("Invalid credentials")
            }
        }
    }
}
