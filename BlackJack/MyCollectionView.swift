//
//  MyCollectionView.swift
//  BlackJack
//
//  Created by Kuba Pilch on 17.08.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import UIKit

class MyCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var cards = [UIImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.clear
    
        self.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func addCell(image:UIImage) {
        cards.append(image)
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MyCollectionViewCell
    
        cell.image = cards[indexPath.item]
        return cell
    }
    
    
}
