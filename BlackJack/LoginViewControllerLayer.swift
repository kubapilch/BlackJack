//
//  File.swift
//  BlackJack
//
//  Created by Kuba Pilch on 03.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension LoginViewController {
    
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
    
    private func setUpLoginButton() {
        self.view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordLine.bottomAnchor, constant: 57).isActive = true
    }
    
    private func seUpRegisterButton() {
        self.view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }
    
    func setUpButtons() {
        setUpLoginButton()
        seUpRegisterButton()
    }

    func addTextFields() {
        self.view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 60).isActive = true
    
        //Mail line 
        self.view.addSubview(mailLine)
        mailLine.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: 2).isActive = true
        mailLine.centerXAnchor.constraint(equalTo: mailField.centerXAnchor).isActive = true
    
        //Password text field
        self.view.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: mailLine.bottomAnchor, constant: 16).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: mailLine.centerXAnchor).isActive = true
    
        //Password line
        self.view.addSubview(passwordLine)
        passwordLine.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 2).isActive = true
        passwordLine.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor).isActive = true
    }
    
}
