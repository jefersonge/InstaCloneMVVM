//
//  UsuariosViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 07/12/22.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - References
    @IBOutlet weak var searchBarUsers: UISearchBar!
    @IBOutlet weak var tableViewUsers: UITableView!
    
    // MARK: - Variables and Constants
    var viewModel = UserViewModel()
    let segueGallery = "gallerySegue"
    let cellUser = "cellUser"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableViewUsers.delegate = self
        tableViewUsers.dataSource = self
        searchBarUsers.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.recuperarUsuarios()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueGallery {
            let vc = segue.destination as! GalleryCollectionViewController
            vc.user = sender as? Dictionary
        }
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellUser, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        let user = viewModel.users[index]
        
        cell.setupCell(user: user)
        
        return cell
    }
    
    //RECUPERANDO LINHA CLICADA, PARA RECUPERAR O USUARIO E ENVIAR PARA A PROXIMA TELA
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewUsers.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        let user = viewModel.users[index]
        performSegue(withIdentifier: segueGallery, sender: user)
    }
}

extension UserViewController: UISearchBarDelegate {
    //AO PRESSIONAR O BOTAO PESQUISA
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if searchText != ""{
                viewModel.searchUser(text: searchText)
            }
        }
    }
    
    //se limpar a pesquisa recuperaUsuarios da lista - do firestore no caso
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.recuperarUsuarios()
        }
    }
}

extension UserViewController: UserViewModelDelegate {
    func reloadData() {
        tableViewUsers.reloadData()
    }
}
