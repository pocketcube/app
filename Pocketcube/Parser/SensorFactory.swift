//
//  SensorFactory.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 22/10/20.
//

import Foundation

struct SensorFactory {

    var key: SensorKey

    init(key: String) {
        self.key = SensorKey.init(key: key)
    }

    func getValue(_ stringfiedData: String, payload: String) -> Any? {
        guard let payloadContent = payload.data(using: .utf8) else { fatalError() }

        switch key {
        case .athmospheric:
            return getContent(type: AtmosphericData.self, data: payloadContent)
        case .gases:
            return getContent(type: GasesData.self, data: payloadContent)
        case .gps:
            return getContent(type: PositionData.self, data: payloadContent)
        }
    }

    private func getContent<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}
