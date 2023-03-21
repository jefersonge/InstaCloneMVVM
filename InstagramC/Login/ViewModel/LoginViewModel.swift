//
//  LoginAutoViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Variables and Constants
    var performSegueClosure: (()-> Void)?
    let service = LoginService.shared
    
    
    //MARK: - Methods
    
    
    func loginWithUserEmailAndPassword(email: String?, password: String?){
        if let email = email , let password = password {
                service.logInUser(email: email, password: password) { user in
                }
            }
        }
    
    func loginAuto() {
        service.loginAuto { user in
            if user != nil {
                self.performSegueClosure?()
            }
        }
    }

    func logout () {
        service.logout { success in
        }
    }
}

