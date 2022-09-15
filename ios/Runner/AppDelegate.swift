import UIKit
import Flutter

@available(iOS 12.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let networkChannel = FlutterMethodChannel(name: "com.example.moviesApp/network",
                                                binaryMessenger: controller.binaryMessenger)
      
      
      let networkMonitor: NetworkMonitor = NetworkMonitor()
      networkMonitor.startMonitoring()
          
      networkChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
          guard call.method == "getNetwork" else {
              result(FlutterMethodNotImplemented)
              return
              
          }
              
          self?.getNetworkStatus(result: result, networkMonitor: networkMonitor)
              
      })
   
    
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getNetworkStatus(result: FlutterResult, networkMonitor: NetworkMonitor) {

            result(Bool(networkMonitor.isReachable))
        
    }
}
