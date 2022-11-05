//
//  TabBarViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import UIKit

protocol TabBarViewModelType {
    func getViewControllers() -> [UIViewController]
}

class TabBarViewModel {}

extension TabBarViewModel: TabBarViewModelType {
    
    func getViewControllers() -> [UIViewController] {
        let viewControllers = [UINavigationController(rootViewController: DefaultViewController()), UINavigationController(rootViewController: FavouritPhotosViewController())]
        viewControllers[0].tabBarItem.title = "start"
        viewControllers[1].tabBarItem.title = "favourits"
        return viewControllers
    }
}
