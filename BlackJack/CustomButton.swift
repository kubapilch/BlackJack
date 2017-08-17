//
//  CustomButton.swift
//  BlackJack
//
//  Created by Kuba Pilch on 06.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    var color: UIColor? {
        didSet{
            self.backgroundColor = color!
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setText(text:String) {
        self.setTitle(text, for: .normal)
    }
}
