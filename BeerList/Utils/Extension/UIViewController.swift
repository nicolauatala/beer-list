//
//  UIViewController.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 28/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setInteractiveRecognizer(popRecognizer: inout InteractivePopRecognizer?) {
        guard let controller = navigationController else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }
}
