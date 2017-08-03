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
    
    func addTextFields() {
        backgroundView.addSubview(eMailTextField)
        eMailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        eMailTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        eMailTextField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        eMailTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
    }
    
}
