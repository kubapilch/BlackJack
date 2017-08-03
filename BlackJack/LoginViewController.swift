//
//  LoginViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 03.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let backgroundView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "list")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    let backImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "menuBackgroundImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let eMailTextField:CustomTextField = {
        var textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Siema"
        textField.textColor = UIColor.white
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackImageView()
    
        setUpBackView()
    
        addTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
