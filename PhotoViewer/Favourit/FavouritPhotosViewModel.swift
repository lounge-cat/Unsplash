//
//  FavouritPhotosViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation
import UIKit

protocol FavouritPhotosViewModelType: AnyObject {
    var items: [Photo] { get }
    func numberOfRowsInSection() -> Int
    func updateItemsArray()
    func getCellViewModel(indexPath: IndexPath) -> FavouritPhotoCellViewModelType?
    func getShowViewModel(indexPath: IndexPath) -> ShowPhotoViewModelType?
    func deleteItem(indexPath: IndexPath)
}

class FavouritPhotosViewModel {
    
    let photoService = PhotoService()
    let networkService = NetworkService()
    
    var items: [Photo] = []
    
    init() {
        items = photoService.favouritPhotos()
    }
    
    private func getText(indexPath: IndexPath) -> String? {
        items[indexPath.row].user.name
    }
    
    private func getImage(indexPath: IndexPath) -> UIImage? {
        guard let urlString = items[indexPath.row].urls.thumb,
              let data = networkService.imageData(urlString: urlString)
        else { return nil }
        return UIImage(data: data)
    }
}

extension FavouritPhotosViewModel: FavouritPhotosViewModelType {

    func numberOfRowsInSection() -> Int {
        items.count
    }
    
    func updateItemsArray() {
        items = photoService.favouritPhotos()
    }
    
    func getShowViewModel(indexPath: IndexPath) -> ShowPhotoViewModelType? {
        ShowPhotoViewModel(photo: items[indexPath.row])
    }
    
    func getCellViewModel(indexPath: IndexPath) -> FavouritPhotoCellViewModelType? {
        let image = getImage(indexPath: indexPath)
        let text = getText(indexPath: indexPath)
        return FavouritPhotoCellViewModel(image: image, text: text)
    }
    
    func deleteItem(indexPath: IndexPath) {
        photoService.deletePhotoFromFavourits(index: indexPath.row)
        updateItemsArray()
    }
}
