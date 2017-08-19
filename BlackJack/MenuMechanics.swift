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
        guard logoutButton.titleLabel?.text! == "Logout" else {
            handleCancel()
            return
        }
        do{
            try Auth.auth().signOut()
            print("User sucesfully logout")
            logout()
        }catch let error as NSError{
            print("Cant logout the user \(error)")
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
