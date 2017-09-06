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

class GameViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    // Enumeration variables
    enum type {
        case server
        case client
    }
    var side: type?
    
    //Clients variables
    var winner: String?
    
    //AFK variables
    var opponnentIsAFK:Bool?
    var opponentIsAFKStarting:Bool?
    
    //CollectionViews
    var playerCollectionView: UICollectionView!
    var opponentCollectionView: MyCollectionView!
    
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
    
    //Players profiles images
    let playerProfileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let opponentProfileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
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
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //Set up background view
        setUpBackgroundView()
        
        //Set up bottom bar
        layoutBottomBarView()
    
        //Set up timers
        setUpTimers()
        
        //Set up players images views
        setupPlayersImagesViews()
        
        //Set all tarter cards
        setUpAllStartCardsViews()
    
        setUpPlayersLabels()
        setLabels()
        
        setType()
    
        setupPlayerCollectionView()
    
        setupOpponentCollectionView()
    
        setPlayersImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerCardsOnBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MyCollectionViewCell
                
        let imageName = playerCardsOnBoard[indexPath.item].rank!
        cell.image = UIImage(named: String(imageName))!
        
        return cell
    }
    
} 
