//
//  UITableView.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 28/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func animateCellTableView(){
        for cell in self.visibleCells {
            cell.transform = CGAffineTransform(translationX: 0, y: self.bounds.size.height)
        }
        var delayCounter = 0
        for cell in self.visibleCells {
            UIView.animate(withDuration: 1.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
