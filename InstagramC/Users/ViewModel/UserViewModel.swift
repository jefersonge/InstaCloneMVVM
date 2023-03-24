//
//  RecuperarUsuarios.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func reloadData()
}

class UserViewModel {
    
    // MARK: - Variables and Constants
    weak var delegate: UserViewModelDelegate?
    var users: [Dictionary<String, Any>] = []
    let service = UserService.shared
    
    func recuperarUsuarios() {
        //limpar lista de usuarios para evitar duplicatas e recarregar dados
        users.removeAll()
        delegate?.reloadData()
        service.requestUsers { snapshot, error in
            if let snapshot = snapshot {
                //varrendo cada document e adcionando a lista de usuarios
                for document in snapshot.documents {
                    let dataUser = document.data()
                    self.users.append(dataUser)
                }
                //apos varrer, recarregar os dados
                self.delegate?.reloadData()
            }
        }
    }

//METODO QUE PESQUISA USUARIOS
func searchUser(text: String) {
    let filterList: [Dictionary<String, Any>] = users
    users.removeAll()
    for item in filterList {
        if let name = item["nome"] as? String {
            if name.lowercased().contains(text.lowercased()) {
                self.users.append(item)
            }
        }
    }
    self.delegate?.reloadData()
}

}
