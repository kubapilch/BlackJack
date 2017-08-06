//
//  CustomButton.swift
//  BlackJack
//
//  Created by Kuba Pilch on 06.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.black
        self.alpha = 0.6
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setText(text:String) {
        self.setTitle(text, for: .normal)
    }
}
