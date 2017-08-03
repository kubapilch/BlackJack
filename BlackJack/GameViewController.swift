//
//  GameViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import CoreGraphics

class GameViewController: UIViewController, UIGestureRecognizerDelegate{
    
    let playerTimer = Timer()
    let opponentTimer = Timer()
    
    let playerStartCardsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let opponentStartCardsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomBarView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let line1: UIView = {
        let lin = UIView()
        lin.translatesAutoresizingMaskIntoConstraints = false
        lin.backgroundColor = UIColor.white
        var anchor = lin.widthAnchor.constraint(equalToConstant: 1)
        anchor.priority = 1000
        anchor.isActive = true
        return lin
    }()
    
    let moreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 15)
        label.text = "More"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.test))
        label.addGestureRecognizer(tap)
        tap.delegate = self as? UIGestureRecognizerDelegate
        return label
    }()

    func test(sender:UITapGestureRecognizer) {
        print("test")
    }
    
    let checkLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 15)
        label.text = "Check"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        var tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.test))
        tap.delegate = self as? UIGestureRecognizerDelegate
        label.addGestureRecognizer(tap)
        return label
    }()
    
    
    
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
    
    var playerCardsOnBoard:[Card] = []
    var opponentCardsOnBoard:[Card] = []
    var playerStartCards:[Card] = []
    var opponentStartCards:[Card] = []
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up background view
        setUpBackgroundView()
        
        //Set up stuckviews
        setUpStackViews()
        
        //Set up cards imageViews
        setUpCardsImageViews()
        
        //Set up bottom bar
        layoutBottomBarView()
    
        //Set up timers
        setUpTimers()
        
        //Set all tarter cards
        setUpAllStartCardsViews()
    }
}
