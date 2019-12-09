//
//  LoginViewController.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/29/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var welcomeLabel: UILabel!
    var instructionsLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmTextField: UITextField!
    var loginButton: UIButton!
    var accountButton: UIButton! // switches to login / signup mode
    var loginMode: Bool! // false implies signup mode

    var emptyFieldAlert: UIAlertController!
    var incorrectLoginInfoAlert: UIAlertController!
    var incorrectSignupInfoAlert: UIAlertController!
    var differentPasswordsAlert: UIAlertController!
    var successfulSignupAlert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

        //let purple = UIColor(red: 169/255, green: 113/255, blue: 214/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "Login Page"
        view.backgroundColor = .white

        loginMode = true
        
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to CoffeeChats"
        welcomeLabel.textColor = .brown
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        instructionsLabel = UILabel()
        instructionsLabel.text = "Sign-in or Sign-up below!"
        instructionsLabel.textColor = .black
        instructionsLabel.textAlignment = .center
        instructionsLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)

        emailTextField = UITextField()
        emailTextField.placeholder = " Enter your email"
        emailTextField.backgroundColor = .lightGray
        emailTextField.layer.cornerRadius = 5
        view.addSubview(emailTextField)

        passwordTextField = UITextField()
        passwordTextField.placeholder = " Enter your password"
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.layer.cornerRadius = 5
        view.addSubview(passwordTextField)

        confirmTextField = UITextField()
        confirmTextField.placeholder = " Confirm your password"
        confirmTextField.backgroundColor = .lightGray
        confirmTextField.layer.cornerRadius = 5
        confirmTextField.isHidden = true // only shows when in signup mode
        view.addSubview(confirmTextField)

        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.addTarget(self, action: #selector(loginPress), for: .touchDown)
        view.addSubview(loginButton)

        accountButton = UIButton()
        accountButton.setTitle("Click here to sign up!", for: .normal)
        accountButton.setTitleColor(.darkGray, for: .normal)
        accountButton.addTarget(self, action: #selector(switchMode), for: .touchDown)
        view.addSubview(accountButton)

        emptyFieldAlert = UIAlertController(title: "Empty fields",
                                            message: "Please fill out all fields before logging in",
                                            preferredStyle: .alert)
        emptyFieldAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

        incorrectLoginInfoAlert = UIAlertController(title: "Incorrect Login Information",
                                                    message: "Please enter a valid email and password",
                                                    preferredStyle: .alert)
        incorrectLoginInfoAlert.addAction(UIAlertAction(title: "Oops", style: .default, handler: nil))

        incorrectSignupInfoAlert = UIAlertController(title: "Incorrect Signup Information",
                                                    message: "Please enter a valid email that has not been used before",
                                                    preferredStyle: .alert)
        incorrectSignupInfoAlert.addAction(UIAlertAction(title: "Oops", style: .default, handler: nil))

        differentPasswordsAlert = UIAlertController(title: "Different passwords",
                                                message: "Your passwords are not the same",
                                                preferredStyle: .alert)
        differentPasswordsAlert.addAction(UIAlertAction(title: "Oops", style: .default, handler: nil))

        successfulSignupAlert = UIAlertController(title: "Signup Successful",
                                                  message: "You have successfully signed up for Impact! You can now log in.",
                                                  preferredStyle: .alert)
        successfulSignupAlert.addAction(UIAlertAction(title: "Great", style: .default, handler: nil))

        setupConstraints()
    }

    private func setupConstraints(){
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(135)
            make.centerX.equalToSuperview()
        }
        
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel).offset(45)
            make.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel).offset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(250)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(250)
        }

        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(250)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(250)
        }

        accountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
    }

    @objc func loginPress(){

        let email = emailTextField.text!
        let password = passwordTextField.text!

        if(email == "" || password == ""){
            self.present(self.emptyFieldAlert, animated: true)
            return
        }

        if(loginMode){

            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if error != nil {
                    self.present(self.incorrectLoginInfoAlert, animated: true)
                } else {

                    let viewController = ViewController()
                    self.navigationController?.pushViewController(viewController, animated: true)
                    print("First login")
                }
            }

        } else {

            if(password != confirmTextField.text){
                self.present(self.differentPasswordsAlert, animated: true)
                return
            }

            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error?.localizedDescription)
                    self.present(self.incorrectSignupInfoAlert, animated: true)
                } else {
                    self.present(self.successfulSignupAlert, animated: true)
                }

            }

        }

    }

    @objc func switchMode(){

        if(loginMode){
            passwordTextField.placeholder = " Create your password"
            loginButton.setTitle("Signup", for: .normal)
            accountButton.setTitle("Click here to login!", for: .normal)
            confirmTextField.isHidden = false
            loginButton.snp.remakeConstraints { make in
                make.top.equalTo(confirmTextField.snp.bottom).offset(75)
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
                make.width.equalTo(250)
            }
        } else {
            passwordTextField.placeholder = " Enter your password"
            loginButton.setTitle("Login", for: .normal)
            accountButton.setTitle("Click here to sign up!", for: .normal)
            confirmTextField.isHidden = true
            loginButton.snp.remakeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(75)
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
                make.width.equalTo(250)
            }
        }

        loginMode = !loginMode
    }

}
