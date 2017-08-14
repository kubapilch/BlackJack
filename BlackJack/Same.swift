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
    
    func handleCheck() {
        moreButton.isUserInteractionEnabled = false
        if side == .server {
            let playerOneFinishedRef = ref?.child("playerOneFinished")
            playerOneFinishedRef?.updateChildValues(["0":"true"])
            whoWins(points: sumUpPoints())
        }else {
            let deckRef = ref?.child("deck")
            var num = 0
            for i in cards {
                deckRef?.updateChildValues(["\(num)":i.name!])
                num += 1
            }
            let playerTwoFinishedRef = ref?.child("playerTwoFinished")
            playerTwoFinishedRef?.updateChildValues(["0":"true"])
        }
    }
    
    func draw() {
        for i in playerStartCards {
            i.layer.borderColor = UIColor.yellow.cgColor
            i.layer.borderWidth = 5
        }
        for i in opponentStartCards {
            i.layer.borderColor = UIColor.yellow.cgColor
            i.layer.borderWidth = 5
        }
    }
    
    func userWins() {
        for i in playerStartCards {
            i.layer.borderColor = UIColor.green.cgColor
            i.layer.borderWidth = 5
        }
        for i in opponentStartCards {
            i.layer.borderColor = UIColor.red.cgColor
            i.layer.borderWidth = 5
        }
    }
    
    func opponentWins() {
        for i in opponentStartCards {
            i.layer.borderColor = UIColor.green.cgColor
            i.layer.borderWidth = 5
        }
        for i in playerStartCards {
            i.layer.borderColor = UIColor.red.cgColor
            i.layer.borderWidth = 5
        }
    }
    
    func handleMore() {
        guard playerCardsOnBoard.count < 10 else{return}
        playerCardsOnBoard.append(cards.first!)
        let card = cards.first!
        card.heightAnchor.constraint(equalToConstant: 76).isActive = true
        card.widthAnchor.constraint(equalToConstant: 49).isActive = true
        cards.removeFirst()
        playerCardsStackView.addArrangedSubview(card)
        if side == .server {
            let playerOneOnBoardCardsRef = ref?.child("playerOneOnTableCards")
            playerOneOnBoardCardsRef?.updateChildValues(["\(playerCardsOnBoard.count)":card.name!])
        }else {
            let playerTwoOnBoardCardsRef = ref?.child("playerTwoOnTableCards")
            playerTwoOnBoardCardsRef?.updateChildValues(["\(playerCardsOnBoard.count)":card.name!])
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
