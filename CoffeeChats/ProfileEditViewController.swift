//
//  ProfileEditViewController.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/30/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Text
    var instructionsTextView: UITextView!
    var nameTextField: UITextField!
    
    //Picker Views
    var classPicker: UIPickerView!
    var collegePicker: UIPickerView!
    var majorPicker: UIPickerView!
    
    //Picker View DataSources
    var classPickerDataSource: [String] = ["2020", "2021", "2022", "2023", "Graduate Student"]
    var collegePickerDataSource: [String] = ["College of Agriculture and Life Sciences", "College of Architecture, Art and Planning", "College of Arts and Sciences", "Cornell SC Johnson College of Business", "College of Engineering", "College of Human Ecology", "School of Industrial and Labor Relations (ILR)"]
    var majorPickerDataSource: [String] = ["Undecided", "Africana Studies", "Agricultural Sciences", "American Studies", "Animal Science", "Anthropology", "Applied Economics and Management", "Archaeology", "Architecture", "Asian Studies", "Astronomy", "Atmospheric Science", "Biological Engineering", "Biological Sciences", "Biology and Society", "Biomedical Engineering", "Biometry and Statistics", "Chemical Engineering", "Chemistry and Chemical Biology", "China and Asia-Pacific Studies", "Civil Engineering", "Classics (Classics, Classical Civ., Greek, Latin)", "College Scholar Program", "Communication", "Comparative Literature", "Computer Science", "Design and Environmental Analysis", "Development Sociology", "Earth and Atmospheric Sciences", "Economics", "Electrical and Computer Engineering", "Engineering Physics", "English", "Entomology", "Environmental and Sustainability Sciences", "Environmental Engineering", "Feminist, Gender & Sexuality Studies", "Fiber Science and Apparel Design", "Fine Arts", "Food Science", "French", "German Studies", "Global & Public Health Sciences", "Government", "History", "History of Architecture", "History of Art", "Hotel Administration", "Human Biology, Health and Society", "Human Development", "Independent Major - Arts and Sciences", "Independent Major - Engineering", "Industrial and Labor Relations", "Information Science", "Information Science, Systems, and Technology", "Interdisciplinary Studies", "International Agriculture and Rural Development", "Italian", "Landscape Architecture", "Linguistics", "Materials Science and Engineering", "Mathematics", "Mechnical Engineering", "Music", "Near Eastern Studies", "Nutritional Sciences", "Operations Research and Engineering", "Performing and Media Arts", "Philosophy", "Physics", "Plant Sciences", "Policy Analysis and Management", "Psychology", "Religious Studies", "Science and Technology Studies", "Sociology", "Spanish", "Statistical Science", "Urban and Regional Studies", "Viticulture and Enology"]
    
    //Profile Values
    var name: String = ""
    var image: UIImage = UIImage()
    var classOf: String = ""
    var college: String = ""
    var major: String = ""
    
    //Continue Logistics
    var finishChangesButton: UIButton!
    var fillAllFieldsAlert: UIAlertController!
    
//    override func viewWillAppear(_ animated: Bool) {
//        Backend.getProfile { (user) in
//            self.name = user.display_name
//            let imageURL = URL(string: user.image)!
//            let imageData = try! Data(contentsOf: imageURL)
//            self.image = UIImage(data: imageData)!
//            self.classOf = String(user.year)
//            self.college = user.college
//            self.major = user.major
//            self.setValues()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - UI Elements
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Enter your name"
        //nameTextField.text = "Gonzalo Gonzalez-Pumariega" //set by get
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(nameTextField)
        
        instructionsTextView = UITextView()
        instructionsTextView.isScrollEnabled = false
        instructionsTextView.isEditable = false
        instructionsTextView.text = "Edit Mode"
        instructionsTextView.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(instructionsTextView)
        
        classPicker = UIPickerView()
        classPicker.dataSource = self
        classPicker.delegate = self
        view.addSubview(classPicker)
        
        collegePicker = UIPickerView()
        collegePicker.dataSource = self
        collegePicker.delegate = self
        view.addSubview(collegePicker)
        
        majorPicker = UIPickerView()
        majorPicker.dataSource = self
        majorPicker.delegate = self
        view.addSubview(majorPicker)
        
        finishChangesButton = UIButton()
        finishChangesButton.setTitle("Finish Changes", for: .normal)
        finishChangesButton.setTitleColor(.red, for: .normal)
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
        instructionsTextView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(25)
            make.height.equalTo(35)
            make.centerX.equalTo(view)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(instructionsTextView).offset(40)
            make.height.equalTo(20)
            make.centerX.equalTo(view)
        }
        
        classPicker.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField).offset(100)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        collegePicker.snp.makeConstraints { (make) in
            make.top.equalTo(classPicker).offset(100)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        majorPicker.snp.makeConstraints { (make) in
            make.top.equalTo(collegePicker).offset(125)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
        }
        
        finishChangesButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-30)
            make.height.equalTo(30)
            make.centerX.equalTo(view)
        }
        
    }
    
    //Backend Function
    func setValues(){
        nameTextField.text = name
        classPicker.selectRow(classPickerDataSource.firstIndex(of: classOf)!, inComponent: 0, animated: true)
        collegePicker.selectRow(collegePickerDataSource.firstIndex(of: college)!, inComponent: 0, animated: true)
        majorPicker.selectRow(majorPickerDataSource.firstIndex(of: major)!, inComponent: 0, animated: true)
    }
    
    //MARK: - Picker View Protocol Stubs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classPicker{
            return classPickerDataSource.count
        } else if pickerView == collegePicker{
            return collegePickerDataSource.count
        } else{
            return majorPickerDataSource.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == classPicker{
            classOf = classPickerDataSource[row]
        } else if pickerView == collegePicker{
            college = collegePickerDataSource[row]
        } else{
            major = majorPickerDataSource[row]
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
        } else if pickerView == collegePicker{
            pickerLabel?.text = collegePickerDataSource[row]
        } else{
            pickerLabel?.text = majorPickerDataSource[row]
        }
        
        return pickerLabel!
    }
    
    //MARK: - Button Functions
    @objc func checkIfCanContinue(){
        name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (name == ""){
            present(fillAllFieldsAlert, animated: true, completion: nil)
        } else {
            //backend pushing and stuff
            dismiss(animated: true, completion: nil)
        }
    }
}
