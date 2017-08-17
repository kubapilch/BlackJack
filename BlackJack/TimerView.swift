//
//  Timer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 02.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    var counter = UILabel()
    var time:Int? {
        didSet{
            counter.text = "\(time!)s"
        }
    }
    
    private func setSizeOfView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
    }
    
    private func setTimerLabel() {
        addSubview(counter)
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        counter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        counter.widthAnchor.constraint(equalToConstant: 30).isActive = true
        counter.heightAnchor.constraint(equalToConstant: 29).isActive = true
        counter.font = UIFont(name: "Roboto", size: 10)
        counter.textAlignment = .center
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set size and form of view
        setSizeOfView()
        
        //Set timer label
        setTimerLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
