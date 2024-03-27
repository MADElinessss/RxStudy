//
//  SceneDelegate.swift
//  RxStudy
//
//  Created by Madeline on 3/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.unselectedItemTintColor = .darkGray

        
        let vc1 = BasicTableViewController()
        let vc2 = BasicPickerViewController()
        let vc3 = NumberViewController()

        vc1.tabBarItem = UITabBarItem(title: "TableView", image: UIImage(systemName: "list.clipboard"), selectedImage: UIImage(systemName: "list.clipboard"))
        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        vc1.tabBarItem.tag = 0
        
        vc2.tabBarItem = UITabBarItem(title: "Picker", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
        vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        vc2.tabBarItem.tag = 1
        
        vc3.tabBarItem = UITabBarItem(title: "Number", image: UIImage(systemName: "number.circle"), selectedImage: UIImage(systemName: "number.circle"))
        vc3.tabBarItem.tag = 2
        
        // tabBarController.viewControllers = [vc1, vc2, vc3, vc4].map { UINavigationController(rootViewController: $0) }
        tabBarController.viewControllers = [vc1, vc2, vc3].map { UINavigationController(rootViewController: $0) }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
//        BasicViewController
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

