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

      let networkEventChannel : FlutterEventChannel = FlutterEventChannel(name: "com.example.moviesApp/networkChannel",
                                                                          binaryMessenger: controller.binaryMessenger)
      
      NetworkMonitor.shared.startMonitoring()
          
      networkChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
          guard call.method == "getNetwork" else {
              result(FlutterMethodNotImplemented)
              return
              
          }
              
          result(Bool(NetworkMonitor.shared.isReachable))
              
      })
      
      //NetworkMonitor.shared.setNetworkChannel(networkChannel: networkChannel)
      networkEventChannel.setStreamHandler(NetworkStreamHandler())
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    
    
}



class NetworkStreamHandler: NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink? = nil
    
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        if #available(iOS 12.0, *) {
            NetworkMonitor.shared.setNetworkEventSink(eventSink: events)
        } else {
            // Fallback on earlier versions
        }
        eventSink = events
        
        return nil;
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil;
    }
   

}
    

