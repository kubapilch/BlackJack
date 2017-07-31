//
//  ViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 31.07.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "menuBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide top bar
        self.navigationController?.isNavigationBarHidden = true
    
        //Set up background image view
        setUpBackgroundImageView()
    }
}

