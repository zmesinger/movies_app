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
    var networkChannel: FlutterMethodChannel?
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
            
            self?.networkChannel?.invokeMethod("onNetworkChanged", arguments: [
                "status" : !(path.status == .satisfied), 
            ])
            
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func setNetworkChannel(networkChannel: FlutterMethodChannel){
        self.networkChannel = networkChannel
    }
    
    

    func stopMonitoring() {
        monitor.cancel()
    }
}
