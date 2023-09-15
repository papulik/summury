//
//  ViewController.swift
//  summury
//
//  Created by Zuka Papuashvili on 13.09.23.
//

import UIKit

class ViewController: UIViewController {
    
    let customView = CustomView()
    let label = UILabel()
    let nextButton = UIButton(type: .system)
    
    let userDefaults = UserDefaults.standard
    
    var dummyData: [DummyData] = []
    var doubleArray: [[DummyData]] = [[]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        
        customView.addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        //Retrieving data from UserDefaults local storage.
        
        if let savedData = userDefaults.data(forKey: "dataSaved") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([[DummyData]].self, from: savedData) {
                doubleArray = decodedData
            }
        }
        
    }
    
    private func setupUI() {
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customView)
        
        label.text = "Welcome Too Knowladge Summury App"
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        nextButton.setTitle("Next Page ->", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = .darkGray
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 40),
            
            nextButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230),
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 85),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func alertUI(name: String) {
        let alert = UIAlertController(title: "Description", message: "name of this person is \(name)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    @objc func nextPage() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func add() {
        
        let name = customView.textField.text
        
        guard let age = customView.textField2.text, let age = Int(age) else {
            
            let alert = UIAlertController(title: "Invalid Decleration", message: "Age Value should be of type: INTIGER, Please try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
            
            return
        }
        
        let newPerson = DummyData(name: name!, age: age)
        dummyData.append(newPerson)
        
        customView.textField.text = ""
        customView.textField2.text = ""
        
        //MARK: - Seperate doubleArray by age.
        
        var sectionFound = false
            
            for (index, section) in doubleArray.enumerated() {
                if section.contains(where: { $0.age < 30 }) && newPerson.age < 30 {
                    doubleArray[index].append(newPerson)
                    sectionFound = true
                    break
                } else if section.contains(where: { $0.age >= 30 }) && newPerson.age >= 30 {
                    doubleArray[index].append(newPerson)
                    sectionFound = true
                    break
                }
            }
            
            if !sectionFound {
                doubleArray.append([newPerson])
            }
        
        // Saving data to UserDefaults
        if let encodedData = try? JSONEncoder().encode(doubleArray) {
            userDefaults.set(encodedData, forKey: "dataSaved")
        }
        
        customView.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        doubleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doubleArray[section].count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if doubleArray[section].isEmpty {
            return nil // Don't show a section header if it's empty
        } else {
            if doubleArray[section].first!.age < 30 {
                return "under 30"
            } else {
                return "over 30"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.selectionStyle = .default
        
        let nameText = doubleArray[indexPath.section][indexPath.row]
        let ageText = doubleArray[indexPath.section][indexPath.row]
        
        cell.backgroundColor = .clear
        
        cell.labelText.text = nameText.name
        cell.labelAge.text = String(ageText.age)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nameText = doubleArray[indexPath.section][indexPath.row].name
        
        alertUI(name: nameText)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                doubleArray[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                // After removing the item, you should also update your UserDefaults
                if let encodedData = try? JSONEncoder().encode(doubleArray) {
                    userDefaults.set(encodedData, forKey: "dataSaved")
                }
            }
    }
}

//Trying too push on github
