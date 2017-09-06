//
//  ViewControllerLayer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension ViewController {
    
    func resizeButton() {
        if howToButton.titleLabel?.text == "Bluetooth"{
            makeItSmaller()
        }else {
            makeItBigger()
        }
    }
    
    fileprivate func makeItSmaller() {
        buttonsStackView.removeFromSuperview()
        setUpMenuButtons(width: 60)
    }
    
    fileprivate func makeItBigger() {
        buttonsStackView.removeFromSuperview()
        setUpMenuButtons(width: 10)
    }
   
    func sertupTopBarView() {
        self.view.addSubview(topBarView)
        topBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 17).isActive = true
        topBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        topBarView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
    
        setupUserInfoShowButton()
        setupCreditsButton()
    }
    
    func setupUserInfoContainerView() {
        self.view.addSubview(userInfoView)
        userInfoView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -54).isActive = true
        userInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topConstraint = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: userInfoView, attribute: .top, multiplier: 1, constant: 200)
        self.view.addConstraint(topConstraint!)
        
        self.view.layoutIfNeeded()
        
        setupUserPersonalInfoContainerView()
        setupLineOne()
        setupLabelsView()
        setupLineTwo()
        setupUserInfoButtons()
    }
    
    func hideUserInfoView() {
        
        guard showed == true else{return}
        
        showed = false
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            
            self.topConstraint?.constant = 200
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        topBarView.alpha = 1
        
    }
    
    func showUserInfoView() {
        
        guard showed == false || showed == nil else{return}
        
        showed = true
        
        topBarView.alpha = 0
        
        self.view.bringSubview(toFront: userInfoView)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            
            self.topConstraint?.constant = 0
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func showCreditsView() {
        setupCreditsView()
        creditsView.alpha = 0
        creditsViewBackButton.alpha = 0
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: { 
            
            self.creditsView.alpha = 1
            self.creditsViewBackButton.alpha = 1
            self.topBarView.alpha = 0
            self.buttonsStackView.alpha = 0
            
        }, completion: nil)
    }
    
    func hideCreditsView() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
            self.creditsView.alpha = 0
            self.creditsViewBackButton.alpha = 0
            self.topBarView.alpha = 1
            self.buttonsStackView.alpha = 1
        }, completion: { (finished) in
            if finished {
                self.creditsView.removeFromSuperview()
                self.creditsViewBackButton.removeFromSuperview()
            }
        })
    }
    
    fileprivate func setupCreditsView() {
        self.view.addSubview(creditsView)
        creditsView.widthAnchor.constraint(equalToConstant: 290).isActive = true
        creditsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        creditsView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        creditsView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        //Back button
        self.view.addSubview(creditsViewBackButton)
        creditsViewBackButton.topAnchor.constraint(equalTo: creditsView.bottomAnchor, constant: -11).isActive = true
        creditsViewBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        creditsViewBackButton.centerXAnchor.constraint(equalTo: creditsView.centerXAnchor).isActive = true
        creditsViewBackButton.widthAnchor.constraint(equalToConstant: 290).isActive = true
        
        //Credits label
        creditsView.addSubview(creditsInViewLabel)
        creditsInViewLabel.topAnchor.constraint(equalTo: creditsView.topAnchor, constant: 10).isActive = true
        creditsInViewLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        creditsInViewLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        creditsInViewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Line
        creditsView.addSubview(creditsLine)
        creditsLine.topAnchor.constraint(equalTo: creditsInViewLabel.bottomAnchor, constant: 10).isActive = true
        creditsLine.centerXAnchor.constraint(equalTo: creditsView.centerXAnchor).isActive = true
        creditsLine.leftAnchor.constraint(equalTo: creditsView.leftAnchor, constant: 20).isActive = true
        creditsLine.rightAnchor.constraint(equalTo: creditsView.rightAnchor, constant: -20).isActive = true
        
        
        //Jakub Pilch labels
        creditsView.addSubview(jakubPilchLabel)
        jakubPilchLabel.topAnchor.constraint(equalTo: creditsLine.bottomAnchor, constant: 10).isActive = true
        jakubPilchLabel.rightAnchor.constraint(equalTo: creditsLine.rightAnchor).isActive = true
        jakubPilchLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        jakubPilchLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        creditsView.addSubview(jakubPilchRoleLabel)
        jakubPilchRoleLabel.rightAnchor.constraint(equalTo: jakubPilchLabel.leftAnchor, constant: -5).isActive = true
        jakubPilchRoleLabel.leftAnchor.constraint(equalTo: creditsLine.leftAnchor).isActive = true
        jakubPilchRoleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        jakubPilchRoleLabel.centerYAnchor.constraint(equalTo: jakubPilchLabel.centerYAnchor).isActive = true
        
        //Szymon zimecki labels
        creditsView.addSubview(szymonZimeckiLabel)
        szymonZimeckiLabel.topAnchor.constraint(equalTo: jakubPilchLabel.bottomAnchor, constant:10).isActive = true
        szymonZimeckiLabel.rightAnchor.constraint(equalTo: creditsLine.rightAnchor).isActive = true
        szymonZimeckiLabel.widthAnchor.constraint(equalToConstant: 135).isActive = true
        szymonZimeckiLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        creditsView.addSubview(szymonZimeckiRoleLabel)
        szymonZimeckiRoleLabel.rightAnchor.constraint(equalTo: szymonZimeckiLabel.leftAnchor, constant: -5).isActive = true
        szymonZimeckiRoleLabel.leftAnchor.constraint(equalTo: creditsLine.leftAnchor).isActive = true
        szymonZimeckiRoleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        szymonZimeckiRoleLabel.centerYAnchor.constraint(equalTo: szymonZimeckiLabel.centerYAnchor).isActive = true
        
        //Mateusz bączek label
        creditsView.addSubview(mateuszBaczekLabel)
        mateuszBaczekLabel.topAnchor.constraint(equalTo: szymonZimeckiLabel.bottomAnchor, constant: 10).isActive = true
        mateuszBaczekLabel.rightAnchor.constraint(equalTo: creditsLine.rightAnchor).isActive = true
        mateuszBaczekLabel.widthAnchor.constraint(equalToConstant: 185).isActive = true
        mateuszBaczekLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        creditsView.addSubview(mateuszBaczekRoleLabel)
        mateuszBaczekRoleLabel.rightAnchor.constraint(equalTo: mateuszBaczekLabel.leftAnchor, constant: -5).isActive = true
        mateuszBaczekRoleLabel.leftAnchor.constraint(equalTo: creditsLine.leftAnchor).isActive = true
        mateuszBaczekRoleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mateuszBaczekRoleLabel.centerYAnchor.constraint(equalTo: mateuszBaczekLabel.centerYAnchor).isActive = true
    }
    
    fileprivate func setupUserInfoShowButton() {
        topBarView.addSubview(showingUserInfoButton)
        showingUserInfoButton.leftAnchor.constraint(equalTo: topBarView.leftAnchor, constant: 40).isActive = true
        showingUserInfoButton.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
        showingUserInfoButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        showingUserInfoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showUserInfoView)))
        
        
        topBarView.addSubview(miniUserImage)
        miniUserImage.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        miniUserImage.leftAnchor.constraint(equalTo: self.topBarView.leftAnchor, constant: 0).isActive = true
        miniUserImage.widthAnchor.constraint(equalToConstant: 52).isActive = true
        miniUserImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage)))
        miniUserImage.isUserInteractionEnabled = true
        
        showingUserInfoButton.addSubview(miniUserNameLabel)
        miniUserNameLabel.leftAnchor.constraint(equalTo: miniUserImage.rightAnchor, constant: 5).isActive = true
        miniUserNameLabel.rightAnchor.constraint(equalTo: showingUserInfoButton.rightAnchor).isActive = true
        miniUserNameLabel.centerYAnchor.constraint(equalTo: showingUserInfoButton.centerYAnchor).isActive = true
        miniUserNameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        miniUserNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showUserInfoView)))
    
        showingUserInfoButton.addSubview(arrow)
        arrow.rightAnchor.constraint(equalTo: showingUserInfoButton.rightAnchor, constant: -15).isActive = true
        arrow.centerYAnchor.constraint(equalTo: showingUserInfoButton.centerYAnchor).isActive = true
        arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showUserInfoView)))
    }
    
    fileprivate func setupUserInfoButtons() {
        let stack = UIStackView()
        userInfoView.addSubview(stack)
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: lineTwo.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: lineTwo.rightAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: lineTwo.bottomAnchor, constant: 10).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 22).isActive = true
        stack.spacing = 45
        stack.distribution = .fillEqually
                
        stack.addArrangedSubview(resetPasswordButton)
        stack.addArrangedSubview(logoutButton)
    }
    
    fileprivate func setupUserImageView() {
        userPersonalInfoView.addSubview(userImage)
        userImage.topAnchor.constraint(equalTo: userPersonalInfoView.topAnchor).isActive = true
        userImage.leftAnchor.constraint(equalTo: userPersonalInfoView.leftAnchor).isActive = true
        userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage)))
        userImage.isUserInteractionEnabled = true
    }
    
    fileprivate func setupUserNameLabel() {
        userPersonalInfoView.addSubview(userNameLabel)
        userNameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: userPersonalInfoView.topAnchor, constant: 6).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: userPersonalInfoView.rightAnchor).isActive = true
    }
    
    fileprivate func setupLabelsView() {
        userInfoView.addSubview(labelsView)
        labelsView.widthAnchor.constraint(equalTo: userInfoView.widthAnchor, constant: -56).isActive = true
        labelsView.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        labelsView.topAnchor.constraint(equalTo: lineOne.bottomAnchor, constant: 10).isActive = true
    
        setupLeftColumn()
        setupRightColumn()
    }
    
    fileprivate func setupUserMailLabel() {
        userPersonalInfoView.addSubview(userMailLabel)
        userMailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2).isActive = true
        userMailLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor).isActive = true
        userMailLabel.rightAnchor.constraint(equalTo: userNameLabel.rightAnchor).isActive = true
        userMailLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    fileprivate func setupLineOne() {
        userInfoView.addSubview(lineOne)
        lineOne.topAnchor.constraint(equalTo: userPersonalInfoView.bottomAnchor, constant: 10).isActive = true
        lineOne.widthAnchor.constraint(equalTo: userInfoView.widthAnchor, constant: -44).isActive = true
        lineOne.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
    }
    
    fileprivate func setupLineTwo() {
        userInfoView.addSubview(lineTwo)
        lineTwo.topAnchor.constraint(equalTo: labelsView.bottomAnchor, constant: 10).isActive = true
        lineTwo.widthAnchor.constraint(equalTo: userInfoView.widthAnchor, constant: -44).isActive = true
        lineTwo.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
    }
    
    fileprivate func setupUserPersonalInfoContainerView() {
        userInfoView.addSubview(userPersonalInfoView)
        userPersonalInfoView.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 21).isActive = true
        userPersonalInfoView.centerXAnchor.constraint(equalTo: userInfoView.centerXAnchor).isActive = true
        
        setupUserImageView()
        setupUserNameLabel()
        setupUserMailLabel()
    }
    
    fileprivate func setupRightColumn() {
        let stack = UIStackView()
        labelsView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.rightAnchor.constraint(equalTo: labelsView.rightAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: labelsView.widthAnchor, multiplier: 0.5).isActive = true
        stack.topAnchor.constraint(equalTo: labelsView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor).isActive = true
        stack.axis = .vertical
        stack.spacing = 10
    
        stack.addArrangedSubview(biggestWonStrickeLabel)
        stack.addArrangedSubview(maxPointsLabel)
        stack.addArrangedSubview(registeredDateLabel)
    }
    
    fileprivate func setupLeftColumn() {
        let stack = UIStackView()
        labelsView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: labelsView.leftAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: labelsView.widthAnchor, multiplier: 0.5).isActive = true
        stack.topAnchor.constraint(equalTo: labelsView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor).isActive = true
        stack.axis = .vertical
        stack.spacing = 10
        
        stack.addArrangedSubview(gamesPlayedLabel)
        stack.addArrangedSubview(gamesWonLabel)
        stack.addArrangedSubview(wonStrickeLabel)
    }
    
    fileprivate func setupCreditsButton() {
        topBarView.addSubview(creditsButton)
        creditsButton.rightAnchor.constraint(equalTo: topBarView.rightAnchor, constant: -10).isActive = true
        creditsButton.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
    }
    
    func setUpBackgroundImageView() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideUserInfoView))
        backgroundImageView.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    func setUpMenuButtons(width:Int) {
        //Set up buttons stack view
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(width)).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(-width)).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 176).isActive = true
            
        //Set up play button
        buttonsStackView.addArrangedSubview(playButton)
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.backgroundColor = UIColor(white: 0, alpha: width == 10 ? 0.7 : 0)
        
        //Set up credits button
        buttonsStackView.addArrangedSubview(bluetoothButton)
        bluetoothButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bluetoothButton.backgroundColor = UIColor(white: 0, alpha: width == 10 ? 0.7 : 0)
        
        //Set up logout button
        buttonsStackView.addArrangedSubview(howToButton)
        howToButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        howToButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
    }
}
