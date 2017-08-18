//
//  ViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 31.07.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController {

    enum type {
        case server
        case client
    }
    
    var roomReference:String? {
        didSet{
            print("Joining room with reference: \(roomReference!)")
            dissmissLoadingView()
            let gameView = GameViewController()
            gameView.gameRoomReference = self.roomReference
            gameView.playerUid = self.userUid
            gameView.opponentUid = self.opponentUid
            let userDef = UserDefaults.standard
            if side == .server {
                userDef.set("server", forKey: "type")
            }else {
                userDef.set("client", forKey: "type")
            }
            userDef.synchronize()
            print("Opponent uid: \(opponentUid!)")
            present(gameView, animated: true) {
                self.playButton.isUserInteractionEnabled = true
                print("view presented")
            }
        }
    }
    
    var side: type?
    var userUid: String?
    var opponentUid: String?
    
    var pairUid: String? {
        didSet {
            joinToQueue(withUid: pairUid!)
        }
    }
    
    let backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "menuBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let buttonsStackView: UIStackView = {
        var stack = UIStackView()
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let creditsButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Credits")
        button.color = UIColor.black
        return button
    }()
    
    let logoutButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Logout")
        button.addTarget(self, action: #selector(ViewController.handleLogout), for: .touchUpInside)
        button.color = UIColor.black
        return button
    }()
    
    let playButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Play")
        button.addTarget(self, action: #selector(ViewController.handlePlay), for: .touchUpInside)
        button.color = UIColor.black
        return button
    }()

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
    
    fileprivate func dissmissLoadingView() {
        SVProgressHUD.dismiss()
        
        resizeButton()
        
        logoutButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        logoutButton.setText(text: "Logout")
    }
    
    fileprivate func showLoadingView() {
        SVProgressHUD.show(withStatus: "Looking for opponent..")
        SVProgressHUD.setDefaultStyle(.dark)
        
        resizeButton()
        
        logoutButton.backgroundColor = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 0.7)
        logoutButton.setTitle("Cancle", for: .normal)
    }
    
    func handlePlay() {
        playButton.isUserInteractionEnabled = false
        var waitingUsers = [String:[String:Any]]()
        let ref = Database.database().reference().child("queue")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value!)
            self.showLoadingView()
            let data = snapshot.value as! [String:Any]
            for i in data {
                if i.key != "working" {
                    waitingUsers[i.key] = i.value as? [String : Any]
                }
            }
            if waitingUsers.count == 0 {
                print("Noone in queue")
                self.createNewQueue()
            }else {
                for i in waitingUsers {
                    let values = i.value
                    if values["waiting"] as! Bool {
                        self.pairUid = i.key
                        return
                    }
                }
                print("All users are booked")
                self.createNewQueue()
            }
        })
    }
    
    func createNewQueue() {
        print("creating new queue")
        let refQueue = Database.database().reference().child("queue").child(userUid!)
        var number = 0
        side = type.server
        refQueue.setValue(["waiting":true])
        refQueue.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value
            if number == 0{
                print("Initial snapshot")
                number += 1
            }else if number == 1 {
                print("Not initial value, opponent found")
                self.opponentUid = data as? String
                let refGameRoom = Database.database().reference().child("games room").child("\(self.userUid!)\(self.opponentUid!)")
                self.roomReference = "games room/\(self.userUid!)\(self.opponentUid!)"
                refGameRoom.updateChildValues(["player1":self.userUid!, "player2":self.opponentUid!])
                refQueue.updateChildValues(["room":"\(refGameRoom)"])
                number += 1
            }else {
                print("Game room reference")
                refQueue.removeAllObservers()
            }
        })
    }
 
    func joinToQueue(withUid:String) {
        print("joining to queue with uid: \(withUid)")
        opponentUid = withUid
        let ref = Database.database().reference().child("queue").child(withUid)
        var number = 0
        side = type.client
        ref.updateChildValues(["waiting":false, "connector":userUid!])
        ref.observe(.childAdded, with: { (snapshot) in
            
            if number == 0 {
                print("Opponent uid, \(snapshot.value!)")
                number += 1
            }else if number == 1 {
                print("Waiting status change")
                number += 1
            }else if number == 2 {
                print("Game room reference created by opponent")
                self.roomReference = (snapshot.value as! String)
                ref.removeAllObservers()
                ref.removeValue()
            }
        })
    }
    
    fileprivate func handleCancel() {
        let ref = Database.database().reference().child("queue").child(userUid!)
        ref.removeValue()
        ref.removeAllObservers()
    
        dissmissLoadingView()
    
        playButton.isUserInteractionEnabled = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide top bar
        self.navigationController?.isNavigationBarHidden = true
        
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
        }else {
            logout()
        }
        
        //Set up background image viewTy też płać mniej w Play! Przenieś numer!
        setUpBackgroundImageView()
    
        //Set up menu stack view and menu buttons
        setUpMenuButtons(width: 10)
    }
}

