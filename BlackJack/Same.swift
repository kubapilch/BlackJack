//
//  Same.swift
//  BlackJack
//
//  Created by Kuba Pilch on 12.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension GameViewController {
    
    private func setThatUserIsReady() {
        if side == .server {
            ref = Database.database().reference().child("games room").child("\(playerUid!)\(opponentUid!)")
            ref?.updateChildValues(["playerOneReady":"true"])
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
