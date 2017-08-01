//
//  GameViewControllerExtension.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import Foundation

extension GameViewController {
    
    func setUpBackgroundView() {
        self.view.addSubview(gameBackgroundImageView)
        gameBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gameBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        gameBackgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}
