//
//  LoginViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 06/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - References
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    // MARK: - Variables and Constants
    let loginViewModel: LoginViewModel = LoginViewModel()
    let segueAutoLogin = "autoLogin"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.loginAuto()
        bindActions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func bindActions() {
        loginViewModel.performSegueClosure = { [weak self] in
            self?.performSegue(withIdentifier: self!.segueAutoLogin, sender: nil)
        }
    }
    
    //LOGOUT AO CLICAR EM SAIR
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        loginViewModel.logout()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        loginViewModel.loginWithUserEmailAndPassword(email: userEmail.text, password: userPassword.text)
    }
    
 
}
