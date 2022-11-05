//
//  FavouritPhotoCell.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

class FavouritPhotoCell: UITableViewCell {
    
    static let id = "FavouritPhotoCell"
    
    var cellViewModel: FavouritPhotoCellViewModelType? {
        willSet {
            guard let newImage = newValue?.image,
                  let text = newValue?.text
            else { return }
            
            image.image = newImage
            label.text = "author: \n\(text)"
        }
    }
}
