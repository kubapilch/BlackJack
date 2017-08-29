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
        if logoutButton.titleLabel?.text == "Logout"{
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
    
    func test(gestureRecognizer: UITapGestureRecognizer) {
        print("test")
    }
    
    func sertupTopBarView() {
        self.view.addSubview(topBarView)
        topBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 2).isActive = true
        topBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        topBarView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
    
        setupUserInfoShowButton()
    }
    
    func setupUserInfoContainerView() {
        self.view.addSubview(userInfoView)
        userInfoView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -54).isActive = true
        userInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userInfoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
    
        setupUserPersonalInfoContainerView()
        setupLineOne()
        setupLabelsView()
        setupLineTwo()
        setupUserInfoButtons()
    }
    
    fileprivate func setupUserInfoShowButton() {
        topBarView.addSubview(miniUserImage)
        miniUserImage.leftAnchor.constraint(equalTo: topBarView.leftAnchor).isActive = true
        miniUserImage.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
    
        topBarView.addSubview(showingUserInfoButton)
        showingUserInfoButton.leftAnchor.constraint(equalTo: miniUserImage.rightAnchor, constant: -5).isActive = true
        showingUserInfoButton.centerYAnchor.constraint(equalTo: miniUserImage.centerYAnchor).isActive = true
    
        topBarView.addSubview(miniUserNameLabel)
        miniUserNameLabel.leftAnchor.constraint(equalTo: miniUserImage.rightAnchor, constant: 10).isActive = true
        miniUserImage.centerYAnchor.constraint(equalTo: showingUserInfoButton.centerYAnchor).isActive = true
        miniUserNameLabel.rightAnchor.constraint(equalTo: showingUserInfoButton.rightAnchor, constant: 31).isActive = true
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
        stack.addArrangedSubview(logoutButton2)
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
    
    func setUpBackgroundImageView() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(test(gestureRecognizer:)))
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
        buttonsStackView.addArrangedSubview(creditsButton)
        creditsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        creditsButton.backgroundColor = UIColor(white: 0, alpha: width == 10 ? 0.7 : 0)
        
        //Set up logout button
        buttonsStackView.addArrangedSubview(logoutButton)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
    }
}
