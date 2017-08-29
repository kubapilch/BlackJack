//
//  ViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 31.07.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    //Side type and variable
    enum type {
        case server
        case client
    }
    var side: type?
    
    //Game room references
    var roomReference:String? {
        didSet{
            prepareForGame()
        }
    }
    
    //Players uids
    var userUid: String?
    var opponentUid: String?
    var pairUid: String? {
        didSet {
            joinToQueue(withUid: pairUid!)
        }
    }
    
    //User Info
    let userInfoView: UIView = {
        var customView = UIView()
        customView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return customView
    }()
    
    let gamesPlayedLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Games played:12"
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        return label
    }()
    
    let gamesWonLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Games won: 10"
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        return label
    }()
    
    let wonStrickeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Win stricke:0"
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        return label
    }()
    
    let biggestWonStrickeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.text = "Biggest win stricke:0"
        return label
    }()
    
    let maxPointsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.text = "21 points times:1"
        return label
    }()
    
    let registeredDateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.text = "Registered:14.07.2017"
        return label
    }()
    
    let labelsView: UIView = {
        var customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return customView
    }()
    
    let miniUserNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Kuba Pilch"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let showingUserInfoButton: UIView = {
        var but = UIView()
        but.backgroundColor = UIColor.black
        but.translatesAutoresizingMaskIntoConstraints = false
        but.heightAnchor.constraint(equalToConstant: 30).isActive = true
        but.widthAnchor.constraint(equalToConstant: 275).isActive = true
        but.layer.cornerRadius = 10
        but.clipsToBounds = true
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.heightAnchor.constraint(equalToConstant: 8).isActive = true
        arrow.widthAnchor.constraint(equalToConstant: 11).isActive = true
        but.addSubview(arrow)
        arrow.rightAnchor.constraint(equalTo: but.rightAnchor, constant: 10).isActive = true
        arrow.centerYAnchor.constraint(equalTo: but.centerYAnchor).isActive = true
        return but
    }()
    
    let miniUserImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 26
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        return imageView
    }()
    
    let topBarView: UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let userImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 26
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kuba Pilch"
        label.textAlignment = .left
        return label
    }()
    
    let userMailLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Kuba.pilch2001@gmail.com"
        return label
    }()
    
    let logoutButton2: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.4)
        button.titleLabel?.textColor = UIColor.black
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let resetPasswordButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 0, alpha: 0.4)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("Reset Password", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let lineOne: UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.black
        return customView
    }()
    
    let lineTwo: UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.black
        return customView
    }()
    
    let userPersonalInfoView: UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    //Background images
    let backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "menuBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //Buttons
    let buttonsStackView: UIStackView = {
        var stack = UIStackView()
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let creditsButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Credits")
        button.color = UIColor.black
        return button
    }()
    
    let logoutButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Logout")
        button.addTarget(self, action: #selector(ViewController.handleLogout), for: .touchUpInside)
        button.color = UIColor.black
        return button
    }()
    
    let playButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Play")
        button.addTarget(self, action: #selector(ViewController.handlePlay), for: .touchUpInside)
        button.color = UIColor.black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide top bar
        self.navigationController?.isNavigationBarHidden = true
        self.view.isUserInteractionEnabled = true
        
        //Set up background image view
        setUpBackgroundImageView()
        
        //Set up menu stack view and menu buttons
        setUpMenuButtons(width: 10)
        
        //setupUserInfoContainerView()
        sertupTopBarView()
        
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
        }else {
            logout()
        }
    }
}

