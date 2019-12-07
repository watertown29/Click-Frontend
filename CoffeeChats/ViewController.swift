//
//  ViewController.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/22/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topCollectionView: UICollectionView!
    var bottomCollectionView: UICollectionView!
    
    var students: [Student] = []
    var studentGroup: [Student] = []
    var paula: Student!
    var steven: Student!

    let topStudentCellReuseIdentifier = "studentCellReuseIdentifier"
    let bottomStudentCellReuseIdentifier = "studentCellReuseIdentifier"
    let padding: CGFloat = 16
    let headerHeight: CGFloat = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coffee Chats"
        view.backgroundColor = .white
        //self.navigationController?.navigationBar.isHidden = true
        let editButton   = UIBarButtonItem(title: "Edit You",  style: .plain, target: self, action: #selector(editButtonMethod))
        self.navigationItem.rightBarButtonItem = editButton
        
        
        // Create Person objects
        paula = Student(schoolImageName: "cals", name: "Paula", year: "Freshmen")
        steven = Student(schoolImageName: "ilr", name: "Steven", year: "Junior")
        students = [paula, steven, paula, steven, paula, paula, paula, steven]
        studentGroup = [paula, paula, paula, paula, paula, paula, paula, paula]

        // TODO: Setup topCollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.backgroundColor = .white
        topCollectionView.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: topStudentCellReuseIdentifier)
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        
        view.addSubview(topCollectionView)
        
        // TODO: Setup bottomCollectionView
        let bLayout = UICollectionViewFlowLayout()
        bLayout.scrollDirection = .horizontal
        bLayout.minimumLineSpacing = padding
        bLayout.minimumInteritemSpacing = padding
        
        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: bLayout)
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.backgroundColor = .white
        bottomCollectionView.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: bottomStudentCellReuseIdentifier)
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        
        view.addSubview(bottomCollectionView)
        
        setupConstraints()
    }
    
    @objc func editButtonMethod() -> Void {
        let profileController = ProfileEditViewController()
       self.navigationController?.pushViewController(profileController, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            topCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            bottomCollectionView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: padding),
            bottomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottomCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bottomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.topCollectionView){
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topStudentCellReuseIdentifier, for: indexPath) as! StudentCollectionViewCell
        cell.configure(for: students[indexPath.row])
        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomStudentCellReuseIdentifier, for: indexPath) as! StudentCollectionViewCell
            cell.configure(for: studentGroup[indexPath.row])
            return cell
        }
    }
    

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 36)
        return CGSize(width: size, height: size)
    }
    
}

