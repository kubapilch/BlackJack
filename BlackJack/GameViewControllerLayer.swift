//
//  GameViewControllerExtension.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Firebase

extension GameViewController {

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    func setUpBackgroundView() {
        self.view.addSubview(gameBackgroundImageView)
        gameBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gameBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        gameBackgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func setPlayerStartCards() {
        self.view.addSubview(playerStartCardsView)
        playerStartCardsView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -60).isActive = true
        playerStartCardsView.leftAnchor.constraint(equalTo: playerTimer.rightAnchor).isActive = true
        playerStartCardsView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playerStartCardsView.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: -20).isActive = true
        addStartCardsToPlayerCardView()
    }
    
    private func setOpponentStartCards() {
        self.view.addSubview(opponentStartCardsView)
        opponentStartCardsView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60).isActive = true
        opponentStartCardsView.rightAnchor.constraint(equalTo: opponentTimer.leftAnchor).isActive = true
        opponentStartCardsView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        opponentStartCardsView.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 10).isActive = true
        addOpponentStartCardsToOpponentCardView()
    }
    
    func setUpAllStartCardsViews() {
        //Set players cards view
        setPlayerStartCards()
        
        //Set opponnt card view
        setOpponentStartCards()
    }
    
    
    func setupPlayersImagesViews() {
        //Player image view
        self.view.addSubview(playerProfileImageView)
        playerProfileImageView.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: -10).isActive = true
        playerProfileImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        //Opponent image view
        self.view.addSubview(opponentProfileImageView)
        opponentProfileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        opponentProfileImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
    }
    
    private func addOpponentStartCardsToOpponentCardView() {
        for i in 0...1 {
            let card = Card()
            opponentStartCards.append(card)
            opponentStartCardsView.addSubview(card)
            card.heightAnchor.constraint(equalToConstant: 68).isActive = true
            card.widthAnchor.constraint(equalToConstant: 44).isActive = true
            card.centerYAnchor.constraint(equalTo: opponentStartCardsView.centerYAnchor).isActive = true
            card.isUpSideDown = true
            if i == 0 {
                card.transform = CGAffineTransform(rotationAngle:  CGFloat.pi * 1.06)
                card.centerXAnchor.constraint(equalTo: opponentStartCardsView.centerXAnchor, constant: -19).isActive = true
            }else {
                card.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 1.07)
                card.centerXAnchor.constraint(equalTo: opponentStartCardsView.centerXAnchor, constant: 19).isActive = true
            }
        }
    }
    
    func setLabels() {
        //Get user name
        let ref = Database.database().reference().child("users")
        ref.child(playerUid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! [String:String]
            self.playerName = data["Name"]
        })
        
        //Get opponent name
        ref.child(opponentUid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! [String:String]
            self.opponentName = data["Name"]
        })
        
    }
    
    private func addStartCardsToPlayerCardView() {
        for i in 0...1 {
            let card = Card()
            playerStartCards.append(card)
            playerStartCardsView.addSubview(card)
            card.heightAnchor.constraint(equalToConstant: 68).isActive = true
            card.widthAnchor.constraint(equalToConstant: 44).isActive = true
            card.centerYAnchor.constraint(equalTo: playerStartCardsView.centerYAnchor).isActive = true
            if i == 0 {
                card.transform = CGAffineTransform(rotationAngle:  -(CGFloat.pi / 12))
                card.centerXAnchor.constraint(equalTo: playerStartCardsView.centerXAnchor, constant: -19).isActive = true
            }else {
                card.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 12)
                card.centerXAnchor.constraint(equalTo: playerStartCardsView.centerXAnchor, constant: 19).isActive = true
            }
        }       
    }
    
    func layoutBottomBarView() {
        //Set up bottom bar main view
        self.view.addSubview(bottomBarView)
        bottomBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bottomBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bottomBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Set up separator
        bottomBarView.addSubview(line1)
        line1.centerXAnchor.constraint(equalTo: bottomBarView.centerXAnchor).isActive = true
        line1.topAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: 5).isActive = true
        line1.bottomAnchor.constraint(equalTo: bottomBarView.bottomAnchor, constant: -5).isActive = true
        
        //Set up more label
        bottomBarView.addSubview(moreButton)
        let leftAnchorOfMoreLabel = moreButton.leftAnchor.constraint(equalTo: line1.rightAnchor, constant: 5)
        leftAnchorOfMoreLabel.priority = 750
        leftAnchorOfMoreLabel.isActive = true
        moreButton.rightAnchor.constraint(equalTo: bottomBarView.rightAnchor, constant: -5).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: bottomBarView.centerYAnchor).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Set up check label
        bottomBarView.addSubview(checkButton)
        checkButton.leftAnchor.constraint(equalTo: bottomBarView.leftAnchor, constant: 5).isActive = true
        let rightAnchorOfCheckLabel =  checkButton.rightAnchor.constraint(equalTo: line1.leftAnchor, constant: -5)
        rightAnchorOfCheckLabel.priority = 750
        rightAnchorOfCheckLabel.isActive = true
        checkButton.centerYAnchor.constraint(equalTo: bottomBarView.centerYAnchor).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpPlayersLabels() {
        self.view.addSubview(userLabel)
        userLabel.bottomAnchor.constraint(equalTo: playerStartCardsView.topAnchor, constant: -10).isActive = true
        userLabel.centerXAnchor.constraint(equalTo: playerStartCardsView.centerXAnchor).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //Opponent label
        self.view.addSubview(opponentLabel)
        opponentLabel.topAnchor.constraint(equalTo: opponentStartCardsView.bottomAnchor, constant: 10).isActive = true
        opponentLabel.centerXAnchor.constraint(equalTo: opponentStartCardsView.centerXAnchor).isActive = true
        opponentLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        opponentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpTimers() {
        //Set up player timer
        self.view.addSubview(playerTimer)
        playerTimer.translatesAutoresizingMaskIntoConstraints = false
        playerTimer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        playerTimer.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: -5).isActive = true
        playerTimer.time = 15
        playerTimer.alpha = 0
        
        //Set up opponent player
        self.view.addSubview(opponentTimer)
        opponentTimer.translatesAutoresizingMaskIntoConstraints = false
        opponentTimer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        opponentTimer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        opponentTimer.time = 15
        opponentTimer.alpha = 0
    }
}
