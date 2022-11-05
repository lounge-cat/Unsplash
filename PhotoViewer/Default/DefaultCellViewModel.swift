//
//  DefaultCellViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

protocol DefaultCellViewModelType {
    var image: UIImage? { get set }
}

class DefaultCellViewModel {
    
    var image: UIImage?
    
    init(image: UIImage? = nil) {
        self.image = image
    }
}

extension DefaultCellViewModel: DefaultCellViewModelType {}
