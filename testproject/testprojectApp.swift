//
//  testprojectApp.swift
//  testproject
//
//  Created by Zaynah Wahab on 11/12/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("🚀 Starting Firebase configuration...")
        FirebaseApp.configure()
        
        // Check if Firebase initialized successfully
        if FirebaseApp.app() != nil {
            print("✅ Firebase configured successfully!")
        } else {
            print("❌ Firebase configuration failed!")
        }
        
        return true
    }
}

@main
struct testprojectApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
