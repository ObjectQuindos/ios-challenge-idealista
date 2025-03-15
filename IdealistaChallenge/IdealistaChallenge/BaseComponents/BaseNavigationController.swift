//
//  Untitled.swift
//  IdealistaChallenge
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
        coloredAppearance.shadowColor = nil
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.hidesSearchBarWhenScrolling = false
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    private func configure(shadow navigationBar: UINavigationBar, isHidden: Bool) {
        navigationBar.shadowImage = UIImage()
        navigationBar.layer.borderColor = UIColor.clear.cgColor
        navigationBar.layer.borderWidth = 0
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationBar.layer.shadowRadius = 4
        navigationBar.layer.shadowOpacity = isHidden ? 0 : 1
        navigationBar.layer.masksToBounds = false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return visibleViewController?.supportedInterfaceOrientations ?? [.all]
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return visibleViewController?.preferredInterfaceOrientationForPresentation ?? .unknown
    }
}
