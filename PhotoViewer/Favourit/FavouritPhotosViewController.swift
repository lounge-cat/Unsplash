//
//  ViewController.swift
//  PhotoViewer
//
//  Created by  admin on 4.11.22.
//

import UIKit

private enum Constants {
    static let heightForRow: CGFloat = 100
}

class FavouritPhotosViewController: UIViewController {

    private var viewModel: FavouritPhotosViewModelType?
    private var tableView = UITableView()
    
    init() {
        viewModel = FavouritPhotosViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Favourits"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavouritPhotoCell.self, forCellReuseIdentifier: FavouritPhotoCell.id)
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: Notification.Name(rawValue: "updateTable"), object: nil)
    }
    
    @objc private func updateTableView() {
        viewModel?.updateItemsArray()
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "updateTable"), object: nil)
    }
}

extension FavouritPhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritPhotoCell.id, for: indexPath) as? FavouritPhotoCell
        else { return UITableViewCell() }
        
        cell.cellViewModel = viewModel?.getCellViewModel(indexPath: indexPath)
        return cell
    }
}

extension FavouritPhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let showPhotoViewModel = viewModel?.getShowViewModel(indexPath: indexPath) else { return }
        
        navigationController?.pushViewController(ShowPhotoViewController(viewModel: showPhotoViewModel), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel?.deleteItem(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
