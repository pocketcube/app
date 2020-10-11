//
//  TemColor.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit

public protocol TemColor: class {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var textColor: UIColor { get }
}
