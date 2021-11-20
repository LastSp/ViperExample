//
//  VIew.swift
//  Viper
//
//  Created by Андрей Колесников on 20.11.2021.
//

import Foundation
import UIKit

//User Interface
//VIewController
//protocol
//ref to presenter

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func updateWithUsers(with users:[User])
    func updateWithError(with error: String)
}

class UsersViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    var users = [User]()
    
    private let tableView: UITableView = {
        let tw = UITableView()
        tw.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tw.isHidden = true
        return tw
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(errorLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        errorLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        errorLabel.center = view.center
    }
    
    func updateWithUsers(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func updateWithError(with error: String) {
        print("Here")
        DispatchQueue.main.async {
            self.users = []
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
        }

    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user.name
        return cell
    }
    
    
}
