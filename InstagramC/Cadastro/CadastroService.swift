//
//  CadastroService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 20/03/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct CadastroService {
    
    let auth = Auth.auth()
    let firestore = Firestore.firestore()
    static let shared = CadastroService()
    
    func registerUser(name: String, email: String, password: String, onCompletion: @escaping (AuthDataResult?, Error?)-> Void) {
        auth.createUser(withEmail: email, password: password) { userData, error in
            if error == nil {
                onCompletion(userData, nil)
                if let userID = userData?.user.uid {
                    //salvar dados do usurio no firestore criando o caminho abaixo
                    self.firestore.collection("usuarios")
                        .document(userID)
                        .setData([
                            "nome" : name,
                            "email" : email,
                            "id" : userID
                        ])
                }
            }else {
                onCompletion(nil, error)
            }
        }
    }
    
}
