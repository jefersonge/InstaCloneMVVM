//
//  HomeViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 07/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - References
    @IBOutlet weak var tableViewPosts: UITableView!
    
    // MARK: - Variables and Constants
    let homeViewModel = HomeViewModel()
    let cellID = "cellPost"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeViewModel.loadPosts()
    }
}

// MARK: - UITableViewDataSource and Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //numero de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.posts.count
    }
    
    
    //configurando a celula e fazendo cast para PostagemTableViewCell para ter acesso as propriedades de foto e descricao
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let index = indexPath.row
        let post = homeViewModel.posts[index]
        cell.setupCell(post: post)
        return cell
    }
}

// MARK: - RecuperarPostagensUsuarioLogadoViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        tableViewPosts.reloadData()
    }
}
