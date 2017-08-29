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
        if howToButton.titleLabel?.text == "How to play"{
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
