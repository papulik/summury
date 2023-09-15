//
//  CustomView.swift
//  summury
//
//  Created by Zuka Papuashvili on 14.09.23.
//

import UIKit

class CustomView: UIView {
    
    let tableView = UITableView()
    let textField = UITextField()
    let textField2 = UITextField()
    let addButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        backgroundColor = .gray
        
        addButton.setTitle("", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .darkGray
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addButton.layer.cornerRadius = 11
        addButton.setImage(.add.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        //            addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(addButton)
        
        textField.placeholder = " Add Person name:"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField)
        
        textField2.placeholder = " Add Person age:"
        textField2.backgroundColor = .white
        textField2.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField2)
        
        tableView.backgroundColor = .darkGray
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            //MARK: - tableView constraints:
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: 550),
            
            //MARK: - textField constraints:
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 125),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            //MARK: - textField2 constraints:
            textField2.topAnchor.constraint(equalTo: topAnchor, constant: 175),
            textField2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField2.heightAnchor.constraint(equalToConstant: 30),
            textField2.widthAnchor.constraint(equalToConstant: 300),
            
            //MARK: - addButton constraints:
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 145),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}
