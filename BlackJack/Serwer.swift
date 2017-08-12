//
//  Serwer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 12.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension GameViewController {
    
    private func waitForPlayerTwoTakeStartingCards() {
        let playerTwoHandRef = ref?.child("playerTwoStartingCards")
        var num = 0
        playerTwoHandRef?.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as! String
            self.opponentStartCards[num].name = data
            self.opponentStartCards[num].isUpSideDown = false
            num += 1
        })
    }
    
    func randomCards() {
        let names = ["s","h","d","c"]
        for name in names {
            for i in 2...14 {
                let card = Card()
                if i < 10 {
                    card.name = "0\(i)\(name)"
                }else {
                    card.name = "\(i)\(name)"
                }
                cards.append(card)
            }
        }
        
        for _ in 0...5 {
            cards.shuffle()
        }
        sendDeckToFirebase()
    }
    
    private func sendDeckToFirebase() {
        var cardsToSend = [String:String]()
        var num = 0
        for i in cards {
            cardsToSend["\(num)"] = i.name!
            num += 1
        }
        let deckRef = ref?.child("deck")
        deckRef?.updateChildValues(cardsToSend)
        
        waitForPlayerTwoTakeStartingCards()
    }

}
