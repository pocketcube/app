//
//  ColorComponent.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit

public enum AppType {
    case bikeItau
    case ecobici
    case tembici
}

public class BaseColor: TemColor {

    public var primaryColor: UIColor {
        return .black
    }

    public var secondaryColor: UIColor {
        return .gray
    }

    public var textColor: UIColor {
        return .gray
    }
}
