//
//  AtmosphericData.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 17/11/20.
//

import Foundation

struct AtmosphericData: Decodable {
    var temperature: Double?
    var pressure: Double?
    var humidity: Double?
}
