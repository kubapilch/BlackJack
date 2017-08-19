//
//  LoginViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 03.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

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
      
    let mailLine: UIView = {
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
    
    let loginButton: UIButton = {
        var but = UIButton()
        but.widthAnchor.constraint(equalToConstant: 274).isActive = true
        but.heightAnchor.constraint(equalToConstant: 45).isActive = true
        but.backgroundColor = UIColor(white: 1, alpha: 0.6)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Login", for: .normal)
        but.titleLabel?.font = UIFont(name: "Arial", size: 24)
        but.addTarget(self, action: #selector(checktextFields), for: .touchUpInside)
        return but
    }()
    
    let registerButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.backgroundColor = UIColor.clear
        var attrs = [NSUnderlineStyleAttributeName : 1,NSForegroundColorAttributeName : UIColor.lightGray] as [String : Any]
        var attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:"Not acount yet? Register now", attributes:attrs)
        attributedString.append(buttonTitleStr)
        but.setAttributedTitle(attributedString, for: .normal)
        but.addTarget(self, action: #selector(showRegisterView), for: .touchUpInside)
        return but
    }()
    
    func showRegisterView() {
        let registerView = RegisterViewController()
        present(registerView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackImageView()
    
        setUpBackView()
    
        addTextFields()
    
        setUpButtons()
    
        self.mailField.delegate = self
        self.passwordField.delegate = self
    }
}
