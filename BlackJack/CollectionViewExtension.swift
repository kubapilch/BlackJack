//
//  CollectionViewExtension.swift
//  BlackJack
//
//  Created by Kuba Pilch on 17.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

extension GameViewController{

    func setupPlayerCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: 68)
        
        let frame = CGRect(x: 0, y: -68, width: Int(self.view.frame.width), height: 68)
        playerCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        playerCollectionView.dataSource = self
        playerCollectionView.delegate = self
        playerCollectionView.backgroundColor = UIColor.clear
        playerCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        playerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
         self.view.addSubview(playerCollectionView)
        
        playerCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
        playerCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        playerCollectionView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        playerCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupOpponentCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: 68)
        
        let frame = CGRect(x: 0, y: 68, width: Int(self.view.frame.width), height: 68)
        
        opponentCollectionView = MyCollectionView(frame: frame, collectionViewLayout: layout)
        opponentCollectionView.translatesAutoresizingMaskIntoConstraints = false 
        
        self.view.addSubview(opponentCollectionView)
        
        opponentCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        opponentCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        opponentCollectionView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        opponentCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    
}
