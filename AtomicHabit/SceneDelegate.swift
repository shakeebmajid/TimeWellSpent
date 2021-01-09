//
//  SceneDelegate.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/1/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

//
//  SceneDelegate.swift
//
import UIKit
import SwiftUI

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // ...
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("scene delegate hit")
            guard let _ = (scene as? UIWindowScene) else { return }
            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                window?.rootViewController = UIHostingController(rootView: HabitListView())
                self.window!.makeKeyAndVisible()
            }
        }
}
