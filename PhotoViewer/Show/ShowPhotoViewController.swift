//
//  ShowPhotoViewController.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import UIKit

class ShowPhotoViewController: UIViewController {
    
    private let viewModel: ShowPhotoViewModelType?
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private var stackView = UIStackView()
    private var button = UIButton(type: .system)
    
    init(viewModel: ShowPhotoViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
        imageView.frame = CGRect(origin: .zero, size: viewModel?.getImageViewSize(frame: view.bounds) ?? .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupImageView()
        setupStackView()
        setupButton()
        setupScrollView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        viewModel?.setupImageView(imageView: imageView)
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        viewModel?.setupStackView(stackView: stackView)
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }
    
    private func setupButton() {
        view.addSubview(button)
        viewModel?.setupButton(button: button)
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(button)
    }
}
