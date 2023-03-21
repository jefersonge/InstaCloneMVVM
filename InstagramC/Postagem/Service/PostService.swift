//
//  SalvarPostageService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 20/03/23.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore


class PostService {
    
    // MARK: - Variables and Constants
    let storage = Storage.storage()
    let auth = Auth.auth()
    let firestore = Firestore.firestore()
    static let shared = PostService()
    
    func putPost(imageData: ImageData, descriptionPost: String, onCompletion: @escaping(Bool)->Void) {
        //criar pasta imagens
        let imagesFolder = storage.reference().child("imagens")
        //cruindo a pasta postagens e fazendo dentro dela o upload da imagemUpload ccompressa acima
        let imageToPost = imagesFolder.child("postagens").child(imageData.name)
        imageToPost.putData(imageData.imageUpload, metadata: nil) { metaData, error in
            if error == nil {
                //salvando postagem no banco de dados
                //recuperando url da imagem
                imageToPost.downloadURL { url, erro in
                    if let postedImageURL = url?.absoluteString {
                        //recuperando o usuario e apos isso o id
                        if let currentUser = self.auth.currentUser{
                            let currentUserId = currentUser.uid
                            //criando caminho no firestore
                            self.firestore
                                .collection("postagens")
                                .document(currentUserId)
                                .collection("postagens_usuario")
                            //adcionando dados recuperados(url e descricao)
                                .addDocument(data: [
                                    "descricao" : descriptionPost,
                                    "url" : postedImageURL
                                ]) { error in
                                    if error == nil {
                                        onCompletion(true)
                                        //fechar a tela de postagem
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

