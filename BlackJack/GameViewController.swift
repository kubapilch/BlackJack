//
//  GameViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let gameBackgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "game background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let playerCardsStackView:UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let opponentCardsStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let cardsStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    var  playerCardsOnBoard:[Card] = []
    var opponentCardsOnBoard:[Card] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up background view
        setUpBackgroundView()
        
        //Set up stuckviews
        setUpStackViews()
        
        //Set up cards imageViews
        setUpCardsImageViews()
    }
}
