//
//  OpponentSearchingMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension ViewController {

    fileprivate func dissmissLoadingView() {
        SVProgressHUD.dismiss()
        
        resizeButton()
    
        howToButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        howToButton.setText(text: "How to play")
    }
    
    fileprivate func showLoadingView() {
        SVProgressHUD.show(withStatus: "Looking for opponent..")
        SVProgressHUD.setDefaultStyle(.dark)
        
        resizeButton()
        
        howToButton.backgroundColor = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 0.7)
        howToButton.setTitle("Cancle", for: .normal)
    }

    func prepareForGame() {
        //Dissmis loading view and setu up buttons for deafults
        dissmissLoadingView()
        
        //Prepare game view controller properties for game
        let gameView = GameViewController()
        gameView.gameRoomReference = self.roomReference
        gameView.playerUid = self.userUid
        gameView.opponentUid = self.opponentUid
        
        //Pass the user type to user def
        let userDef = UserDefaults.standard
        if side == .server {
            //Type serwer
            userDef.set("server", forKey: "type")
        }else {
            //Type client
            userDef.set("client", forKey: "type")
        }
        userDef.synchronize()
        
        //Present game view and make play button interactive again
        present(gameView, animated: true) {
            self.playButton.isUserInteractionEnabled = true
        }
    }
    
    func handlePlay() {
        //Make play button non interactive
        playButton.isUserInteractionEnabled = false
        
        var waitingUsers = [String:[String:Any]]()
        let ref = Database.database().reference().child("queue")
        
        //Observe for data from queue
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //Show loading view and change buttons size and color
            self.showLoadingView()
            
            //Cast snapshot
            let data = snapshot.value as! [String:Any]
            
            //Check if somebody is in queue
            for i in data {
                if i.key != "working" {
                    //Somebody is in queue
                    waitingUsers[i.key] = i.value as? [String : Any]
                }
            }
            if waitingUsers.count == 0 {
                //Noone in queue
                self.createNewQueue()
            }else {
                //Somebody in queue check if has connector
                for i in waitingUsers {
                    let values = i.value
                    if values["waiting"] as! Bool {
                        //Pair found
                        self.pairUid = i.key
                        return
                    }
                }
                //All users are booked create new queue
                self.createNewQueue()
            }
        })
    }
    
    func createNewQueue() {
        
        let refQueue = Database.database().reference().child("queue").child(userUid!)
        refQueue.setValue(["waiting":true])
        
        //Iterrator
        var number = 0
        
        //Set type to serwer
        side = type.server
        //Wait for opponent
        refQueue.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value
            if number == 0{
                //Initial snapshot
                number += 1
            }else if number == 1 {
                //Opponent found
                self.opponentUid = data as? String
                
                //Create game room
                let refGameRoom = Database.database().reference().child("games room").child("\(self.userUid!)\(self.opponentUid!)")
                refGameRoom.updateChildValues(["player1":self.userUid!, "player2":self.opponentUid!])
                
                //Pass to serwer game room reference
                self.roomReference = "games room/\(self.userUid!)\(self.opponentUid!)"
                refQueue.updateChildValues(["room":"\(refGameRoom)"])
                
                number += 1
            }else {
                //Game room reference, remove all observers from queue
                refQueue.removeAllObservers()
            }
        })
    }
    
    func joinToQueue(withUid:String) {
        //Set opponent uid
        opponentUid = withUid
        
        //Connect to queue
        let ref = Database.database().reference().child("queue").child(withUid)
        ref.updateChildValues(["waiting":false, "connector":userUid!])
        
        //Iterrator
        var number = 0
        
        //Set uder type
        side = type.client
        
        ref.observe(.childAdded, with: { (snapshot) in
            if number == 0 {
                number += 1
            }else if number == 1 {
                //Waiting status changed
                number += 1
            }else if number == 2 {
                //Game room reference
                self.roomReference = (snapshot.value as! String)
                
                //Remove all observers from queu and remove it from database
                ref.removeAllObservers()
                ref.removeValue()
            }
        })
    }
    
    func handleCancel() {
        //Remove user from queue
        let ref = Database.database().reference().child("queue").child(userUid!)
        ref.removeValue()
        ref.removeAllObservers()
        
        //Dissmiss loading view, change buttons to deafults and make play button interactive
        dissmissLoadingView()
        playButton.isUserInteractionEnabled = true
    }
    
}
