//
//  LoginMechanic.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension LoginViewController {
    
    func checktextFields() {
        guard let password = passwordField.text, let mail = mailField.text else {return}
        
        //Check connection
        let connection = checkIfHasInternet()
        guard connection == true else{return}
        
        Auth.auth().signIn(withEmail: mail, password: password) { (user, error) in
            if error != nil {
                //User isnt login
                self.mailLine.backgroundColor = UIColor.red
                self.passwordLine.backgroundColor = UIColor.red
                return
            }
            let uid = user?.uid
            
            self.getUserInfoFromDatabase(uid: uid!)
        }
    }
    
    func resetPassword() {
        guard let mail = mailField.text, mailField.text != "" else{
            mailLine.backgroundColor = UIColor.red
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.mailLine.backgroundColor = UIColor.white
            })
            return
        }
        Auth.auth().sendPasswordReset(withEmail: mail) { (error) in
            if error != nil{
                print(error!)
                SVProgressHUD.showError(withStatus: "Can't send an email")
                let time = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: time, execute: {
                    SVProgressHUD.dismiss()
                })
                return
            }
            print("Succesflully send an email")
            SVProgressHUD.showSuccess(withStatus: "Email has been send!")
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                SVProgressHUD.dismiss()
            })
        }
    }
    
    
    fileprivate func getUserInfoFromDatabase(uid:String) {
        SVProgressHUD.show(withStatus: "Logging in...")
        SVProgressHUD.setDefaultStyle(.light)
        
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! [String:String]
            self.saveDataToFile(uid: uid, values: data)
        })
    }
    
    fileprivate func saveDataToFile(uid:String, values:[String:String]) {
        
        guard let documetDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let fileUrl = documetDirectoryUrl.appendingPathComponent("\(uid).json")
        let imageUrl = documetDirectoryUrl.appendingPathComponent("\(uid).jpg")
        let imageUrlInDatabase = NSURL(string: values["Image"]!)
        let data = NSData(contentsOf: imageUrlInDatabase! as URL)
        
        //Save user info file
        do{
            let JSONData = try JSONSerialization.data(withJSONObject: values, options: [])
            try JSONData.write(to: fileUrl)
        }catch{
            print("Error while saving user info")
        }
        
        //Saving user image
        do{
            try data?.write(to: imageUrl, options: [])
        }catch{
            print("Error while saving user info")
        }
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
}
