//
//  LoginService.swift
//  MVVMExample
//
//  Created by Raphael Martin on 26/07/21.
//

import Foundation

class LoginService {
    class func login(username: String, password: String, _ completion: (_ success: Bool) -> Void) {
        let correct_username = "admin"
        let correct_password = "123456"
        completion(username == correct_username && password == correct_password)
    }
    
    class func generateAccessCode() -> String {
        return randomString(length: 8)
    }
}
