//
//  LoginService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 26/12/22.
//

import Foundation
import FirebaseAuth

class LoginService {
    
    // MARK: - Variables and Constants
    let auth = Auth.auth()
    static let shared = LoginService()
    
    
    
    //Authentication
    func logInUser(email: String, password: String, onCompletion: @escaping (AuthDataResult?) -> Void) {
        auth.signIn(withEmail: email, password: password) {  usuario, erro in
            if erro == nil {
                onCompletion(usuario)
            }else {
                onCompletion(nil)
            }
        }
    }
    
    
    func loginAuto(onCompletion: @escaping (User?) -> Void) {
        //LOGIN AUTOMATICO
        auth.addStateDidChangeListener { auth, user in
            if user != nil {
                onCompletion(user)
            } else {
                onCompletion(nil)
            }
        }
    }
    
    
    func logout (onCompletion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            onCompletion(true)
        } catch  {
            onCompletion(false)
        }
    }
}


