//
//  NetworkManager.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/10/20.
//

import Foundation
import SocketIO

class NetworkManager {

    private (set) static var shared: NetworkManager = NetworkManager()

    var socketManager: SocketManager
    var socket: SocketIO.SocketIOClient

    init() {
        self.socketManager = SocketManager(socketURL: URL(string: "http://0.0.0.0:5000")!, config: [.log(true), .compress])
        self.socket = socketManager.defaultSocket


        socket.on("mqtt_message") { data, action in
            debugPrint("Received data: \(data)")
            debugPrint("Received action: \(action)")
        }

        socket.connect()
    }
}
