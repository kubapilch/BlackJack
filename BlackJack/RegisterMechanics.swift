//
//  RegisterMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension RegisterViewController {

    fileprivate func loginUser() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
                print("Problem with registering the user, \(error!)")
                return
            }
            print("User sucesfully registered")
            guard let userId = user?.uid else {return}
            let ref = Database.database().reference().child("users").child(userId)
            ref.setValue(["Name":name,"Mail":mail,"HandsPlayed":"0","HandsWon":"0","MaxPointsTimes":"0","MaxWonStricke":"0","CurrentWonStricke":"0"])
            self.loginUser()
        }
        
    }
}
