//
//  SalvarPostagemViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation
import UIKit

protocol PostViewModelDelegate: AnyObject {
    func navigationPopView()
}

class PostViewModel {
    
    // MARK: - Variables and Constants
    weak var delegate: PostViewModelDelegate?
    let service = PostService.shared
    
    
    func savePost(image: UIImage?, descriptionPost: String?) {
        if let image = image, let imageUpdloadData = image.jpegData(compressionQuality: 0.3){
            let unicID = UUID().uuidString
            let imageName = "\(unicID).jpg"
            //instancia do Model
            let imageData = ImageData(name: imageName, imageUpload: imageUpdloadData)
            if let descriptionPost = descriptionPost {
                        service.putPost(imageData: imageData, descriptionPost: descriptionPost) { success in
                            if success{
                                self.delegate?.navigationPopView()
                            }
                        }
                    }
                }
            }
        }

