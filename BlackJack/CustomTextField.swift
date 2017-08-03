//
//  CustomTextField.swift
//  BlackJack
//
//  Created by Kuba Pilch on 03.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clear
    }
}
