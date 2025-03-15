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
    
    init(window: UIWindow, dicontainer: AppDependencyContainer) {
        self.window = window
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
    
    func start() {
        
        let listNavigationController = BaseNavigationController()
        let favoritesNavigationController = BaseNavigationController()
        
        listCoordinator = ListCoordinator(navigationController: listNavigationController, dicontainer: dicontainer)
        favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController, dicontainer: dicontainer)
        
        listCoordinator?.start()
        favoritesCoordinator?.start()
        
        listNavigationController.tabBarItem = UITabBarItem(
            title: "Real Estate",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: "Favoritos",
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




/*import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    func start()
    func navigate(to route: NavigationRoute)
}

enum NavigationRoute {
    case propertyDetail(RealEstate)
    case propertyDetailSwiftUI
}

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let dicontainer: AppDependencyContainer
    
    init(window: UIWindow, dicontainer: AppDependencyContainer) {
        self.window = window
        self.navigationController = UINavigationController()
        self.dicontainer = dicontainer
        
        setupWindow()
        setupNavigationController()
    }
    
    private func setupWindow() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func start() {
        let realEstateViewController = dicontainer.realEstateFactory.makeModule(coordinator: self)
        navigationController.viewControllers = [realEstateViewController]
    }
    
    func navigate(to route: NavigationRoute) {
        
        switch route {
            
        case .propertyDetail(_):
            let view = UIViewController()
            navigationController.pushViewController(view, animated: true)
            
        case .propertyDetailSwiftUI:
            let detailView = dicontainer.realEstateDetailFactory.makeModule(coordinator: self)
            let hostingController = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    }
}
*/
