//
//  DefaultCell.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import UIKit

class DefaultCell: UICollectionViewCell {
    
    static let id = "DefaultCell"
    private var imageView = UIImageView()
    
    var cellViewModel: DefaultCellViewModelType? {
        willSet {
            guard let image = newValue?.image else { return }
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        cellViewModel = DefaultCellViewModel(image: nil)
        
        super.init(frame: frame)
        
        setupImageView()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.frame = .zero
        imageView.image = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: .zero, y: .zero, width: 115, height: 115)
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }
}
