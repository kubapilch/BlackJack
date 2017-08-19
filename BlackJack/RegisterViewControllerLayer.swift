//
//  RegisterViewControllerLayer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension RegisterViewController {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setUpBackImageView() {
        self.view.addSubview(backImage)
        backImage.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        backImage.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        backImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func setUpBackView() {
        self.view.addSubview(backgroundView)
        backgroundView.widthAnchor.constraint(equalToConstant: 312).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 359).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    func addBackButton() {
        self.view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
    }
    
    func addAllTextFieldsAndLines() {
        //Name textField
        self.view.addSubview(nameField)
        nameField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 35).isActive = true
        nameField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Name Line
        self.view.addSubview(nameLine)
        nameLine.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 2).isActive = true
        nameLine.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Mail field
        self.view.addSubview(mailField)
        mailField.topAnchor.constraint(equalTo: nameLine.bottomAnchor, constant: 20).isActive = true
        mailField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Mail line
        self.view.addSubview(mailLine)
        mailLine.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: 2).isActive = true
        mailLine.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Password field
        self.view.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: mailLine.bottomAnchor, constant: 20).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Password line
        self.view.addSubview(passwordLine)
        passwordLine.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 2).isActive = true
        passwordLine.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Confirm password field
        self.view.addSubview(passwordFieldConfirm)
        passwordFieldConfirm.topAnchor.constraint(equalTo: passwordLine.bottomAnchor, constant: 20).isActive = true
        passwordFieldConfirm.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        //Confirm password line
        self.view.addSubview(confirmPasswordLine)
        confirmPasswordLine.topAnchor.constraint(equalTo: passwordFieldConfirm.bottomAnchor, constant: 2).isActive = true
        confirmPasswordLine.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }
    
    func addRegisterButton() {
        self.view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: confirmPasswordLine.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }

}

