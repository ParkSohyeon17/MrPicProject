//
//  UserListTableViewCell.swift
//  MrPicProject
//
//  Created by 박소현 on 2023/10/02.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCell: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func createUser(user: UserGenerator.User) {
        
        let url = URL(string: user.picture.large)
        profileImageView.kf.setImage(with: url)
        
        let name = user.name
        lbName.text = "\(name.first) \(name.last)"
        lbCell.text = user.cell
        lbEmail.text = user.email
    }
}
