//
//  ViewControllerLayer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension ViewController {
    func setUpBackgroundImageView() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpMenuButtons() {
        //Set up buttons stack view
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
            
        //Set up play button
        buttonsStackView.addArrangedSubview(playButton)
        //playButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Set up credits button
        buttonsStackView.addArrangedSubview(creditsButton)
        //creditsButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        creditsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
