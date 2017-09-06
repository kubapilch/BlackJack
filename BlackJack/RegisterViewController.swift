//
//  RegisterViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //
    //Variables
    //
    
    //Image Picker
    let imagePickerReference = UIImagePickerController()
    
    
    
    let imagePicker: UIImageView = {
        var customView = UIImageView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        customView.layer.cornerRadius = 40
        customView.clipsToBounds = true
        customView.contentMode = .scaleToFill
        customView.image = UIImage(named: "user")
        customView.layer.borderWidth = 0.5
        customView.layer.borderColor = UIColor.black.cgColor
        return customView
    }()
    
    let imageLine: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let backgroundView: UIView = {
        var customView = UIView()
        customView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 455).isActive = true
        return customView
    }()
    
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
    
    func test() {
        print("test")
    }
    
    func pickImage() {
        imagePickerReference.allowsEditing = true
        imagePickerReference.sourceType = .photoLibrary
    
        present(imagePickerReference, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkIfHasInternet() -> Bool {
        if Reachability.isConnectedToNetwork() {
            return true
        }else {
            SVProgressHUD.showError(withStatus: "Problemms with connection!")
            SVProgressHUD.setDefaultStyle(.light)
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                SVProgressHUD.dismiss()
            })
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackImageView()
        
        setUpBackView()
    
        addAllTextFieldsAndLines()
    
        addRegisterButton()
    
        addBackButton()
        
        SVProgressHUD.setDefaultStyle(.light)
        
        //Set delegates
        self.nameField.delegate = self
        self.mailField.delegate = self
        self.passwordField.delegate = self
        self.passwordFieldConfirm.delegate = self
        imagePickerReference.delegate = self
    }
}
