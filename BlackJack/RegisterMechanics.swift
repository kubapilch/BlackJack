//
//  RegisterMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension RegisterViewController {

    fileprivate func loginUser() {
        SVProgressHUD.dismiss()
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func registerUserWithUID(userId:String, name:String, mail:String, imageURL:String) {
        let ref = Database.database().reference().child("users").child(userId)
        let time = NSDate().timeIntervalSince1970
        let values = ["Name":name,"Mail":mail,"Image":imageURL,"HandsPlayed":"0","HandsWon":"0","MaxPointsTimes":"0","MaxWonStricke":"0","CurrentWonStricke":"0","registered":"\(time)"]
        ref.setValue(values)
        saveFilesLocaly(userId: userId, values: values)
        self.loginUser()
    }
    
    fileprivate func saveFilesLocaly(userId:String, values:[String:String]) {
        
        guard let documetDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = documetDirectoryUrl.appendingPathComponent("\(userId).json")
        let imageUrl = documetDirectoryUrl.appendingPathComponent("\(userId).jpg")
        let image = imagePicker.image!
        
        //Save user info file
        do {
            let data = try JSONSerialization.data(withJSONObject: values, options: [])
            try data.write(to: fileUrl)
        }catch{
            print("Error while saving user info")
        }
        
        //Save user image
        do{
            let data = UIImagePNGRepresentation(image)
            try data?.write(to: imageUrl)
        }catch{
            print("Error while saving user profile image")
        }
        
    }
    
    func checkTextFields() {
        guard let name = nameField.text, let mail = mailField.text, let password = passwordField.text, let confirmPassword = passwordFieldConfirm.text else {return}
        //Check connection
        let connection = checkIfHasInternet()
        guard connection == true else{return}
        
        if password != confirmPassword {
            passwordLine.backgroundColor = UIColor.red
            confirmPasswordLine.backgroundColor = UIColor.red
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: { 
                self.passwordLine.backgroundColor = UIColor.white
                self.confirmPasswordLine.backgroundColor = UIColor.white
            })
            return
        }
        
        Auth.auth().createUser(withEmail: mail, password: password) { (user, error) in
            if error != nil {
                print("Problem with registering the user, \(error!)")
                return
            }
            print("User sucesfully registered")
            
            guard let image = self.imagePicker.image else {return}
            
            let uploadData = UIImageJPEGRepresentation(image, 0.2)
            let storageRef = Storage.storage().reference().child("profiles_images/\(user!.uid).jpg")
            
            SVProgressHUD.show(withStatus: "Reggistering...")
            SVProgressHUD.setDefaultStyle(.light)
            
            storageRef.putData(uploadData!, metadata: nil, completion: { (metaData, error) in
                
                if error != nil {
                    print("cant upload image")
                    return
                }
               
                
                if let imageURL = metaData?.downloadURL() {
                    guard let userId = user?.uid else {return}
                    self.registerUserWithUID(userId: userId, name: name, mail: mail, imageURL:String(describing: imageURL))
                }
            })
        }
        
    }
}
