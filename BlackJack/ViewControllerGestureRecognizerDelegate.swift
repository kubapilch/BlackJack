//
//  ViewControllerGestureRecognizerDelegate.swift
//  BlackJack
//
//  Created by Kuba Pilch on 19.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension ViewController{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.superview!.superclass! .isSubclass(of: UIButton.self) {
            return false
        }
        return true
    }
}
