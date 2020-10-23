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
            delegate?.didReceive(data.first!, emitter: emitter)
        }

        socket.connect()
    }
}
