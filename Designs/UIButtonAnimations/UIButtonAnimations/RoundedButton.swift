//
//  RoundedButton.swift
//  UIButtonAnimations
//
//  Created by Kızılay on 19.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

class RoundedButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    //need for when you initialize via Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        
    }
    
    private func setShadow(shadowColor: UIColor, shadowRadius: CGFloat){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.5
        clipsToBounds = false
        layer.masksToBounds = true
    }
    
}
extension UIButton{
    func shakeBottomButton(){
        let shake = CABasicAnimation(
    }
}
