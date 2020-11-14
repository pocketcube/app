//
//  AppFont.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import UIKit

enum AppFont: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Lato-Bold", size: size + 1.0) {
            return font
        }
        fatalError("Font 'Lato-Bold.ttf' does not exist.")
    }
}
