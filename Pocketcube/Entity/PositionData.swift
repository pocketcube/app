//
//  PositionData.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 18/11/20.
//

import Foundation
import Foundation

struct PositionData: Decodable {
    var lat: String?
    var lon: String?
    var altitude: Double?
    var speed: Double?
}
