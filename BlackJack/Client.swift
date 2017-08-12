//
//  Client.swift
//  BlackJack
//
//  Created by Kuba Pilch on 12.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase

extension GameViewController {
    
    private func takeToFirstCardsForPlayerAsClient() {
        for i in 0...1 {
            playerStartCards[i].name = cards.first?.name
            cards.removeFirst()
        }
        let playerHandRef = ref?.child("playerTwoStartingCards")
        playerHandRef?.updateChildValues(["0":playerStartCards[0].name!,"1":playerStartCards[1].name!])
        
        let deckRef = ref?.child("deck")
        deckRef?.removeAllObservers()
        for i in 0...cards.count - 1 {
            deckRef?.updateChildValues(["\(i)":cards[i].name!])
        }
    }
    
    func waitForCards() {
        let deckRef = ref?.child("deck")
        deckRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value!)
            let data = snapshot.value as! [String]
            for i in data {
                let card = Card()
                card.name = i
                print("\(card.rank!) card rank and \(card.name!) name")
                self.cards.append(card)
            }
            self.takeToFirstCardsForPlayerAsClient()
        })
    }
}
