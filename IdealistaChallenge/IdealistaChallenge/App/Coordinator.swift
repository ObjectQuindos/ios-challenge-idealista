//
//  Coordinator.swift
//  IdealistaChallenge
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func navigate(to route: NavigationRoute)
}

enum NavigationRoute {
    case propertyDetail(RealEstate)
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
            
        case .propertyDetail(let property):
            print("Navegando al detalle de la propiedad: \(property.propertyCode)")
        }
    }
}
