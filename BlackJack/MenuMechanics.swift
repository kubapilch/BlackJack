//
//  MenuMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension ViewController {
    //Functions
    func handleLogout() {
        do{
            try Auth.auth().signOut()
            print("User sucesfully logout")
            logout()
        }catch let error as NSError{
            print("Cant logout the user \(error)")
        }
    }
    
    func handleHowToOrCancle() {
        if howToButton.titleLabel?.text == "How to play" {
            print("How to view")
        }else {
            handleCancel()
        }
    }
    
    func logout() {
        let loginView = LoginViewController()
        present(loginView, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
        }
    }
}
