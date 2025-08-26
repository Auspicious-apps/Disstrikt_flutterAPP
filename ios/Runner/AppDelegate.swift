import UIKit
import Flutter
import UserNotifications
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Set the UNUserNotificationCenter delegate
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    // Initialize Firebase
    FirebaseApp.configure()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// CRITICAL: This is the key part for foreground notifications
@available(iOS 10.0, *)
extension AppDelegate {
  // This method is called when a notification is received while the app is in the foreground
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                      willPresent notification: UNNotification,
                                      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    print("Received foreground notification: \(userInfo)")

    // IMPORTANT: These options determine how the notification appears in foreground
    let options: UNNotificationPresentationOptions
    if #available(iOS 14.0, *) {
      options = [.banner, .list, .sound, .badge]
    } else {
      options = [.alert, .sound, .badge]
    }

    // This line is critical - it tells iOS to show the notification in foreground
    completionHandler(options)
  }
}
