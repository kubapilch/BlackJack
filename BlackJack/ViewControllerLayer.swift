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
    
    func setUpBackgroundImageView() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
        //playButton.alpha = width == 10 ? 0.7 : 0
        playButton.backgroundColor = UIColor(white: 0, alpha: width == 10 ? 0.7 : 0)
        
        //Set up credits button
        buttonsStackView.addArrangedSubview(creditsButton)
        creditsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //creditsButton.alpha = width == 10 ? 0.7 : 0
        creditsButton.backgroundColor = UIColor(white: 0, alpha: width == 10 ? 0.7 : 0)
        
        //Set up logout button
        buttonsStackView.addArrangedSubview(logoutButton)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //logoutButton.alpha = 0.7
        logoutButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
    }
}
