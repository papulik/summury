//
//  PostsViewController.swift
//  summury
//
//  Created by Zuka Papuashvili on 15.09.23.
//

import UIKit

class PostsViewController: UIViewController {
    
    let tableView = UITableView()
    
    var user: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.reloadData()
        
        handleData()
        
        //        getUsers()
        
        //MARK: - Network Call Async Style
//        Task {
//            do {
//                self.user = try await Networking.shared.getData()
//                self.tableView.reloadData()
//            } catch {
//                print("Error fetching data: \(error)")
//            }
//        }
        
    }
    
        //MARK: - NetworkCall Oldschool Style.
//        func getUsers() {
    //            Networking.shared.getData { users in
    //                self.user = users
    //                self.tableView.reloadData()
    //            }
    //        }
    
    //MARK: - Saving Data too UserDefaults if it's not allready saved.
    
    func handleData() {
        // Check if data exists in UserDefaults
        if let userData = UserDefaults.standard.data(forKey: "userData") {
            // Data exists, load it
            if let users = try? JSONDecoder().decode([User].self, from: userData) {
                // Use the data
                self.user = users
                self.tableView.reloadData()
                return
            }
        }
        
        // Data doesn't exist in UserDefaults, make API call
        Task {
            do {
                let users = try await Networking.shared.getData()
                
                // Save data to UserDefaults
                if let encodedData = try? JSONEncoder().encode(users) {
                    UserDefaults.standard.set(encodedData, forKey: "userData")
                }
                
                // Use the data
                self.user = users
                self.tableView.reloadData()
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
}


extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let name = user[indexPath.row].name
        let userName = user[indexPath.row].username
        
        cell.labelText.text = name
        cell.labelAge.text = userName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
