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
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: Private properties
    private var viewModel = UserViewModel()
    private var user = User()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    // MARK: Controller Functions
    func authenticate() {
        switch viewModel.validate() {
        case .Valid:
            viewModel.login() { errorMessage in
                if let errorMessage = errorMessage {
                    self.displayErrorMessage(message: errorMessage)
                } else {
                    loginSuccess()
                }
            }
        case .Invalid(let error):
            displayErrorMessage(message: error)
        }
            
    }
    
    func displayErrorMessage(message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
    
    func loginSuccess () {
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    // MARK: Actions
    
    @IBAction func signIn(_ sender: Any) {
        authenticate()
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
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == usernameField {
            viewModel.updateUsername(username: newString)
        } else if textField == passwordField {
            viewModel.updatePassword(password: newString)
        }
        
        return true
    }
}
