//
//  UIView+Extensions.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 11/10/20.
//

import UIKit

extension UIView {

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
