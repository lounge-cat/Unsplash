//
//  FavouritsCellViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

protocol FavouritPhotoCellViewModelType: AnyObject {
    var image: UIImage? { get set }
    var text: String? { get set }
}

class FavouritPhotoCellViewModel {
    
    var image: UIImage?
    var text: String?
    
    init(image: UIImage?, text: String?) {
        self.image = image
        self.text = text
    }
}

extension FavouritPhotoCellViewModel: FavouritPhotoCellViewModelType {}
