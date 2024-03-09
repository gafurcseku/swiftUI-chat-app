//
//  SocketClient.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 8/3/24.
//

import Foundation
import SocketIO

let socketUrl = Bundle.main.infoDictionary?["SocketUrl"] as? String  ?? ""

class SocketClient {
    
    private static var privateShared : SocketClient?
    
    class var shared: SocketClient {
        guard let uwShare = privateShared else {
            privateShared = SocketClient()
            return privateShared ?? SocketClient()
        }
        return uwShare
    }
    
     var socket:SocketIOClient?
    private var manager:SocketManager?
    
    func socketConnection(complete:@escaping (Bool) -> Void){
        if let socketURL = URL(string: socketUrl) {
            let config: SocketIOClientConfiguration = [.log(true),.forceWebsockets(true), .secure(true)]
            manager = SocketManager.init(socketURL: socketURL, config: config)
            socket = manager?.defaultSocket
            socket?.on(clientEvent: .connect) { (data, ack) in
                complete(true)
            }
            socket?.on(clientEvent: .disconnect) { (data, ack) in
               complete(false)
            }
            
            socket?.on(clientEvent: .error) { (data, ack) in
                if let errorStr: String = (data[0] as? String) {
                    if errorStr.hasPrefix("ERR_SOCKETIO_INVALID_SESSION") {
                        self.manager?.disconnect()
                        print("App Chat: error \(errorStr)")
                    }
                }
            }
//            
//            socket?.onAny {
//                    print("Got event: \($0.event), with items: \(String(describing: $0.items))")
//                }
//            let acces = Bundle.main.infoDictionary?["SocketToken"] as? String  ?? ""
            socket?.connect(withPayload: ["token" : Bundle.main.infoDictionary?["SocketToken"] as? String  ?? ""])
        }else{
            complete(false)
        }
    }
    
    func sendMessage(chatRoom:String, message:String) {
        if let socket = self.socket {
            if(socket.status == SocketIOStatus.connected) {
                socket.emit(chatRoom, message)
//                socket.on("da39505a-284c-47c5-af38-4ce54c05e999", callback: { [weak self] data, ack in
//                    print("Socket data -\(data[0])")
//                })
//                socket.emitWithAck("da39505a-284c-47c5-af38-4ce54c05e999", "iOSMesssage").timingOut(after: 5) {data in
//                    print("emitWithAck data -\(data)")
//                }
//                socket.emitWithAck("private message", ["roomName": "adf110e0-e120-45e1-83be-fbfdec026551", "chat_id": "94"]).timingOut(after: 0) {data in
//                    print("private emitWithAck data -\(data)")
//                }
            }else{
                print("socket Not Connected")
            }
            
        }else{
        print("socket null")
        }
    }
    
    deinit {
        if let manager = self.manager {
            manager.disconnect()
        }
    }
    
}


//socket.on(clientEvent: .connect) { (data, ack) in
//    print("App Chat: socket connected")
//}
//
//socket.on(clientEvent: .disconnect) { (data, ack) in
//    print("App Chat: Disconnect")
//}
//
//socket.on(clientEvent: .error) { (data, ack) in
//    if let errorStr: String = (data[0] as? String) {
//        if errorStr.hasPrefix("ERR_SOCKETIO_INVALID_SESSION") {
//            manager.disconnect()
//            print("App Chat: error \(errorStr)")
//        }
//    }
//}
//
//socket.on(clientEvent: .reconnect) { (data, ack) in
//    print("App Chat: reconnect");
//}
//
//socket.on(clientEvent: .reconnectAttempt) { (data, ack) in
//    print("App Chat: reconnectAttempt");
//}
//
//socket.on("message") {data, ack in
//    print("App Chat: Message Received\(data)")
//}
