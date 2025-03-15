//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 14/3/25.
//

import UIKit
import SwiftUI

class ListCoordinator: Coordinator {
    
    private let navigationController: BaseNavigationController
    private let dicontainer: AppDependencyContainer
    
    init(navigationController: BaseNavigationController, dicontainer: AppDependencyContainer) {
        
        self.navigationController = navigationController
        self.dicontainer = dicontainer
        
        //setupNavigationController()
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
        //navigationRealEstateModule(route: route)
        
        switch route {
            
        case .propertyDetail(_):
            let view = UIViewController()
            navigationController.pushViewController(view, animated: true)
            
        case .propertyDetailSwiftUI:
            print("sssssss")
            let detailView = dicontainer.realEstateDetailFactory.makeModule(coordinator: self)
            let hostingController = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    }
}

extension ListCoordinator {
    
    func navigationRealEstateModule(route: NavigationRoute) {
        
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
