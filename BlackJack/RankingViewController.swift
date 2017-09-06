//
//  RankingViewController.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.09.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    //Vars
    var isInTopFive:Bool = false
    var users = [User]()
    
    
    let dotOne:UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.layer.cornerRadius = 7.5
        customView.clipsToBounds = true
        customView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let dotTwo:UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.layer.cornerRadius = 7.5
        customView.clipsToBounds = true
        customView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let dotThree:UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.layer.cornerRadius = 7.5
        customView.clipsToBounds = true
        customView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let firstPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "1. "
        return label
    }()
    
    let firstPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = ""
        return label
    }()
    
    let secondPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "2. "
        return label
    }()
    
    let secondPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.text = ""
        return label
    }()
    
    let thirdPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "3. "
        return label
    }()
    
    let thirdPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.text = ""
        return label
    }()
    
    let fourthPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "4. "
        return label
    }()
    
    let fourthPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    let fivethPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "5. "
        return label
    }()
    
    let fivethPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    
    let sixthPlaceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = "10."
        return label
    }()
    
    let sixthhPlaceWinsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.text = ""
        return label
    }()
    
    let lineOne:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let lineTwo:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let lineThree:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let lineFour:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let lineFive:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let lineSix:UIView = {
        var customView = UIView()
        customView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor.white
        return customView
    }()
    
    let blurView:UIView = {
        let customView = UIView()
        customView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "menuBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let containerView:UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let backButton: UIButton = {
        var but = UIButton()
        but.setTitle("<-- Back", for: .normal)
        but.backgroundColor = UIColor.clear
        but.setTitleColor(UIColor.white, for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.widthAnchor.constraint(equalToConstant: 100).isActive = true
        but.heightAnchor.constraint(equalToConstant: 50).isActive = true
        but.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return but
    }()
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background image view
        setUpBackgroundImageView()
        
        addBackButton()
        
        setupLabelsView()
        
        hideSixthLabel()
        
        getData()
    }
}
