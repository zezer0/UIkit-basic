//
//  AppDelegate.swift
//  SpotifyLoginSampleApp
//
//  Created by 재영신 on 2022/01/19.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        registerRemoteNotification()
        return true
    }
    
    private func registerRemoteNotification() {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            center.requestAuthorization(options: options) { granted, _ in
                // 1. APNs에 device token 등록 요청
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

               print(url)
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          Messaging.messaging().apnsToken = deviceToken
      }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        // deep link처리 시 아래 url값 가지고 처리
        
        let userInfo = response.notification.request.content.userInfo
              print(userInfo)
              print(userInfo["url"] as? String)
              guard let deepLinkUrl = userInfo["url"] as? String,
                  let url = URL(string: deepLinkUrl) else { return }

              // 해당 host를 가지고 있는지 확인
              guard url.host == "navigation" else { return }

              // 원하는 query parameter가 있는지 확인
              let urlString = url.absoluteString
              guard urlString.contains("ㅇname") else { return }

              // URL을 URLComponent로 만들어서 parameter값 가져오기 쉽게 접근
              let components = URLComponents(string: urlString)

              // URLQueryItem 형식은 [name: value] 쌍으로 되어있으서 Dctionary로 변형
              let urlQueryItems = components?.queryItems ?? []
              var dictionaryData = [String: String]()
              urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
              guard let name = dictionaryData["name"] else { return }

              print("네임 = \(name)")

        
    }
}
