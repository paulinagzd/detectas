import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // ADDED API KEY HERE
    GMSServices.provideAPIKey("AIzaSyBxq978quqbPfNx-D8qv-a92KPpByANzFc")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
