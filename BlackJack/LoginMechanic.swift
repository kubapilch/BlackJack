//
//  LoginMechanic.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController {
    
    func checktextFields() {
        guard let password = passwordField.text, let mail = mailField.text else {return}
        Auth.auth().signIn(withEmail: mail, password: password) { (user, error) in
            if error != nil {
                //User ist login
                self.mailLine.backgroundColor = UIColor.red
                self.passwordLine.backgroundColor = UIColor.red
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
