//
//  LoginViewController.swift
//  MVVMExample
//
//  Created by Raphael Martin on 26/07/21.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: Private properties
    private var viewModel = UserViewModel()
    private var user = User()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Controller Functions
    func authenticate() {
        
    }
}

// MARK: Delegates
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameField {
            textField.text = viewModel.username
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameField {
            textField.text = viewModel.protectedUsername
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            authenticate()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == usernameField {
            viewModel.updateUsername(username: string)
        } else if textField == passwordField {
            viewModel.updatePassword(password: string)
        }
        
        return true
    }
}
