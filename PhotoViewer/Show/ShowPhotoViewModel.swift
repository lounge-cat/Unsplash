//
//  ShowPhotoViewModel.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

private enum Constants {
    static let font: UIFont = .systemFont(ofSize: 20)
}

protocol ShowPhotoViewModelType {
    func getImageViewSize(frame: CGRect) -> CGSize
    func setupImageView(imageView: UIImageView)
    func setupStackView(stackView: UIStackView)
    func setupButton(button: UIButton)
}

class ShowPhotoViewModel {
    
    var photo: Photo
    let networkService = NetworkService()
    let photoService = PhotoService()
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    private func getImage() -> UIImage? {
        guard let string = self.photo.urls.regular,
              let data = networkService.imageData(urlString: string)
        else { return nil }
        return UIImage(data: data)
    }
    
    private func createLabel(text: String?) -> UILabel? {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        guard let text = text else { return nil }
        label.text = text
        label.font = Constants.font
        return label
    }
    
    private func getItemParameters() -> [String] {
        guard let user = photo.user.name,
              let location = photo.user.location
        else { return [] }
        return [user, location]
    }
    
    @objc private func buttonAction() {
        if let index = photoService.findPhotoInFavourits(photo: photo) {
            photoService.deletePhotoFromFavourits(index: index)
        } else {
            photoService.savePhotoToFavourits(photo: photo)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "updateTable"), object: nil)
    }
}

extension ShowPhotoViewModel: ShowPhotoViewModelType {
    
    func getImageViewSize(frame: CGRect) -> CGSize {
        let aspect = CGFloat(photo.height) / CGFloat(photo.width)
        return CGSize(width: frame.width, height: frame.width * aspect)
    }
    
    func setupImageView(imageView: UIImageView) {
        imageView.image = getImage()
    }
    
    func setupStackView(stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        getItemParameters().compactMap { createLabel(text: $0) }
            .forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupButton(button: UIButton) {
        button.setTitle("✭", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(buttonAction), for: .allEvents)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemFill
    }
}
