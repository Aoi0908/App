//
//  Aoi_LTAppApp.swift
//  Aoi_LTApp
//
//  Created by 髙津悠樹 on 2023/01/28.
//


import SwiftUI
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct YourApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
            }
        }
    }
}
