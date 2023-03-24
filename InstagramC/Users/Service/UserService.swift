//
//  UsuariosService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 20/03/23.
//

import Foundation
import Foundation
import FirebaseFirestore

class UserService {
    
    // MARK: - Variables and Constants
    let firestore = Firestore.firestore()
    static let shared = UserService()
    
    func requestUsers(onConpletion: @escaping(QuerySnapshot?, Error?)->Void) {
        //caminho para cada postagem
        firestore.collection("usuarios").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                onConpletion(snapshot, nil)
            } else {
                onConpletion(nil, error)
            }
        }
    }
}
