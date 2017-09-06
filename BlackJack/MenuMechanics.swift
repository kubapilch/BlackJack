//
//  MenuMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension ViewController {
    //Functions
    func pickImage() {
        let connection = checkIfHasInternet()
        guard connection == true else{return}
        imagePickerReference.allowsEditing = true
        imagePickerReference.sourceType = .photoLibrary
        
        present(imagePickerReference, animated: true, completion: nil)
    }
    
    func showRanking() {
        //Check connetion
        let connection = checkIfHasInternet()
        guard connection == true else{return}
        
        //Show view
        let rankingView = RankingViewController()
        present(rankingView, animated: true, completion: nil)
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
    
    
    func resetPassword() {
        let connection = checkIfHasInternet()
        guard connection == true else{return}
        let mail = Auth.auth().currentUser?.email
        Auth.auth().sendPasswordReset(withEmail: mail!) { (error) in
            if error != nil{
                print(error!)
                SVProgressHUD.setDefaultStyle(.light)
                SVProgressHUD.showError(withStatus: "Can't send an email")
                let time = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: time, execute: { 
                    SVProgressHUD.dismiss()
                })
                return
            }
            print("Succesflully send an email")
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.showSuccess(withStatus: "Email has been send!")
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                SVProgressHUD.dismiss()
            })
        }
    }
    
    func changeProfileImage() {
        let image = miniUserImage.image!
        let imageNameRef = Storage.storage().reference().child("profiles_images/\(userUid!).jpg")
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let imageUrl = documentDirectoryUrl.appendingPathComponent("\(userUid!).jpg")
        let data = UIImageJPEGRepresentation(image, 0.2)!
        
        SVProgressHUD.show(withStatus: "")
        SVProgressHUD.setDefaultStyle(.dark)
        
        imageNameRef.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let downloadUrl = metadata?.downloadURL()
            let ref = Database.database().reference().child("users").child(self.userUid!)
            ref.updateChildValues(["Image":String(describing: downloadUrl!)])
        
            do{
                try data.write(to: imageUrl)
            }catch{
                print(error)
            }
            self.readFiles()
            SVProgressHUD.dismiss()
        }
    }
    
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
        if howToButton.titleLabel?.text == "Bluetooth" {
            SVProgressHUD.showInfo(withStatus: "Coming soon!")
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time, execute: { 
                SVProgressHUD.dismiss()
            })
        }else {
            handleCancel()
        }
    }
    
    func logout() {
        let loginView = LoginViewController()
        hideUserInfoView()
        present(loginView, animated: true, completion: nil)
    }
    
    fileprivate func readFiles() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(userUid!).json")
        let imageUrl = documentDirectoryUrl.appendingPathComponent("\(userUid!).jpg")
        
        //Read json file
        do{
            let data = try NSData(contentsOf: fileUrl, options: [])
            guard let values = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:String] else{return}
            setupUserInfo(values: values)
        }catch{
            print(error)
            handleLogout()
        }
        //Read profile image
        do{
            let data = try NSData(contentsOf: imageUrl, options: [])
            guard let image = UIImage(data: data as Data) else{return}
            miniUserImage.image = image
            userImage.image = image
        }catch{
            print(error)
            handleLogout()
        }
    }
    fileprivate func getUserInfoFromDatabase(uid:String) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! [String:String]
            self.setupUserInfo(values: data)
            self.saveDataToFile(uid: uid, values: data)
        })
    }
    
    fileprivate func saveDataToFile(uid:String, values:[String:String]) {
        
        guard let documetDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let fileUrl = documetDirectoryUrl.appendingPathComponent("\(uid).json")
        let imageUrl = documetDirectoryUrl.appendingPathComponent("\(uid).jpg")
        guard let imageString = values["Image"] else{return}
        guard let imageURLInDatabase = URL(string: imageString) else{
            return}
        let data = NSData(contentsOf: imageURLInDatabase)
        let image = UIImage(data: data! as Data)
        
        miniUserImage.image = image
        userImage.image = image
        
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
    }
    fileprivate func setupUserInfo(values:[String:String]) {
        userNameLabel.text = "\(values["Name"]!)"
        miniUserNameLabel.text = "\(values["Name"]!)"
        
        userMailLabel.text = "\(values["Mail"]!)"
        
        gamesPlayedLabel.text = "Games played:\(values["HandsPlayed"]!)"
        
        gamesWonLabel.text = "Games won:\(values["HandsWon"]!)"
        
        wonStrickeLabel.text = "Won stricke:\(values["CurrentWonStricke"]!)"
        
        biggestWonStrickeLabel.text = "Biggest won stricke\(values["MaxWonStricke"]!)"
        
        maxPointsLabel.text = "21 points times:\(values["MaxPointsTimes"]!)"
    
        let date = NSDate(timeIntervalSince1970: Double(values["registered"]!)!)
        registeredDateLabel.text = String(describing: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
            
            let userDef = UserDefaults()
            var shouldUpdate:Bool? = userDef.bool(forKey: "shouldUpdate")
            shouldUpdate = true
            
            if shouldUpdate != nil && shouldUpdate! && Reachability.isConnectedToNetwork(){
                getUserInfoFromDatabase(uid: userUid!)
                userDef.set(false, forKey: "shouldUpdate")
                userDef.synchronize()
            }else{
                readFiles()
            }
        }
    }
}
