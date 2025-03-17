//
//  Untitled.swift
//  IdealistaChallenge
//

import UIKit
import SwiftUI

class FavoritesCoordinator: Coordinator {
    
    private let navigationController: BaseNavigationController
    private let dicontainer: AppDependencyContainer
    private let uiUserInterfaceIdiom: UIUserInterfaceIdiom
    
    init(navigationController: BaseNavigationController, dicontainer: AppDependencyContainer, idiom: UIUserInterfaceIdiom) {
        
        self.navigationController = navigationController
        self.dicontainer = dicontainer
        self.uiUserInterfaceIdiom = idiom
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
        
        if uiUserInterfaceIdiom == .pad {
            setupIPadInterface()
            
        } else {
            setupIPhoneInterface()
        }
    }
    
    func navigate(to route: NavigationRoute) {
        navigationRealEstateModule(route: route)
    }
    
    private func setupIPadInterface() {
        // For example: SplitViewController
    }
    
    private func setupIPhoneInterface() {
        let favoritesViewController = dicontainer.favoritesFactory.makeModule(coordinator: self, imageManager: dicontainer.imageManager)
        favoritesViewController.title = LocalizationKeys.favorites.localized
        navigationController.viewControllers = [favoritesViewController]
    }
}

extension FavoritesCoordinator {
    
    func navigationRealEstateModule(route: NavigationRoute) {
        
        switch route {
            
        case .propertyDetail(_):
            let view = UIViewController()
            navigationController.pushViewController(view, animated: true)
            
        case .propertyDetailSwiftUI:
            let detailView = dicontainer.realEstateDetailFactory.makeModule(coordinator: self, imageManager: dicontainer.imageManager)
            let hostingController = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    }
}
