//
//  TemColorScaled.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit

public protocol TemColorScaled: class {
    var scale400: UIColor { get }
    var scale600: UIColor { get }
    var scale800: UIColor { get }
}
