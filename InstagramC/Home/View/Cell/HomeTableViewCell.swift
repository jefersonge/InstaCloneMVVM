//
//  PostagemTableViewCell.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 12/12/22.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var descriptionPost: UILabel!

    func setupCell(post: Dictionary<String, Any>) {

        let urlImage = post["url"] as? String ?? ""
        descriptionPost.text = post["descricao"] as? String ?? ""

        if !urlImage.isEmpty {
            imagePost.sd_setImage(with: URL(string: urlImage))
        }
    }
}
