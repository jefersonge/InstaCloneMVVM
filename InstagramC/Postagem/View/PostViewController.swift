//
//  PostagemViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 08/12/22.
//

import UIKit


//Aderir a UIImagePickerControllerDelegate, UINavigationControllerDelegate para uso do imagePicker
class PostViewController: UIViewController {
    
    // MARK: - References
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionPost: UITextField!
    
    //criamos o imagePicker que é UIImagePickerController instaciada
    // MARK: - Variables and Constants
    var imagePicker = UIImagePickerController()
    let viewModel = PostViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //o delegate do imagepicker
        imagePicker.delegate = self
        viewModel.delegate = self
        image.image = UIImage(named: "padrao")
    }
    // MARK: - Actions
    @IBAction func selectImage(_ sender: Any) {
        //criando o imagepicker, seletor de imagem
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func savePost(_ sender: Any) {
        guard descriptionPost.text != "" else {return descriptionPost.placeholder = "Selecione uma imagem e uma legenda!"}
        guard image.image != UIImage(named: "padrao") else{return descriptionPost.placeholder = "Selecione uma imagem e uma legenda!"}
        viewModel.savePost(image: image.image, descriptionPost: descriptionPost.text)
    }
}

// MARK: - UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension PostViewController: UIImagePickerControllerDelegate,
                                   UINavigationControllerDelegate {
    
    //metodo que recupera a imagem selecionada
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let imagePick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        //apos recuperar a imagem selecionada jogamos ela no nosso image view imagem
        self.image.image = imagePick
        //fechar a tela apos selecionar a imagem
        imagePicker.dismiss(animated: true)
    }
}

// MARK: - SalvarPostagemViewModelDelegate
extension PostViewController: PostViewModelDelegate {
    
    func navigationPopView() {
        self.navigationController?.popViewController(animated: true)
    }
}
