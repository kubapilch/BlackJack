//
//  Client.swift
//  BlackJack
//
//  Created by Kuba Pilch on 12.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension GameViewController {
    
    private func takeTwoFirstCardsForPlayerAsClient() {
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
    
    private func getPlayerOneOnTableCards() {
        let playerOneOnTableCardsRef = ref?.child("playerOneOnTableCards")
        playerOneOnTableCardsRef?.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as! String
            let card = Card()
            card.heightAnchor.constraint(equalToConstant: 76).isActive = true
            card.widthAnchor.constraint(equalToConstant: 49).isActive = true
            card.name = data
            self.opponentCardsOnBoard.append(card)
            self.opponentCollectionView.addCell(image:UIImage(named: String(card.rank!))!)
            self.opponentTimer.time = 15
        })
    }
    
    private func takeNextTwoCardsForPlayerAsSerwer() {
        for i in 0...1 {
            opponentStartCards[i].name = cards.first?.name
            cards.removeFirst()
        }
        
        let opponentHandRef = ref?.child("playerOneStartingCards")
        opponentHandRef?.updateChildValues(["0":opponentStartCards[0].name!,"1":opponentStartCards[1].name!])
        startUserTimer()
    }
    
    private func waitForWinner() {
        let winnerRef = ref?.child("winner")
        winnerRef?.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as! String
            print(data)
            if data ==  "playerTwo" {
                self.userWins()
            }else if data == "playerOne"{
                self.opponentWins()
            }else if data == "draw" {
                self.draw()
            }
            self.opponentStartCards[0].isUpSideDown = false
            self.opponentStartCards[1].isUpSideDown = false
            
            self.ref?.removeAllObservers()
            self.ref?.removeValue()
            
            self.stopOpponentTimer()
            
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.dismiss(animated: true, completion: nil)
            }
        })
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
            self.takeTwoFirstCardsForPlayerAsClient()
            self.takeNextTwoCardsForPlayerAsSerwer()
            self.getPlayerOneOnTableCards()
            self.waitForWinner()
        })
    }
}
