//
//  HomeViewController.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 16/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var users: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        initTableView()

        let repo = UserRepository(userProvider: userProvider)
        
        repo.getUsers(at: 1) { result in
            switch result {
            case .success(let response):
                if let count = response.results?.count, count > 0 {
                    self.users = response.results!
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupUI() {
        self.navigationItem.title = "Who's App"
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.setup(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let vc = UserDetailsViewController()
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
