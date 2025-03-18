//
//  Coordinator.swift
//  IdealistaChallenge
//

//
//  TabBarCoordinator.swift
//  IdealistaChallenge
//

import UIKit
import SwiftUI

enum NavigationRoute {
    case propertyDetail(RealEstate)
    case propertyDetailSwiftUI
}

protocol Coordinator: AnyObject {
    func start()
    func navigate(to route: NavigationRoute)
}

class TabBarCoordinator: Coordinator {
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    private let dicontainer: AppDependencyContainer
    
    private var listCoordinator: ListCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    private let uiUserInterfaceIdiom: UIUserInterfaceIdiom
    
    init(windowScene: UIWindowScene, dicontainer: AppDependencyContainer) {
        
        self.window = UIWindow(windowScene: windowScene)
        self.uiUserInterfaceIdiom = windowScene.traitCollection.userInterfaceIdiom
        
        self.tabBarController = UITabBarController()
        self.dicontainer = dicontainer
        
        setupWindow()
        setupTabBarController()
    }
    
    private func setupWindow() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setupTabBarController() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }

    private func setupIPadInterface() {
        // Configuración específica para iPad usando un SplitViewController
    }
    
    func start() {
        
        let listNavigationController = BaseNavigationController()
        let favoritesNavigationController = BaseNavigationController()
        
        listCoordinator = ListCoordinator(navigationController: listNavigationController, dicontainer: dicontainer, idiom: uiUserInterfaceIdiom)
        favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController, dicontainer: dicontainer, idiom: uiUserInterfaceIdiom)
        
        listCoordinator?.start()
        favoritesCoordinator?.start()
        
        listNavigationController.tabBarItem = UITabBarItem(
            title: LocalizationKeys.real_estate.localized,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: LocalizationKeys.favorites.localized,
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        tabBarController.viewControllers = [listNavigationController, favoritesNavigationController]
        tabBarController.selectedIndex = 0
    }
    
    func navigate(to route: NavigationRoute) {
        // delegates navigation to child coordinators
    }
}
