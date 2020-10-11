//
//  TemTheme.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import Foundation

public typealias ColorComponent = TemColor & TemColorScaled

public protocol TemTheme {
    var colors: ColorComponent { get }
    // TODO: - Add more stuff fonts, keys,
}
