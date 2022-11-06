//
//  FavouritPhotoCell.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

private enum Constants {
    static let font: UIFont = .systemFont(ofSize: 20)
}

class FavouritPhotoCell: UITableViewCell {
    
    var cellViewModel: FavouritPhotoCellViewModelType? {
        willSet {
            image.image = newValue?.image
            label.text = "author: \n\(String(describing: newValue?.text))"
        }
    }
    
    private var label = UILabel()
    private var image = UIImageView()
    
    static let id = "FavouritPhotoCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: FavouritPhotoCell.id)
        
        setupImage()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        image.image = .none
        image.frame = .zero
        label.text = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.frame = CGRect(x: .zero, y: .zero, width: 100, height: 100)
        label.frame = CGRect(x: 120, y: .zero, width: 200, height: 100)
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.font = Constants.font
        label.numberOfLines = 0
    }
    
    private func setupImage() {
        contentView.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }
}
