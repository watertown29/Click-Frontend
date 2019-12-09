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
    var refreshButton: UIButton!

    var students: [Student] = []

    let topStudentCellReuseIdentifier = "studentCellReuseIdentifier"
    let padding: CGFloat = 16
    let headerHeight: CGFloat = 30
    
    let defaults = UserDefaults.standard
    var myNetId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coffee Chats"
        view.backgroundColor = .white
        //self.navigationController?.navigationBar.isHidden = true
        let editButton   = UIBarButtonItem(title: "Edit You",  style: .plain, target: self, action: #selector(editButtonMethod))
        self.navigationItem.rightBarButtonItem = editButton
        
        myNetId = ""
        //find user's netId
        if let myNetId = defaults.string(forKey: "NetId") {
            
            self.myNetId = myNetId
        }
        
        loadStudents()


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
        
        refreshButton = UIButton()
        refreshButton.backgroundColor = .white
        refreshButton.addTarget(self, action: #selector(addItemButtonPressed), for: .touchUpInside)
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.setTitleColor(.systemBlue, for: .normal)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.addSubview(refreshButton)
        
        setupConstraints()
    }
    
    @objc func addItemButtonPressed(){
        self.topCollectionView.reloadData()
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
            refreshButton.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: padding),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])

    }

    //used to test UI
    
//    func loadStudents(){
//        NetworkManager.getAllUsers() { (students) in
//        self.students = students
//
//            DispatchQueue.main.async {
//                self.topCollectionView.reloadData()
//            }
//        }
//    }
    
    func loadStudents(){
        if (self.myNetId == "") {return}
        NetworkManager.getAllMatches(netid: self.myNetId) { (students) in
        self.students = students

            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topStudentCellReuseIdentifier, for: indexPath) as! StudentCollectionViewCell
        cell.configure(for: students[indexPath.row])
        return cell
    }
    

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 36)
        return CGSize(width: size, height: size)
    }
    
}

