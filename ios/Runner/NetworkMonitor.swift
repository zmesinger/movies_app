//
//  NetworkMonitor.swift
//  Runner
//
//  Created by Atos CVC Mac Os on 14.09.2022..
//

import Foundation
import Network

@available(iOS 12.0, *)
class NetworkMonitor {
    var eventSink: FlutterEventSink?
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                print("We're connected!")
                // post connected notification
            } else {
                print("No connection.")
                // post disconnected notification
            }
            
            //TODO: Replace with eventsink
//            self?.networkChannel?.invokeMethod("onNetworkChanged", arguments: [
//                "status" : !(path.status == .satisfied),
//            ])
            
            if((self?.eventSink) != nil){
                self?.eventSink!(
                    ["status" : !(path.status == .satisfied),
                    ]
                )
                
            }
            
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
 
    
    func setNetworkEventSink(eventSink: @escaping FlutterEventSink){
        self.eventSink = eventSink
    }
    
    

    func stopMonitoring() {
        monitor.cancel()
    }
}
