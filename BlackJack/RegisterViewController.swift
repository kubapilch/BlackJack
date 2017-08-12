//
//  RegisterViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let backButton: UIButton = {
        var but = UIButton()
        but.setTitle("<-- Back", for: .normal)
        but.backgroundColor = UIColor.clear
        but.setTitleColor(UIColor.white, for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.widthAnchor.constraint(equalToConstant: 100).isActive = true
        but.heightAnchor.constraint(equalToConstant: 50).isActive = true
        but.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return but
    }()

    let registerButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.widthAnchor.constraint(equalToConstant: 274).isActive = true
        but.heightAnchor.constraint(equalToConstant: 45).isActive = true
        but.backgroundColor = UIColor(white: 1, alpha: 0.6)
        but.setTitle("Register", for: .normal)
        but.titleLabel?.font = UIFont(name: "Arial", size: 24)
        but.addTarget(self, action: #selector(checkTextFields), for: .touchUpInside)
        return but
    }()
    
    let nameLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 256).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let confirmPasswordLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 256).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let passwordLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 256).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let mailLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 256).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let nameField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 256).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.textColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName: UIColor.lightGray,NSFontAttributeName :UIFont(name: "Arial", size: 18)!])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        return textField
    }()
    
    let passwordField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 256).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.textColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray,NSFontAttributeName :UIFont(name: "Arial", size: 18)!])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let mailField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 256).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.textColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSForegroundColorAttributeName: UIColor.lightGray,NSFontAttributeName :UIFont(name: "Arial", size: 18)!])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        return textField
    }()
    
    let passwordFieldConfirm: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 256).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.textColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray,NSFontAttributeName :UIFont(name: "Arial", size: 18)!])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let backgroundView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "list")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let backImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "menuBackgroundImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkTextFields() {
        guard let name = nameField.text, let mail = mailField.text, let password = passwordField.text, let confirmPassword = passwordFieldConfirm.text else {return}
        if password != confirmPassword {
            passwordLine.backgroundColor = UIColor.red
            confirmPasswordLine.backgroundColor = UIColor.red
            return
        }
        Auth.auth().createUser(withEmail: mail, password: password) { (user, error) in
            if error != nil {
                print("Problem with registering the user")
                return
            }
            print("User sucesfully registered")
            guard let userId = user?.uid else {return}
            let ref = Database.database().reference().child("users").child(userId)
            ref.setValue(["Name":name,"Mail":mail])
            self.loginUser()
        }
        
    }
    
    func loginUser() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBackImageView()
        
        setUpBackView()
    
        addAllTextFieldsAndLines()
    
        addRegisterButton()
    
        addBackButton()
    
        self.nameField.delegate = self
        self.mailField.delegate = self
        self.passwordField.delegate = self
        self.passwordFieldConfirm.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
