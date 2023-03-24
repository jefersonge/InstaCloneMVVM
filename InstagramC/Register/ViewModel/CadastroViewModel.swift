//
//  CadastrarViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation

class CadastroViewModel {
    
    // MARK: - Variables and Constants
    let service = CadastroService.shared
    
    //MARK: - Methods
    func registerUser(name: String?, email: String?, password: String?) {
        if let name = name {
            if let email = email {
                if let password = password {
                    service.registerUser(name: name, email: email, password: password) { user, error in
                        if user != nil {
                            print("Cadastro de usuario concluido: \(String(describing: user?.user.email))")
                        }else {
                            print("Erro no cadastro: \(String(describing: error))")
                        }
                    }
                }
            }
        }
    }
}

