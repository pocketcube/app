//
//  UIView+Extensions.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 11/10/20.
//

import UIKit

let darkBlue = UIColor(red: 0.10, green: 0.11, blue: 0.28, alpha: 1.00)
let secondDarkBlue = UIColor(red: 0.22, green: 0.24, blue: 0.62, alpha: 1.00)

extension UIView {

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [secondDarkBlue.cgColor, darkBlue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
