//
//  DefaultViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import CoreGraphics
import UIKit

protocol DefaultViewModelType {
    func getCollectionViewLayout() -> UICollectionViewFlowLayout
    func getNumberOfItems() -> Int
}

class DefaultViewModel {}

extension DefaultViewModel: DefaultViewModelType {
    
    func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let itemWidth = UIScreen.main.bounds.width / 4
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        return layout
    }
    
    func getNumberOfItems() -> Int {
        return 10
    }
        
}
