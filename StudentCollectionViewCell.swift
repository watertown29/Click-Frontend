//
//  StudentCollectionViewCell.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/22/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
        
        var schoolImageView: UIImageView!
        var nameField: UILabel!
        var yearField: UILabel!

        override init(frame: CGRect) {
            super.init(frame: frame)

            schoolImageView = UIImageView()
            schoolImageView.translatesAutoresizingMaskIntoConstraints = false
            schoolImageView.contentMode = .scaleAspectFill
            schoolImageView.layer.masksToBounds = true
            contentView.addSubview(schoolImageView)
            
            nameField = UILabel()
            nameField.translatesAutoresizingMaskIntoConstraints = false
            nameField.textAlignment = .center
            contentView.addSubview(nameField)
            
            yearField = UILabel()
            yearField.translatesAutoresizingMaskIntoConstraints = false
            yearField.textAlignment = .center
            contentView.addSubview(yearField)
            
            setupConstraints()
        }

        func setupConstraints() {
            NSLayoutConstraint.activate([
                schoolImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                schoolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                schoolImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                schoolImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: schoolImageView.topAnchor, constant: 4),
            nameField.leadingAnchor.constraint(equalTo: schoolImageView.leadingAnchor, constant: 4),
            ])
            
            NSLayoutConstraint.activate([
            yearField.topAnchor.constraint(equalTo: schoolImageView.topAnchor, constant: 4),
            yearField.trailingAnchor.constraint(equalTo: schoolImageView.trailingAnchor, constant: -4),
            ])
        }
        
        func configure(for student: Student) {
            schoolImageView.image = UIImage(named: student.schoolImageName)
            nameField.text = student.name
            yearField.text = student.year
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
