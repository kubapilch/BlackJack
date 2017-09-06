//
//  Same.swift
//  BlackJack
//
//  Created by Kuba Pilch on 12.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import SVProgressHUD
import SDWebImage
import Firebase

extension GameViewController {
   
    fileprivate func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }

    func setPlayersImages() {
        let playerImageRef = Storage.storage().reference().child("profiles_images/\(playerUid!).jpg")
        let opponentImageRef = Storage.storage().reference().child("profiles_images/\(opponentUid!).jpg")
        
        playerImageRef.downloadURL { (url, error) in
            if error != nil {
                print(error!)
                return
            }
            
            print("Download Started")
            self.getDataFromUrl(url: url!) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() { () -> Void in
                    let image = UIImage(data: data)
                    self.playerProfileImageView.image = image
                }
            }
        }
        
        opponentImageRef.downloadURL { (url, error) in
            if error != nil {
                print(error!)
                return
            }
            print("Download Started")
            self.getDataFromUrl(url: url!) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() { () -> Void in
                    let image = UIImage(data: data)
                    self.opponentProfileImageView.image = image
                }
            }
        }
        
    }
    
    func updateUserInfo(didWon:Bool,didHaveMax:Bool) {
        let uid = (Auth.auth().currentUser?.uid)!
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var data = snapshot.value as! [String:String]
        
            let handsPlayed = Int(data["HandsPlayed"]!)! + 1
            data["HandsPlayed"] = String(handsPlayed)
            
            if didWon {
                
                let handsWon = Int(data["HandsWon"]!)! + 1
                data["HandsWon"] = String(handsWon)
                self.saveScoreToTopScoresInDatabase(score: handsWon)
                
                let currentStrick = Int(data["CurrentWonStricke"]!)! + 1
                data["CurrentWonStricke"] = String(currentStrick)
                
                if Int(data["MaxWonStricke"]!)! < currentStrick {
                    data["MaxWonStricke"] = String(currentStrick)
                }
                
                if didHaveMax {
                    let maxPoints = Int(data["MaxPointsTimes"]!)! + 1
                    data["MaxPointsTimes"] = String(maxPoints)
                }
            }else {
                 data["CurrentWonStricke"] = "0"
            }
            
            self.updateInfoLocaly(uid: uid, values: data)
            userRef.updateChildValues(data)
        })
    }
    
    func updateInfoLocaly(uid:String,values:[String:String]) {
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(uid).json")
        
        //Save to file
        do{
            let data = try JSONSerialization.data(withJSONObject: values, options: [])
            try data.write(to: fileUrl)
        }catch{
            print(error)
        }
    }
    
    func showThatPlayerWin(didHaveMax:Bool) {
        SVProgressHUD.showSuccess(withStatus: "You Won!")
        SVProgressHUD.setBackgroundColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        SVProgressHUD.setForegroundColor(UIColor.green)
        SVProgressHUD.setDefaultStyle(.custom)
    
        for i in playerStartCards {
            i.setup(color: .green)
        }
        for i in opponentStartCards {
            i.setup(color: .red)
        }
    
        updateUserInfo(didWon: true, didHaveMax: didHaveMax)
    }
    
    func showThatPlayerLose(didHaveMax:Bool) {
        SVProgressHUD.showError(withStatus: "You Lose!")
        SVProgressHUD.setBackgroundColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        SVProgressHUD.setForegroundColor(UIColor.red)
        SVProgressHUD.setDefaultStyle(.custom)
    
        for i in playerStartCards {
            i.setup(color: .red)
        }
        for i in opponentStartCards {
            i.setup(color: .green)
        }
    
        updateUserInfo(didWon: false, didHaveMax: didHaveMax)
    }
    
    func showThatDraw(didHaveMax:Bool) {
        SVProgressHUD.showInfo(withStatus: "Draw!")
        SVProgressHUD.setBackgroundColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setDefaultStyle(.custom)
    
        for i in playerStartCards {
            i.setup(color: .yellow)
        }
        for i in opponentStartCards {
            i.setup(color: .yellow)
        }
    
        updateUserInfo(didWon: false, didHaveMax: didHaveMax)
    }
    
    func handleCheck() {
        moreButton.isUserInteractionEnabled = false
        checkButton.isUserInteractionEnabled = false
        if side == .server {
            let playerOneFinishedRef = ref?.child("playerOneFinished")
            playerOneFinishedRef?.updateChildValues(["0":"true"])
            whoWins(points: sumUpPoints())
            stopUserTimer()
        }else {
            let deckRef = ref?.child("deck")
            var num = 0
            for i in cards {
                deckRef?.updateChildValues(["\(num)":i.name!])
                num += 1
            }
            let playerTwoFinishedRef = ref?.child("playerTwoFinished")
            playerTwoFinishedRef?.updateChildValues(["0":"true"])
            startOpponentTimer()
            stopUserTimer()
        }
    }

    func handleMore() {
        guard playerCardsOnBoard.count < 10 else{return}
        playerCardsOnBoard.append(cards.first!)
        let card = cards.first!
        card.heightAnchor.constraint(equalToConstant: 76).isActive = true
        card.widthAnchor.constraint(equalToConstant: 49).isActive = true
        cards.removeFirst()
        playerTimer.time = 15
        playerCollectionView.reloadData()
        if side == .server {
            let playerOneOnBoardCardsRef = ref?.child("playerOneOnTableCards")
            playerOneOnBoardCardsRef?.updateChildValues(["\(playerCardsOnBoard.count)":card.name!])
        }else {
            let playerTwoOnBoardCardsRef = ref?.child("playerTwoOnTableCards")
            playerTwoOnBoardCardsRef?.updateChildValues(["\(playerCardsOnBoard.count)":card.name!])
        }
    }
    
    func saveScoreToTopScoresInDatabase(score:Int) {
        let topRef = Database.database().reference().child("top")
        topRef.updateChildValues([score:playerUid!])
    }
    
    func stopUserTimer() {
        playerTimer.alpha = 0
        playerTimerReference?.invalidate()
        playerTimerReference = nil
    }
    
    func stopOpponentTimer() {
        opponentTimer.alpha = 0
        opponentTimerReference?.invalidate()
        opponentTimerReference = nil
    }
    
    func startUserTimer() {
        playerTimerReference = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUserTimer), userInfo: nil, repeats: true)
        playerTimer.alpha = 1
    }
    
    func startOpponentTimer() {
        opponentTimerReference = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateOpponentTimer), userInfo: nil, repeats: true)
        opponentTimer.alpha = 1
    }
    
        
    func updateUserTimer() {
        if playerTimer.time == 0 {
            handleCheck()
            return
        }
        playerTimer.time = playerTimer.time! - 1
    }
    
    func updateOpponentTimer() {
        if opponentTimer.time != 0 {
            opponentTimer.time = opponentTimer.time! - 1
        }else {
            stopOpponentTimer()
            afkChecker()
        }
    }
    
    fileprivate func afkChecker() {
        let time = DispatchTime.now() + 8
        DispatchQueue.main.asyncAfter(deadline: time) { 
            
            guard self.opponnentIsAFK != false else{return}
            
            SVProgressHUD.showError(withStatus: "Opponent has left!")
            //Remove game room
            self.ref?.removeAllObservers()
            self.ref?.removeValue()
            let time = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    
    private func setThatUserIsReady() {
        if side == .server {
            ref = Database.database().reference().child("games room").child("\(playerUid!)\(opponentUid!)")
            ref?.updateChildValues(["playerOneReady":"true"])
            moreButton.isUserInteractionEnabled = false
        }else {
            ref = Database.database().reference().child("games room").child("\(opponentUid!)\(playerUid!)")
            ref?.updateChildValues(["playerTwoReady":"true"])
        }
    }
    
    func setType() {
        let userDef = UserDefaults.standard
        if (userDef.value(forKey: "type") as! String) == "server" {
            side = type.server
            setThatUserIsReady()
            randomCards()
        }else {
            side = type.client
            setThatUserIsReady()
            waitForCards()
        }
    }
}
