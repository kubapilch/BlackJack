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

class ViewController: UIViewController {

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
    
    //BAckground images
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
        
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
        }else {
            logout()
        }
        
        //Set up background image viewTy też płać mniej w Play! Przenieś numer!
        setUpBackgroundImageView()
    
        //Set up menu stack view and menu buttons
        setUpMenuButtons(width: 10)
    }
}

