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
            print("Get player two card number \(num)")
            num += 1
        })
    }
    
    private func waitForPlayerTwoTakeStartingCardsForServer() {
        let playerOneHandRef = ref?.child("playerOneStartingCards")
        var num = 0
        playerOneHandRef?.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as! String
            self.playerStartCards[num].name = data
            print("Get player one card number \(num)")
            num += 1
            if num == 1 {
                self.startOpponentTimer()
                self.removeObserverFromStartingCards()
            }
        })
    }
    
    private func waitForPlayerTwoToEndTurn() {
        let playerTwoFinishRef = ref?.child("playerTwoFinished")
        playerTwoFinishRef?.observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as! String
            if data == "true" {
                self.moreButton.isUserInteractionEnabled = true
                self.getDeck()
                self.startUserTimer()
                self.stopOpponentTimer()
            }
        })
    }
    
    fileprivate func removeObserverFromStartingCards() {
        ref?.child("playerOneStartingCards").removeAllObservers()
        ref?.child("playerTwoStartingCards").removeAllObservers()
    }

    
    private func sumUpPlayerOnePoints() -> Int{
        var playerOnePoints = 0
        var playerOneAces = 0
        
        for i in playerStartCards {
            switch i.rank! {
            case 11:
                playerOnePoints += 2
            case 12:
                playerOnePoints += 3
            case 13:
                playerOnePoints += 4
            case 14:
                playerOnePoints += 1
                playerOneAces += 1
            default:
                playerOnePoints += i.rank!
            }
        }
        for i in playerCardsOnBoard {
            switch i.rank! {
            case 11:
                playerOnePoints += 2
            case 12:
                playerOnePoints += 3
            case 13:
                playerOnePoints += 4
            case 14:
                playerOnePoints += 1
                playerOneAces += 1
            default:
                playerOnePoints += i.rank!
            }
        }
        
        if playerOneAces > 0 {
            for _ in 1...playerOneAces {
                if (playerOnePoints + 10) <= 21 {
                    playerOnePoints += 10
                }
            }
        }
        return playerOnePoints
    }
    
    private func sumUpPlayerTwoPoints() -> Int {
        var playerTwoPoints = 0
        var playerTwoAces = 0
        
        for i in opponentStartCards {
            switch i.rank! {
            case 11:
                playerTwoPoints += 2
            case 12:
                playerTwoPoints += 3
            case 13:
                playerTwoPoints += 4
            case 14:
                playerTwoPoints += 1
                playerTwoAces += 1
            default:
                playerTwoPoints += i.rank!
            }
        }
        for i in opponentCardsOnBoard {
            switch i.rank! {
            case 11:
                playerTwoPoints += 2
            case 12:
                playerTwoPoints += 3
            case 13:
                playerTwoPoints += 4
            case 14:
                playerTwoPoints += 1
                playerTwoAces += 1
            default:
                playerTwoPoints += i.rank!
            }
        }
        
        if playerTwoAces > 0 {
            for _ in 1...playerTwoAces {
                if (playerTwoPoints + 10) <= 21 {
                    playerTwoPoints += 10
                }
            }
        }
        return playerTwoPoints
    }
    
    func sumUpPoints() -> [Int] {
        let playerOnePoints = sumUpPlayerOnePoints()
        let playerTwoPoints = sumUpPlayerTwoPoints()
        return [playerOnePoints,playerTwoPoints]
    }
    
    private func getDeck() {
        let deckRef = ref?.child("deck")
        deckRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! [String]
            
            //Clean cards array
            self.cards.removeAll()
            
            //Fill cards array
            for i in data {
                let card = Card()
                card.name = i
                self.cards.append(card)
            }
        })
    }
    
    func whoWins(points: [Int]) {
        print("player one ponts: \(points.first!), player two points: \(points.last!)")
        let winnerRef = ref?.child("winner")
        if points.first! < 22 && points.last! < 22 && points.first! != points.last!{
            if points.first! > points.last! {
                print("player one wins")
                userWins()
                winnerRef?.setValue(["0":"playerOne"])
            }else if points.first! < points.last! {
                print("player two wins")
                opponentWins()
                winnerRef?.setValue(["0":"playerTwo"])
            }else {
                print("remis")
                draw()
                winnerRef?.setValue(["0":"draw"])
            }
        }else if points.first! < 22 && points.last! > 21 {
            print("player one wins")
            userWins()
            winnerRef?.setValue(["0":"playerOne"])
        }else if points.first! > 21 && points.last! < 22 {
            print("player two wins")
            opponentWins()
            winnerRef?.setValue(["0":"playerTwo"])
        }else {
            print("remis")
            draw()
            winnerRef?.setValue(["0":"draw"])
        }
        opponentStartCards[0].isUpSideDown = false
        opponentStartCards[1].isUpSideDown = false
        
        ref?.removeAllObservers()
        
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func getPlayerTwoOnTableCards() {
        let playerTwoOnTableCardsRef = ref?.child("playerTwoOnTableCards")
        playerTwoOnTableCardsRef?.observe(.childAdded, with: { (snapshot) in
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
        waitForPlayerTwoTakeStartingCardsForServer()
        getPlayerTwoOnTableCards()
        waitForPlayerTwoToEndTurn()
    }

}
