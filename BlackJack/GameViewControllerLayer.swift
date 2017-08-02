//
//  GameViewControllerExtension.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import Foundation
import CoreGraphics

extension GameViewController {
    
    func setUpBackgroundView() {
        self.view.addSubview(gameBackgroundImageView)
        gameBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gameBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        gameBackgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setUpStackViews() {
        //Set up main cards stack view
        self.view.addSubview(cardsStackView)
        cardsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        cardsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        cardsStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        //Set up opponent stack view
        cardsStackView.addArrangedSubview(opponentCardsStackView)
        opponentCardsStackView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        opponentCardsStackView.widthAnchor.constraint(equalTo: cardsStackView.widthAnchor).isActive = true
        
        //Set up player stack view
        cardsStackView.addArrangedSubview(playerCardsStackView)
        playerCardsStackView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        playerCardsStackView.widthAnchor.constraint(equalTo: cardsStackView.widthAnchor).isActive = true
    }
    
    func setUpCardsImageViews() {
        //Fill player cards stack view
        for _ in  0..<5 {
            let card = Card()
            card.heightAnchor.constraint(equalToConstant: 85).isActive = true
            card.widthAnchor.constraint(equalToConstant: 55).isActive = true
            card.setFrontImageView(name: "ace")
            playerCardsOnBoard.append(card)
            playerCardsStackView.addArrangedSubview(card)
        }
        //Fill opponent cards stack view
        for _ in  0..<5 {
            let card = Card()
            card.heightAnchor.constraint(equalToConstant: 85).isActive = true
            card.widthAnchor.constraint(equalToConstant: 55).isActive = true
            card.setFrontImageView(name: "ace")
            card.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            opponentCardsOnBoard.append(card)
            opponentCardsStackView.addArrangedSubview(card)
        }
    }
}
