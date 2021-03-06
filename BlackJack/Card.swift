//
//  Card.swift
//  BlackJack
//
//  Created by Kuba Pilch on 02.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class Card: UIView{
    
    let borderView: UIView = {
        var view = UIView()
        view.heightAnchor.constraint(equalToConstant: 76).isActive = true
        view.widthAnchor.constraint(equalToConstant: 54).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var rank:Int? {
        didSet{
            frontImageView.image = UIImage(named: "\(rank!)")
        }
    }
    var name:String? {
        didSet{
            retriveNameAndRank()
        }
    }
    var frontImageView = UIImageView()
    var backImageView = UIImageView()
    var isUpSideDown:Bool? {
        didSet{
            if isUpSideDown! {
                frontImageView.alpha = 0
                backImageView.alpha = 1
            }else {
                frontImageView.alpha = 1
                backImageView.alpha = 0
            }
        }
    }
    
    private func retriveNameAndRank() {
        var num = 0
        var num2 = 0
        var halfNumber = ""
        var now = false
        let numbers = ["0","1","2","3","4","5","6","7","8","9"]
        for lettre in (name?.characters)! {
            if num == 0 && lettre == "0" && num2 == 0{
                num += 1
                now = true
            }else if num == 1 && now && numbers.contains(String(lettre)) {
                let foundNumber = Int(String(lettre))
                num += 1
                now = false
                rank = foundNumber
            }else if numbers.contains(String(lettre)) {
                halfNumber = "\(halfNumber)\(lettre)"
                if num2 == 1 {
                    rank = Int(halfNumber)
                }else {
                    num2 += 1
                }
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
    
    fileprivate func setupBorderView() {
        self.addSubview(borderView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setup(color:UIColor) {
        borderView.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupBorderView()
        laySubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
