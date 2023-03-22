//
//  GalleryCollectionViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 13/12/22.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {

    //criada para receber usuario atraves da segueGaleria passada pelo sender no perform e prepare da UsuariosViewController
    // MARK: - Variables and Constants
    var user: Dictionary<String, Any>!
    let viewModel = GalleryCollectionViewModel()
    let cellID = "galleryCell"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = (user["nome"] as? String ?? "") + " Postagens"
    }
    //ao aparecer tela galeria esconder tabbar
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadPosts(user: user)
    }
    //ao desaparecer tela galeria mostrae tabbar
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    //quantidade de itens
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    // MARK: - CollectionView
    //montagem da celula
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? GalleryCollectionViewCell else {return UICollectionViewCell()}

        //criando indice / numerando cada postagem da lista
        let index = indexPath.row
        let post = viewModel.posts[index]

        cell.setupCell(post: post)
        return cell
    }
}
// MARK: - GalleryCollectionViewModelDelegate
extension GalleryCollectionViewController: GalleryCollectionViewModelDelegate {
    
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
}
