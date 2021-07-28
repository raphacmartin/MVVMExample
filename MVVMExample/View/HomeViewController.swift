//
//  HomeViewController.swift
//  MVVMExample
//
//  Created by Raphael Martin on 28/07/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Logout"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
