//
//  MyCollectionViewCell.swift
//  BlackJack
//
//  Created by Kuba Pilch on 18.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    fileprivate let imageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var image = UIImage() {
        didSet{
            setImage()
        }
    }
    
    
    fileprivate func setImage() {
        imageView.image = image
    }
    
    fileprivate func setupImageView() {
        self.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
        
        setupImageView()
    }
    
}
