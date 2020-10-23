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

        if key == .temperature {
            return getContent(type: Temperature.self, data: payloadContent)
        }

        return nil
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
