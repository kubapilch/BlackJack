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

class ViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Constraints
    var topConstraint:NSLayoutConstraint?
    var showed:Bool?
    
    //Image Picker
    let imagePickerReference = UIImagePickerController()
    
    //AFK checks variables
    var opponentFoundIsAFK:Bool?
    
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
    lazy var userInfoView: UIView = {
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
        label.text = "Games played:0"
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        return label
    }()
    
    let gamesWonLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Games won:0"
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
        label.text = "21 points times:0"
        return label
    }()
    
    let registeredDateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.text = "Registered:00.00.0000"
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
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let showingUserInfoButton: UIView = {
        var but = UIView()
        but.backgroundColor = UIColor.black
        but.translatesAutoresizingMaskIntoConstraints = false
        but.heightAnchor.constraint(equalToConstant: 35).isActive = true
        but.widthAnchor.constraint(equalToConstant: 275).isActive = true
        but.layer.cornerRadius = 10
        but.clipsToBounds = true
        return but
    }()
    
    let arrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 11).isActive = true
        imageView.image = UIImage.init(named: "pointer")
        return imageView
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
    
    let creditsView:UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        customView.layer.cornerRadius = 10
        customView.clipsToBounds = true
        return customView
    }()
    
    let creditsViewBackButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hideCreditsView), for: .touchUpInside)
        return button
    }()
    
    let creditsInViewLabel:UILabel = {
        let label = UILabel()
        label.text = "Credits"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let creditsLine:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.black
        return customView
    }()
    
    let jakubPilchLabel:UILabel = {
        let label = UILabel()
        label.text = "Jakub Pilch"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let szymonZimeckiLabel:UILabel = {
        let label = UILabel()
        label.text = "Szymon Zimecki"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mateuszBaczekLabel:UILabel = {
        let label = UILabel()
        label.text = "Mateusz Bączek"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jakubPilchRoleLabel:UILabel = {
        let label = UILabel()
        label.text = "Programmer, designer"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let szymonZimeckiRoleLabel:UILabel = {
        let label = UILabel()
        label.text = "Second designer"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mateuszBaczekRoleLabel:UILabel = {
        let label = UILabel()
        label.text = "Backend"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topBarView: UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let creditsButton: UIButton = {
        var but = UIButton()
        but.backgroundColor = UIColor(white: 1, alpha: 0.6)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.heightAnchor.constraint(equalToConstant: 35).isActive = true
        but.widthAnchor.constraint(equalToConstant: 35).isActive = true
        but.layer.cornerRadius = 17.5
        but.clipsToBounds = true
        but.layer.borderWidth = 0.5
        but.layer.borderColor = UIColor.black.cgColor
        but.setTitle("i", for: .normal)
        but.setTitleColor(.black, for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        but.addTarget(self, action: #selector(showCreditsView), for: .touchUpInside)
        return but
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
        label.text = "User"
        label.textAlignment = .left
        return label
    }()
    
    let userMailLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "user@example.com"
        return label
    }()
    
    let logoutButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.4)
        button.titleLabel?.textColor = UIColor.black
        button.addTarget(self, action: #selector(ViewController.handleLogout), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
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
    
    let bluetoothButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Ranking")
        button.color = UIColor.black
        button.addTarget(self, action: #selector(showRanking), for: .touchUpInside)
        return button
    }()
    
    let howToButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Bluetooth")
        button.color = UIColor.black
        button.addTarget(self, action: #selector(handleHowToOrCancle), for: .touchUpInside)
        return button
    }()
    
    let playButton: CustomButton = {
        var button = CustomButton()
        button.setText(text: "Play")
        button.addTarget(self, action: #selector(ViewController.handlePlay), for: .touchUpInside)
        button.color = UIColor.black
        return button
    }()

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            miniUserImage.image = image
            userImage.image = image
            changeProfileImage()
        } else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide top bar
        self.navigationController?.isNavigationBarHidden = true
        self.view.isUserInteractionEnabled = true
        
        //Set up background image view
        setUpBackgroundImageView()
        
        //Set up menu stack view and menu buttons
        setUpMenuButtons(width: 10)
        
        setupUserInfoContainerView()
        sertupTopBarView()
        
        //Delegates
        imagePickerReference.delegate = self
        
        if let user = Auth.auth().currentUser?.uid {
            userUid = user
            print(userUid!)
        }else {
            logout()
        }
    }
}

