//
//  RecuperaPostagem.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 17/12/22.
//

import Foundation

protocol GalleryCollectionViewModelDelegate: AnyObject {
    func collectionViewReloadData()
}

class GalleryCollectionViewModel {

    // MARK: - Variables and Constants
    var posts: [Dictionary<String, Any>] = []
    weak var delegate: GalleryCollectionViewModelDelegate?
    let service = GalleryService.shared

    func loadPosts(user: Dictionary<String, Any> ) {
        //limpar lista de postagens para evitar duplicatas e recarregar dados
        posts.removeAll()
        delegate?.collectionViewReloadData()
        service.requestPosts(user: user) { snapshot, error in
            if let snapshot = snapshot {
                //varrendo cada document e adcionando a lista de postagens
                for document in snapshot.documents {
                    let dataPost = document.data()
                    self.posts.append(dataPost)
                }
                //apos varrer, recarregar os dados
                self.delegate?.collectionViewReloadData()
            }
        }
    }
}

