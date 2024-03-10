import Foundation
import SocketIO

/// Singleton class responsible for managing socket connections and sending messages.
class SocketClient {
    
    /// Shared instance of SocketClient for singleton pattern.
    private static var privateShared: SocketClient?
    
    /// Singleton instance of SocketClient.
    class var shared: SocketClient {
        guard let shared = privateShared else {
            privateShared = SocketClient()
            return privateShared ?? SocketClient()
        }
        return shared
    }
    
    /// SocketIO client instance.
    var socket: SocketIOClient?
    
    /// Socket manager instance.
    private var manager: SocketManager?
    
    /// Establishes a socket connection and notifies the completion handler.
    /// - Parameter complete: A closure to be called when the connection is established.
    func socketConnection(complete: @escaping (Bool) -> Void) {
        if let socketURL = URL(string: Bundle.main.infoDictionary?["SocketUrl"] as? String  ?? "") {
            let config: SocketIOClientConfiguration = [.log(true), .forceWebsockets(true), .secure(true)]
            manager = SocketManager(socketURL: socketURL, config: config)
            socket = manager?.defaultSocket
            
            // Event handlers for socket events
            socket?.on(clientEvent: .connect) { (data, ack) in
                complete(true)
            }
            socket?.on(clientEvent: .disconnect) { (data, ack) in
                complete(false)
            }
            socket?.on(clientEvent: .error) { (data, ack) in
                if let errorStr = data.first as? String, errorStr.hasPrefix("ERR_SOCKETIO_INVALID_SESSION") {
                    self.manager?.disconnect()
                    print("SocketClient: Error - \(errorStr)")
                }
            }
            
            // Connect to the socket with payload (e.g., authentication token)
            socket?.connect(withPayload: ["token": Bundle.main.infoDictionary?["SocketToken"] as? String ?? ""])
        } else {
            complete(false)
        }
    }
    
    /// Sends a message to the specified chat room.
    /// - Parameters:
    ///   - chatRoom: The identifier of the chat room.
    ///   - message: The message to be sent.
    func sendMessage(chatRoom: String, message: String) {
        if let socket = self.socket, socket.status == .connected {
            socket.emitWithAck(chatRoom, message).timingOut(after: 0) { data in
                // Handle acknowledgment data if necessary
            }
        } else {
            print("SocketClient: Socket is not connected")
        }
    }
    
    /// Disconnects the socket manager when the SocketClient is deallocated.
    deinit {
        if let manager = self.manager {
            manager.disconnect()
        }
    }
}


//            socket?.onAny {
//                    print("Got event: \($0.event), with items: \(String(describing: $0.items))")
//                }

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
