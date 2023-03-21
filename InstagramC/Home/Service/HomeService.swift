//
//  HomeService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 20/03/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomeService {
    
    // MARK: - Variables and Constants
    let firestore = Firestore.firestore()
    let auth = Auth.auth()
    static let shared = HomeService()
    
    func requestPosts(onCompletion: @escaping(QuerySnapshot?, Error?)->Void) {
    guard let currentUser = auth.currentUser?.uid else {return}
        
        //caminho para cada postagem
        firestore.collection("postagens")
            .document(currentUser)
            .collection("postagens_usuario")
            .getDocuments { snapshot, erro in
                if let snapshot = snapshot {
                    onCompletion(snapshot, nil)
                } else {
                    onCompletion(nil, erro)
                }
            }
    }
}
