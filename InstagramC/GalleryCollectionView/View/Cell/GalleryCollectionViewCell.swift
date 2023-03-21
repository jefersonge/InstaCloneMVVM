//
//  GaleriaCollectionViewCell.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 13/12/22.
//

import UIKit
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionPost: UILabel!
    
    func setupCell(post: Dictionary<String, Any>) {

        let urlImage = post["url"] as? String ?? ""
        descriptionPost.text = post["descricao"] as? String ?? ""

        if !urlImage.isEmpty {
            image.sd_setImage(with: URL(string: urlImage))
        }
    }
}
