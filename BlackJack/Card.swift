//
//  Card.swift
//  BlackJack
//
//  Created by Kuba Pilch on 02.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class Card: UIView{
    
    var rank:Int?
    var name:String?
    var frontImageView = UIImageView()
    var backImageView = UIImageView()
    var isUpSideDown = false {
        didSet{
            if isUpSideDown {
                frontImageView.alpha = 0
                backImageView.alpha = 1
            }
        }
    }
    
    private func laySubViews() {
        //Set up front image view
        self.addSubview(frontImageView)
        frontImageView.translatesAutoresizingMaskIntoConstraints = false
        frontImageView.contentMode = .scaleAspectFill
        frontImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        frontImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        frontImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        frontImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
        //Set up back image view
        self.addSubview(backImageView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.contentMode = .scaleAspectFill
        backImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        backImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backImageView.alpha = 0
        backImageView.image = UIImage(named: "back")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        laySubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFrontImageView(name:String) {
        frontImageView.image = UIImage(named:name)
    }
    
    
    
}
