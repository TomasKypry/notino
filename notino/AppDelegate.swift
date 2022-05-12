//
//  AppDelegate.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootController()
        return true
    }

    private func setupRootController() {
        let viewModel = ProductsViewModel(apiClient: .shared)
        let productsViewController = ProductsViewController(viewModel: viewModel)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = productsViewController
        window?.makeKeyAndVisible()
    }
}

