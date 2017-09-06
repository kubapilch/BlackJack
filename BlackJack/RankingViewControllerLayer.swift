//
//  RankingViewControllerLayer.swift
//  BlackJack
//
//  Created by Kuba Pilch on 04.09.2017.
//  Copyright © 2017 Kuba Pilch. All rights reserved.
//

import Foundation
import UIKit

extension RankingViewController {
    
    func setUpBackgroundImageView() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        //Set up blur view
        setupBlurView()
    }
    
    fileprivate func setupBlurView() {
        self.view.addSubview(blurView)
        blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupLabelsView() {
        self.view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    
        setupLabels()
    }
    
    fileprivate func setupLabels() {
        //First place label
        
        containerView.addSubview(firstPlaceWinsLabel)
        firstPlaceWinsLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        firstPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        firstPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        containerView.addSubview(firstPlaceLabel)
        firstPlaceLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        firstPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        firstPlaceLabel.rightAnchor.constraint(equalTo: firstPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineOne)
        lineOne.topAnchor.constraint(equalTo: firstPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineOne.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineOne.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        //Second place label
        containerView.addSubview(secondPlaceWinsLabel)
        secondPlaceWinsLabel.topAnchor.constraint(equalTo: lineOne.bottomAnchor, constant: 15).isActive = true
        secondPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        secondPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        containerView.addSubview(secondPlaceLabel)
        secondPlaceLabel.topAnchor.constraint(equalTo: lineOne.bottomAnchor, constant: 15).isActive = true
        secondPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        secondPlaceLabel.rightAnchor.constraint(equalTo: secondPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineTwo)
        lineTwo.topAnchor.constraint(equalTo: secondPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineTwo.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineTwo.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        //Third place label
        containerView.addSubview(thirdPlaceWinsLabel)
        thirdPlaceWinsLabel.topAnchor.constraint(equalTo: lineTwo.bottomAnchor, constant: 15).isActive = true
        thirdPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        thirdPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        containerView.addSubview(thirdPlaceLabel)
        thirdPlaceLabel.topAnchor.constraint(equalTo: lineTwo.bottomAnchor, constant: 15).isActive = true
        thirdPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        thirdPlaceLabel.rightAnchor.constraint(equalTo: thirdPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineThree)
        lineThree.topAnchor.constraint(equalTo: thirdPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineThree.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineThree.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        //Fourth place label
        containerView.addSubview(fourthPlaceWinsLabel)
        fourthPlaceWinsLabel.topAnchor.constraint(equalTo: lineThree.bottomAnchor, constant: 15).isActive = true
        fourthPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        fourthPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        containerView.addSubview(fourthPlaceLabel)
        fourthPlaceLabel.topAnchor.constraint(equalTo: lineThree.bottomAnchor, constant: 15).isActive = true
        fourthPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        fourthPlaceLabel.rightAnchor.constraint(equalTo: fourthPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineFour)
        lineFour.topAnchor.constraint(equalTo: fourthPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineFour.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineFour.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        
        //Fiveth place label
        containerView.addSubview(fivethPlaceWinsLabel)
        fivethPlaceWinsLabel.topAnchor.constraint(equalTo: lineFour.bottomAnchor, constant: 15).isActive = true
        fivethPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        fivethPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        containerView.addSubview(fivethPlaceLabel)
        fivethPlaceLabel.topAnchor.constraint(equalTo: lineFour.bottomAnchor, constant: 15).isActive = true
        fivethPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        fivethPlaceLabel.rightAnchor.constraint(equalTo: fivethPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineFive)
        lineFive.topAnchor.constraint(equalTo: fivethPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineFive.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineFive.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        //set up dots
        setupDots()
        
        //Sixth label
        containerView.addSubview(sixthhPlaceWinsLabel)
        sixthhPlaceWinsLabel.topAnchor.constraint(equalTo: dotThree.bottomAnchor, constant: 15).isActive = true
        sixthhPlaceWinsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sixthhPlaceWinsLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        containerView.addSubview(sixthPlaceLabel)
        sixthPlaceLabel.topAnchor.constraint(equalTo: dotThree.bottomAnchor, constant: 15).isActive = true
        sixthPlaceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        sixthPlaceLabel.rightAnchor.constraint(equalTo: sixthhPlaceWinsLabel.leftAnchor).isActive = true
        
        containerView.addSubview(lineSix)
        lineSix.topAnchor.constraint(equalTo: sixthPlaceLabel.bottomAnchor, constant: 2).isActive = true
        lineSix.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        lineSix.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
    
    func addBackButton() {
        self.view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
    }
    
    func hideSixthLabel() {
        sixthPlaceLabel.alpha = 0
        sixthhPlaceWinsLabel.alpha = 0
        dotOne.alpha = 0
        dotTwo.alpha = 0
        dotThree.alpha = 0
        lineSix.alpha = 0
    }
    
    fileprivate func setupDots() {
        //Dot one
        containerView.addSubview(dotOne)
        dotOne.topAnchor.constraint(equalTo: lineFive.bottomAnchor, constant: 15).isActive = true
        dotOne.centerXAnchor.constraint(equalTo: lineFive.centerXAnchor).isActive = true
        
        //Dot two
        containerView.addSubview(dotTwo)
        dotTwo.topAnchor.constraint(equalTo: dotOne.bottomAnchor, constant: 10).isActive = true
        dotTwo.centerXAnchor.constraint(equalTo: dotOne.centerXAnchor).isActive = true
        
        //Dot three
        containerView.addSubview(dotThree)
        dotThree.topAnchor.constraint(equalTo: dotTwo.bottomAnchor, constant: 10).isActive = true
        dotThree.centerXAnchor.constraint(equalTo: dotTwo.centerXAnchor).isActive = true
    }
    
    
}
