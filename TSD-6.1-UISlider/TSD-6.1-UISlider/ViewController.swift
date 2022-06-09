//
//  ViewController.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 04.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var firstButton = UIButton ()
    var secondButton = UIButton ()
    var thirdButton = UIButton ()
    var fourthButton = UIButton ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3 {
            let x : CGFloat = 50
            let y : CGFloat = 100 + CGFloat( i * 120 )
            let testButton22 = UIButton ()
            createBackground (xMain: x, yMain: y, vC: self, numberOfSound: i)
            createImageView(xMain: x, yMain: y, vC: self, numberOfImage: i)
            createNameLable(xMain: x, yMain: y, vC: self, numberOfSound: i)
            createTimeSound (xMain: x, yMain: y, vC: self, numberOfSound: i)
        }
        createButton(newButton: firstButton, xMain: 50, yMain: 100, vC: self, select: #selector(goToPlayerVC1))
        createButton(newButton: secondButton, xMain: 50, yMain: 220, vC: self, select: #selector(goToPlayerVC2))
        createButton(newButton: thirdButton, xMain: 50, yMain: 340, vC: self, select: #selector(goToPlayerVC3))
        createButton(newButton: fourthButton, xMain: 50, yMain: 460, vC: self, select: #selector(goToPlayerVC4))

    }

    
    @objc func goToPlayerVC1 () {
        goEnterVC(vC: self)
        numberOfSound = 0
    }

    @objc func goToPlayerVC2 () {
        goEnterVC(vC: self)
        numberOfSound = 1
    }
    
    @objc func goToPlayerVC3 () {
        goEnterVC(vC: self)
        numberOfSound = 2
    }
    
    @objc func goToPlayerVC4 () {
        goEnterVC(vC: self)
        numberOfSound = 3
    }


}

