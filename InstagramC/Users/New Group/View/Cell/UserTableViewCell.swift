//
//  UserTableViewCell.swift
//  InstagramC
//
//  Created by Roberth Diorges Rodrigues on 26/12/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    func setupCell(user: Dictionary<String, Any>) {

        let name = user["nome"] as? String
        let email = user["email"] as? String

        title.text = name
        subTitle.text = email
    }
}
