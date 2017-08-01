//
//  ViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 31.07.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "menuBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let buttonsStackView: UIStackView = {
        var stack = UIStackView()
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let creditsButton: UIButton = {
        var button = UIButton()
        button.setTitle("Credits", for: .normal)
        button.backgroundColor = UIColor.black
        button.alpha = 0.6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let playButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.black
        button.alpha = 0.6
        button.setTitle("Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.handlePlay), for: .touchUpInside)
        return button
    }()

    func handlePlay() {
        let gameController = GameViewController()
        present(gameController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide top bar
        self.navigationController?.isNavigationBarHidden = true
    
        //Set up background image view
        setUpBackgroundImageView()
    
        //Set up menu stack view and menu buttons
        setUpMenuButtons()
    }
}

