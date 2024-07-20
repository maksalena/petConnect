//
//  AppDelegate.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import UIKit
import MapKit
import FirebaseCore
import UserNotifications
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let keychainService:KeyChainStorageProtocol = KeyChainStorage()
    let userDefaultsService:UserDefaultsServiceProtocol = UserDefaultsService()
    
    var manager:CLLocationManager =  {
        let manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        return manager
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        RealmMigrations.migrate()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        registerForPushNotifications()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        Messaging.messaging().delegate = self
        
        if userDefaultsService.isFirstLaunch(){
            keychainService.deleteAll()
            let realm =  try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
                        
        return true
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
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            UNUserNotificationCenter.current().delegate = self
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
        
    }
}


extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
}

extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                let tokenSlitted = token.split(separator: ":")
                let firebaseToken = tokenSlitted[1]
                let deviceId = tokenSlitted[0]
                self.keychainService.setFirebaseToken(token: String(firebaseToken))
                self.keychainService.setDeviceId(deviceId: String(deviceId))
            }
        }
    }
}
