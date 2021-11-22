//
//  AppDelegate.swift
//  Uber Clone
//
//  Created by Andre Linces on 03/10/21.
//

import UIKit
import Firebase

//Para o funcionamento no iOS 14 e posterior é necessário adicionar transparency
import AppTrackingTransparency
import AdSupport

//Permissao para notificacoes
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("TESTE APPDELEGATE : didFinishLaunchingWithOptions")
        
        FirebaseApp.configure()
        
        requestIDFA()
        
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
    
    //Para user notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        print("Entrou no User notification")
    }
    
    //Transparency for iOS 14
    func requestIDFA() {
        
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization { status  in
//                print("Exibiu alerta trackTransparency")
//            }
//        }else
        
        if #available(iOS 15, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    DispatchQueue.main.async {
                        print("exibir track")
                        self.localNotification()
                    }
                })
                
            }
            
        }else if #available(iOS 14, *){
            ATTrackingManager.requestTrackingAuthorization { status  in
                print("Exibiu alerta trackTransparency")
            }
        }else {
            print("ERROR")
        }
    }
    
    func localNotification() {
        
        let center = UNUserNotificationCenter.current()
        
        let options : UNAuthorizationOptions = [.sound, .alert]
        
        center.requestAuthorization(options: options) { granted, error in
            if error != nil {
                print("Error : \(error)")
            }else if granted {
                print("Aceitou")
                self.requestIDFA()
            }
        }
        
        center.delegate = self
        
    }
    
    
    
}

