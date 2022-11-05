//
//  FavouritPhotosViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

protocol FavouritPhotosViewModelType: AnyObject {
    var items: [MyType] { get }
    func numberOfRowsInSection() -> Int
    func updateItemsArray()
    func getCellViewModel(indexPath: IndexPath) -> FavouritsCellViewModelType?
}

class FavouritPhotosViewModel {
    
    var items: [MyType] = []
}

extension FavouritPhotosViewModel: FavouritPhotosViewModelType {
    
    func numberOfRowsInSection() -> Int {
        items.count
    }
    
    func updateItemsArray() {
//        items = dataManager.getFav()
    }
    
    func getCellViewModel(indexPath: IndexPath) -> FavouritsCellViewModelType? {
        let image = getImage(indexPath: indexPath)
        let text = getText(indexPath: indexPath)
        return FavouritsCellViewModel(image: image, text: text)
    }
}
