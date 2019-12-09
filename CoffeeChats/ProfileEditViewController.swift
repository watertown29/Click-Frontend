//
//  ProfileEditViewController.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/30/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let padding: CGFloat = 16
    
    //Text
    var nameLabel: UILabel!
    var nameTextField: UITextView!
    var netidLabel: UILabel!
    var netidTextField: UITextView!
    var interestsLabel: UILabel!
    var interestsTextView: UITextView!
    
    //Picker Views
    var classLabel: UILabel!
    var classPicker: UIPickerView!
    var collegeLabel: UILabel!
    var collegePicker: UIPickerView!
    
    //Picker View DataSources
    var classPickerDataSource: [String] = ["2020", "2021", "2022", "2023", "Graduate Student"]
    var collegePickerDataSource: [String] = ["College of Agriculture and Life Sciences", "College of Architecture, Art and Planning", "College of Arts and Sciences", "Cornell SC Johnson College of Business", "College of Engineering", "College of Human Ecology", "School of Industrial and Labor Relations (ILR)"]
    
    //Profile Values
    var name: String = ""
    var schoolNetId: String = ""
    var interest: String = ""
    var image: UIImage = UIImage()
    var classOf: String = ""
    var college: String = ""
    
    //Continue Logistics
    var finishChangesButton: UIButton!
    var fillAllFieldsAlert: UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - UI Elements
        
        nameLabel = UILabel()
        nameLabel.text = "Enter your name in the block below"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        
        nameTextField = UITextView()
        nameTextField.textAlignment = .center
        nameTextField.backgroundColor = .lightGray
        nameTextField.isEditable = true
        nameTextField.clipsToBounds = true;
        nameTextField.layer.cornerRadius = 10.0;
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(nameTextField)
        
        netidLabel = UILabel()
        netidLabel.text = "Enter your NetId in the block below"
        netidLabel.textColor = .black
        netidLabel.textAlignment = .center
        netidLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        netidLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netidLabel)
        
        netidTextField = UITextView()
        netidTextField.isScrollEnabled = false
        netidTextField.textAlignment = .center
        netidTextField.backgroundColor = .lightGray
        netidTextField.clipsToBounds = true;
        netidTextField.layer.cornerRadius = 10.0;
        netidTextField.isEditable = true
        netidTextField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(netidTextField)
        
        interestsLabel = UILabel()
        interestsLabel.text = "Enter ONE interest of yours in the block below"
        interestsLabel.textColor = .black
        interestsLabel.textAlignment = .center
        interestsLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(interestsLabel)
        
        interestsTextView = UITextView()
        interestsTextView.isScrollEnabled = false
        interestsTextView.textAlignment = .center
        interestsTextView.isEditable = true
        interestsTextView.backgroundColor = .lightGray
        interestsTextView.clipsToBounds = true;
        interestsTextView.layer.cornerRadius = 10.0;
        interestsTextView.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(interestsTextView)
        
        classLabel = UILabel()
        classLabel.text = "Scroll to select your grade"
        classLabel.textColor = .black
        classLabel.textAlignment = .center
        classLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(classLabel)
        
        classPicker = UIPickerView()
        classPicker.dataSource = self
        classPicker.delegate = self
        view.addSubview(classPicker)
        
        collegeLabel = UILabel()
        collegeLabel.text = "Scroll to select your school"
        collegeLabel.textColor = .black
        collegeLabel.textAlignment = .center
        collegeLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        collegeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collegeLabel)
        
        collegePicker = UIPickerView()
        collegePicker.dataSource = self
        collegePicker.delegate = self
        view.addSubview(collegePicker)
        
        finishChangesButton = UIButton()
        finishChangesButton.setTitle("Submit", for: .normal)
        finishChangesButton.setTitleColor(.white, for: .normal)
        finishChangesButton.backgroundColor = .systemBlue
        finishChangesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        finishChangesButton.addTarget(self, action: #selector(checkIfCanContinue), for: .touchUpInside)
        view.addSubview(finishChangesButton)
        
        fillAllFieldsAlert = UIAlertController(title: "Missing Information",
                                               message: "Please fill out all fields before continuing",
                                               preferredStyle: .alert)
        fillAllFieldsAlert.addAction(UIAlertAction(title: "Got it",
                                                   style: .default,
                                                   handler: nil))
        
        //Background
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel).offset(45)
            make.width.equalTo(250)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        interestsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField).offset(45)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        interestsTextView.snp.makeConstraints { (make) in
            make.top.equalTo(interestsLabel).offset(45)
            make.height.equalTo(35)
            make.width.equalTo(250)
            make.centerX.equalTo(view)
        }
        
        netidLabel.snp.makeConstraints { (make) in
            make.top.equalTo(interestsTextView).offset(45)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        netidTextField.snp.makeConstraints { (make) in
            make.top.equalTo(netidLabel).offset(45)
            make.height.equalTo(35)
            make.width.equalTo(250)
            make.centerX.equalTo(view)
        }
        
        classLabel.snp.makeConstraints { (make) in
            make.top.equalTo(netidTextField).offset(100)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        classPicker.snp.makeConstraints { (make) in
            make.top.equalTo(classLabel).offset(30)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        collegeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(classPicker).offset(100)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }

        collegePicker.snp.makeConstraints { (make) in
            make.top.equalTo(collegeLabel).offset(30)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        finishChangesButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-50)
            make.height.equalTo(30)
            make.width.equalTo(150)
            make.centerX.equalTo(view)
        }
        
    }
    
    //MARK: - Picker View Protocol Stubs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classPicker{
            return classPickerDataSource.count
        } else {
            return collegePickerDataSource.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == classPicker{
            classOf = classPickerDataSource[row]
        } else {
            college = collegePickerDataSource[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 14)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView == classPicker{
            pickerLabel?.text = classPickerDataSource[row]
        } else {
            pickerLabel?.text = collegePickerDataSource[row]
        }
        
        return pickerLabel!
    }
    
    func saveNetIdLocally() {
        let defaults = UserDefaults.standard
        //Set
        defaults.set(netidTextField.text, forKey: "NetId")
        print(defaults.string(forKey: "NetId")!)
    }
    
    //MARK: - Button Functions
    @objc func checkIfCanContinue(){
        name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        schoolNetId = netidTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        interest = interestsTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if (name == "" || schoolNetId == "" ){
            present(fillAllFieldsAlert, animated: true, completion: nil)
        } else {
            NetworkManager.createUser(name: name, netid: schoolNetId, year: classPickerDataSource[classPicker.selectedRow(inComponent: 0)], school: collegePickerDataSource[collegePicker.selectedRow(inComponent: 0)])
            saveNetIdLocally()
            NetworkManager.postNewInterests(netid: schoolNetId, interest_name: interest)
            dismiss(animated: true, completion: nil)
        }
    }
}
