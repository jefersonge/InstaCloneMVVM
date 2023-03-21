//
//  GalleryService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 20/03/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class GalleryService{
    
    // MARK: - Variables and Constants
    let firestore = Firestore.firestore()
    let auth = Auth.auth()
    static let shared = GalleryService()
    
    
    func requestPosts(user: Dictionary<String, Any>, onCompletion: @escaping(QuerySnapshot?, Error?)->Void) {
        guard let userSelected = user["id"] as? String else {return}
        //caminho para cada postagem
        firestore.collection("postagens")
            .document(userSelected)
            .collection("postagens_usuario")
            .getDocuments { snapshotResultado, error in
                if let snapshot = snapshotResultado {
                    onCompletion(snapshot, nil)
                } else {
                    onCompletion(nil, error)
                }
            }
    }
}

