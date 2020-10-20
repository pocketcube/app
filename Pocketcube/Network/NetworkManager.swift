//
//  NetworkManager.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/10/20.
//

import Foundation
import SocketIO

protocol NetworkManagerDelegate: class {
    func didReceive(_ data: Any, emitter: SocketAckEmitter)
}

class NetworkManager {

    private (set) static var shared: NetworkManager = NetworkManager()

    var socketManager: SocketManager
    var socket: SocketIO.SocketIOClient

    init() {
        self.socketManager = SocketManager(socketURL: Config.serverUrl , config: [.log(false), .compress])
        self.socket = socketManager.defaultSocket
    }

    func observe(for key: String = MQTTKeys.port.rawValue, delegate: NetworkManagerDelegate? = nil) {
        socket.on(key) { data, emitter in
            delegate?.didReceive(data.first, emitter: emitter)
        }

        socket.connect()
    }
}

enum  MQTTKeys: String {
    case port = "mqtt_message"
}

enum SensorKey: String {
    case temperature
    case oxygen
    case gps

    init(key: String) {
        switch key {
        case "sensor/oxygen":
            self = .oxygen
        case "sensor/temperature":
            self = .temperature
        case "sensor/gps":
            self = .gps
        default:
            self = .temperature
        }
    }


}

struct SensorFactory {

    var key: SensorKey

    init(key: String) {
        self.key = SensorKey.init(key: key)
    }

    func getValue(_ stringfiedData: String, payload: String) -> Any? {
        guard let data = stringfiedData.data(using: .utf8),
              let payloadContent = payload.data(using: .utf8) else { fatalError() }

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

struct Temperature: Decodable {
    var temp: Double
}
