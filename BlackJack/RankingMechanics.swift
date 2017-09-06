//
//  RankingMechanics.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.09.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension RankingViewController {
    
    func getData() {
        let ref = Database.database().reference().child("top")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let data = snapshot.value as! [String:String]
            var keys = [String]()
            var values = [String]()
            
            for i in data.keys {
                keys.append(i)
            }
            
            for i in data.values {
                values.append(i)
            }
            
            for i in 0...values.count - 1 {
                let user = User()
                user.uid = values[i]
                user.score = keys[i]
                self.users.append(user)
            }
            self.users.sort(by: { (user1, user2) -> Bool in
                return Int(user1.score!)! > Int(user2.score!)!
            })
            
            var iterator = 0
            for i in 0...self.users.count - 1 {
                if iterator < 5 && self.users[i].uid == Auth.auth().currentUser?.uid{
                    self.isInTopFive = true
                }
                iterator += 1
            }
            self.getUsersNames()
        })
    }

    fileprivate func getUsersNames() {
        
        for i in 0...users.count - 1 {
            
            guard users[i].uid != Auth.auth().currentUser?.uid else {
                users[i].name = "You"
                continue
            }
            
            let ref = Database.database().reference().child("users").child(users[i].uid!).child("Name")
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let data = snapshot.value as! String
                self.users[i].name = data
                self.retriveFive()
            })
        }
    }
    
    fileprivate func showResultsWhenUserIsInTopFive(count:Int) {
        for i in 0...count - 1{
            let userToShow = users[i]
            
            switch i {
            case 0:
                
                firstPlaceLabel.text = "1. \(userToShow.name!)"
                firstPlaceWinsLabel.text = "\(userToShow.score!) wins"
                
            case 1:
                guard let name = userToShow.name else{continue}
                secondPlaceLabel.text = "2. \(name)"
                secondPlaceWinsLabel.text = "\(userToShow.score!) wins"
                
            case 2:
                guard let name = userToShow.name else{continue}
                thirdPlaceLabel.text = "3. \(name)"
                thirdPlaceLabel.text = "\(userToShow.score!) wins"
                
            case 3:
                guard let name = userToShow.name else{continue}
                fourthPlaceLabel.text = "4. \(name)"
                fourthPlaceWinsLabel.text = "\(userToShow.score!) wins"
                
            case 4:
                guard let name = userToShow.name else{continue}
                fivethPlaceLabel.text = "5. \(name)"
                fivethPlaceWinsLabel.text = "\(userToShow.score!) wins"
                
            default:
                print(i)
            }
        }
    }
    
    fileprivate func showResultsWhenUserIsNotInTopFive(count:Int) {
        showResultsWhenUserIsInTopFive(count: count)
        for i in 0...users.count - 1{
            let userToShow = users[i]
            if userToShow.uid == Auth.auth().currentUser?.uid {
                sixthPlaceLabel.text = "\(i+1). \(userToShow.name!)"
                sixthhPlaceWinsLabel.text = "\(userToShow.score!) wins"
                showSixLabel()
            }
        }
    }
    
    fileprivate func showSixLabel() {
        sixthPlaceLabel.alpha = 1
        sixthhPlaceWinsLabel.alpha = 1
        dotOne.alpha = 1
        dotTwo.alpha = 1
        dotThree.alpha = 1
        lineSix.alpha = 1
    }
    
    fileprivate func retriveFive() {
        let count = users.count > 5 ? 5 : users.count
        
        if isInTopFive {
            showResultsWhenUserIsInTopFive(count: count)
        }else {
            showResultsWhenUserIsNotInTopFive(count: count)
        }
        
    }

}

