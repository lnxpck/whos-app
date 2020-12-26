//
//  HomeTableViewCell.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 16/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with user: User) {

        nameLbl.text = "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        usernameLbl.text = "@\(user.login?.username ?? "")"
        locationLbl.text = "\(user.location?.postcode ?? 0), \(user.location?.city ?? "")"
        avatar.layer.cornerRadius = avatar.frame.height / 2
        if let _ = user.picture,  let thumbnail = user.picture!.thumbnail {
            if let url = URL(string: thumbnail) {
                avatar.kf.setImage(with: url)
            }
        }
    }
}
