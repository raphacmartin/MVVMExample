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
    private let codeRefreshTime = 5.0
    
    private var user = User() {
        didSet {
            self.username.value = user.username
            self.password.value = user.password
        }
    }
    
    var username: Box<String> = Box("")
    
    var password: Box<String> = Box("")
    
    var protectedUsername: String {
        if username.value.count >= minUsernameLength {
            var displayName = [Character]()
            for (index, character) in username.value.enumerated() {
                if index > username.value.count - minUsernameLength {
                    displayName.append(character)
                } else {
                    displayName.append("*")
                }
            }
            
            return String(displayName)
        }
        
        return username.value
    }
    
    var accessCode: Box<String?> = Box(nil)
    
    init(user: User = User()) {
        self.user = user
        startAccessCodeTimer()
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

private extension UserViewModel {
    func startAccessCodeTimer() {
        accessCode.value = LoginService.generateAccessCode()
        
        dispatch(after: 5.0) {
            self.startAccessCodeTimer()
        }
    }
}
