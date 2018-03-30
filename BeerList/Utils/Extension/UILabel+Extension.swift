//
//  UILabel+Extension.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 30/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

extension UILabel {
    
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    
    func setDynamicFont() {
        self.font = UIFont(name: self.font.fontName, size: UIView.heightScaleProportion()*self.font.pointSize)!
    }
    
}
