//
//  UserDetailsViewController.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 20/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import UIKit
import Eureka

class UserDetailsViewController: FormViewController {

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        avatar.layer.cornerRadius = avatar.frame.height / 2
        if let _ = user.picture,  let thumbnail = user.picture!.large {
            if let url = URL(string: thumbnail) {
                avatar.kf.setImage(with: url)
            }
        }

        form +++ Section() { section in
                section.header = {
                    let header = HeaderFooterView<UserLogoView>(.callback({
                        let view = UserLogoView(url: self.user.picture?.large)
                        return view
                    }))
                    return header
                }()
            }
            +++ Section("Informations")
                <<< TextRow(){ row in
                    row.title = "Title"
                    row.value = user.name?.title ?? ""
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "First Name"
                    row.value = user.name?.first ?? ""
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Last Name"
                    row.value = user.name?.last ?? ""
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Age"
                    row.value = "\(user.registered?.age ?? 0) years"
                    row.disabled = true
                }
            +++ Section("Address")
                <<< TextRow(){ row in
                    row.title = "City"
                    row.value = user.location?.city ?? ""
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Postcode"
                    row.value = "\(user.location?.postcode ?? 0)"
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Country"
                    row.value = user.location?.country
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Location"
                    let latitude = user.location?.coordinates.latitude ?? ""
                    let longitude = user.location?.coordinates.longitude ?? ""
                    row.value = "\(latitude) / \(longitude)"
                    row.disabled = true
                    row.onCellSelection({ (cell, row) in
                        print("click...")
                        let vc = MapViewController()
                        vc.user = self.user
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
            +++ Section("Contacts")
                <<< TextRow(){ row in
                    row.title = "Email"
                    row.value =  user.email ?? ""
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Username"
                    row.value = "@\(user.login?.username ?? "")"
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Phone"
                    row.value = user.phone
                    row.disabled = true
                }
                <<< TextRow(){ row in
                    row.title = "Mobile"
                    row.value = user.cell
                    row.disabled = true
                }
    }
}

class UserLogoView: UIView {
    
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(url: String?) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 150)
        
        if let _ = url {
            addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let url = URL(string: url!)
            imageView.kf.setImage(with: url)
            
            imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 60
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
