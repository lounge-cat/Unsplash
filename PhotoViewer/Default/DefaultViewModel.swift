//
//  DefaultViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import CoreGraphics
import UIKit

protocol DefaultViewModelType: AnyObject {
    var items: [MyType] { get }
    func getCollectionViewLayout() -> UICollectionViewFlowLayout
    func getNumberOfItems() -> Int
    func getCellViewModel(indexPath: IndexPath) -> DefaultCellViewModelType?
    func getShowPhotoViewModel(indexPath: IndexPath) -> ShowPhotoViewModelType?
    func getItemsFromSearch(searchText: String, completion: @escaping () -> ())
    func getRandomItems(completion: @escaping () -> ())
}

class DefaultViewModel {

    private let networkService = NetworkService()
    
    var items: [MyType] = []
    
    private func getCollectionViewItemSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemsInRow = (screenWidth / 100).rounded()
        let size = screenWidth / itemsInRow
        return CGSize(width: size, height: size)
    }
}

extension DefaultViewModel: DefaultViewModelType {
    
    func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = getCollectionViewItemSize()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        return layout
    }
    
    func getNumberOfItems() -> Int {
        return items.count
    }
    
    func getItemsFromSearch(searchText: String, completion: @escaping () -> ()) {
        networkService.networkResultsFromSearch(searchText: searchText) { items in
            guard let items = items else { return }
            self.items = items
            
            completion()
        }
    }
    
    func getRandomItems(completion: @escaping () -> ()) {
        networkService.randomNetworkResults() { items in
            guard let items = items else { return }
            self.items = items
            
            completion()
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> DefaultCellViewModelType? {
        guard let string = items[indexPath.row].urls.thumb,
              let data = networkService.imageData(urlString: string)
        else { return nil }

        let image = UIImage(data: data)
        return DefaultCellViewModel(image: image)
    }
    
    func getShowPhotoViewModel(indexPath: IndexPath) -> ShowPhotoViewModelType? {
        let item = items[indexPath.row]
        return ShowPhotoViewModel(item: item)
    }
}
