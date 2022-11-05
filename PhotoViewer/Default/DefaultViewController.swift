//
//  DefaultViewController.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import UIKit

class DefaultViewController: UIViewController {
    
    private let searchController = UISearchController()
    private var collectionView: UICollectionView
    private var viewModel: DefaultViewModelType?
    
    init() {
        viewModel = DefaultViewModel()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSearchController()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Unsplash"
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.setCollectionViewLayout(viewModel?.getCollectionViewLayout() ?? UICollectionViewFlowLayout(), animated: true)
        collectionView.register(DefaultCell.self, forCellWithReuseIdentifier: DefaultCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DefaultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfItems() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCell.id, for: indexPath) as? DefaultCell
        else { return UICollectionViewCell() }
        
        cell.cellViewModel = viewModel?.getCellViewModel(indexPath: indexPath)
        return cell
    }
}

extension DefaultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let showPhotoViewModel = viewModel?.getShowPhotoViewModel(indexPath: indexPath) else { return }
        navigationController?.pushViewController(ShowPhotoViewController(viewModel: showPhotoViewModel), animated: true)
    }
}

extension DefaultViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel?.getItemsFromSearch(searchText: searchBar.searchTextField.text) {
            self.collectionView.reloadData()
        }
    }
}
