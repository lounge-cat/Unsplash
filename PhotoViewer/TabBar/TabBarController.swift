//
//  TabBarController.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var viewModel: TabBarViewModelType?
    
    init() {
        viewModel = TabBarViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        setViewControllers(viewModel?.getViewControllers(), animated: true)
    }
}
