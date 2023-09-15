//
//  TableViewCell.swift
//  summury
//
//  Created by Zuka Papuashvili on 14.09.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var labelText = UILabel()
    var labelAge = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // Configure the label's properties and constraints
        labelText.numberOfLines = 0
        labelText.translatesAutoresizingMaskIntoConstraints = false
        // Add the label as a subview to the cell's content view
        contentView.addSubview(labelText)
        
        labelAge.numberOfLines = 0
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelAge)
        
        NSLayoutConstraint.activate([
                    labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    labelText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                    labelText.heightAnchor.constraint(equalToConstant: 20),
                    
                    labelAge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    labelAge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    labelAge.topAnchor.constraint(equalTo: self.labelText.bottomAnchor, constant: 16),
                    labelAge.heightAnchor.constraint(equalToConstant: 20)
                ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
