//
//  SocketClient.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 8/3/24.
//

import Foundation
import SocketIO


class SocketClient {
    
    private static var privateShared : SocketClient?
    
    class var shared: SocketClient {
        guard let uwShare = privateShared else {
            privateShared = SocketClient()
            return privateShared ?? SocketClient()
        }
        return uwShare
    }
    
    func socketConnect(){
        let tokenFromAbove = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDg4ODQ5NjcsImlhdCI6MTcwODc5ODU2Nywic3ViIjoxODcsInVzZXJfdHlwZSI6Im9obyJ9.T-5CVp4sL74U_6nK6EJmMoJ54RDgUUs7vD0HYtucrT0"
        let socketManager = SocketManager(socketURL: URL(string: "https://chat.backend.ohodating.com")!, config: [.log(true), .compress])
        let socket = socketManager.defaultSocket
        
        self.socketManager.config = SocketIOClientConfiguration(
                    arrayLiteral: .connectParams(["token": tokenFromAbove], .secure(true)
                )
                socket.connect()
       
        let dict =  [ "token" : tokenFromAbove]
        
        socket.connect(withPayload: dict, timeoutAfter: 2) {
            print("2nd Status \(socket != nil ? String(describing: socket.status) : "Not initialized")")
            //stream()
        }
        
        // Listening for events
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//        }
//        
//        socket.on(clientEvent: .error) {data, ack in
//            print("socket error -- \(data)")
//        }
//        
//       
//        
//        socket.emit("da39505a-284c-47c5-af38-4ce54c05e999", "This is Test Message")
//        
//        socket.emitWithAck("da39505a-284c-47c5-af38-4ce54c05e999", "This is Test Message").timingOut(after: 5) { data in
//            print(data)
//        }
       
    }
}
