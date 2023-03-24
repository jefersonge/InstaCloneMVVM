//
//  CadastroViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 06/12/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - References
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    // MARK: - Variables and Constants
    let viewModel: CadastroViewModel = CadastroViewModel()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func registerUser(_ sender: Any) {
        viewModel.registerUser(name: userName.text, email: userEmail.text, password: userPassword.text)
    }
    

    
}

