//
//  SalvarPostagemService.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 24/12/22.
//

import Foundation

//
//  SalvarPostagemViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class LoginService: RequestService<LoginAPI> {
    
    func postAuthenticate(userName: String, password: String,
                            completion: @escaping (Result<User, Error>) -> Void) {
        execute(.authenticate, responseType: User.self, completion: completion)
    }
}

class SalvarPostagemService {
    
    // MARK: - Variables and Constants
    let storage = Storage.storage()
    let autenticacao = Auth.auth()
    let firestore = Firestore.firestore()
    
    var navigationPopView: (()-> Void)?

    func salvarPostagemFirebase(imagem: UIImage?, descricao: String?, completion: @escaping (Result<>)) {
        //criar pasta imagens
        let imagens = storage.reference().child("imagens")
        //recuperando imagem selecionada anteriomente pelo pickerview
        let imagemSelecionada = imagem
        //upload com compressao
        if let imagemUpload = imagemSelecionada?.jpegData(compressionQuality: 0.3) {
            //id da imagem(nome)
            let identificadorUnico = UUID().uuidString
            let nomeImagem = "\(identificadorUnico).jpg"
            //cruindo a pasta postagens e fazendo dentro dela o upload da imagemUpload ccompressa acima
            let imagemPostagemRef = imagens.child("postagens").child(nomeImagem)
            imagemPostagemRef.putData(imagemUpload, metadata: nil) { metaData, erro in
                if erro == nil {
                    print("Sucesso ao salvar imagem")
                    //salvando postagem no banco de dados
                    //recuperando url da imagem
                    imagemPostagemRef.downloadURL { url, erro in
                        if let urlImagem = url?.absoluteString {
                            //recuperando a descricao
                            if let descricao = descricao {
                                //recuperando o usuario e apos isso o id
                                if let usuarioLogado = self.autenticacao.currentUser {
                                    let idUsuario = usuarioLogado.uid
                                    //criando caminho no firestore
                                    self.firestore
                                        .collection("postagens")
                                        .document(idUsuario)
                                        .collection("postagens_usuario")
                                    //adcionando dados recuperados(url e descricao)
                                        .addDocument(data: [
                                            "descricao" : descricao,
                                            "url" : urlImagem
                                        ]) { erro in
                                            if erro == nil {
                                                print("Sucesso ao salvar postagem no firestore")
                                                //fechar a tela de postagem
                                                self.navigationPopView?()
                                            }
                                        }
                                }
                            }
                        }
                    }
                } else {
                    print("Erro ao salvar imagem")
                }
            }
        }
    }
}
