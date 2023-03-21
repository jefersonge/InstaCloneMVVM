//
//  RecuperarPostagensUsuarioLogadoViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeViewModel {
    
    // MARK: - Variables and Constants
    var posts: [Dictionary<String, Any>] = []
    weak var delegate: HomeViewModelDelegate?
    let service = HomeService.shared
    
    
    
    func loadPosts() {
        //limpar lista de postagens para evitar duplicatas e recarregar dados
        posts.removeAll()
        delegate?.reloadData()
        
        service.requestPosts { snapshot, error in
            if let snapshot = snapshot {
                //varrendo cada document e adcionando a lista de postagens
                for document in snapshot.documents {
                    let postData = document.data()
                    self.posts.append(postData)
                }
                //apos varrer, recarregar os dados
                self.delegate?.reloadData()
            }
        }
    }
}
