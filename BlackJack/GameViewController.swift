//
//  GameViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 01.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import CoreGraphics
import Firebase

class GameViewController: UIViewController, UIGestureRecognizerDelegate{
    
    // Enumeration variables
    enum type {
        case server
        case client
    }
    var side: type?
    
    
    //All cards arrays
    var playerCardsOnBoard:[Card] = []
    var opponentCardsOnBoard:[Card] = []
    var playerStartCards:[Card] = []
    var opponentStartCards:[Card] = []
    var cards = [Card]()
    
    
    //All references
    var ref:DatabaseReference?
    var opponentUid: String?
    var playerUid: String?
    var gameRoomReference:String?
    
    
    //Timers
    let playerTimer = TimerView()
    let opponentTimer = TimerView()
    var playerTimerReference: Timer?
    var opponentTimerReference: Timer?
    
    
    //Players names variables
    var playerName: String? {
        didSet{
            userLabel.text = playerName
        }
    }
    var opponentName: String? {
        didSet{
            opponentLabel.text = opponentName
        }
    }
    
    
    //Players names labels
    let userLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 50)
        label.textAlignment = .center
        return label
    }()
    
    let opponentLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    
    //Starting cards stack views
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
    
    
    //Bottom bar
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
    
    let moreButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.titleLabel?.font = UIFont(name: "Roboto", size: 15)
        but.setTitle("More", for: .normal)
        but.titleLabel?.textColor = UIColor.white
        but.isUserInteractionEnabled = true
        but.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return but
    }()

    let checkButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.titleLabel?.font = UIFont(name: "Roboto", size: 15)
        but.setTitle("Check", for: .normal)
        but.titleLabel?.textColor = UIColor.white
        but.isUserInteractionEnabled = true
        but.addTarget(self, action: #selector(handleCheck), for: .touchUpInside)
        return but
    }()
    
    
    //Background image
    let gameBackgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "game background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //On table stack views
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
    
    
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //Set up background view
        setUpBackgroundView()
        
        //Set up stuckviews
        setUpStackViews()
        
        //Set up cards imageViews
        //setUpCardsImageViews()
        
        //Set up bottom bar
        layoutBottomBarView()
    
        //Set up timers
        setUpTimers()
        
        //Set all tarter cards
        setUpAllStartCardsViews()
    
        setUpPlayersLabels()
        setLabels()
        
        setType()
    }
} 
