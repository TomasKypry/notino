//
//  ProductsViewController.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

// NOTE: Paging should be implemented, but api response doesn't include paging info

class ProductsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = viewModel.itemSpacing
        layout.minimumInteritemSpacing = viewModel.itemSpacing
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.contentInset = .allSides(viewModel.itemSpacing)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    let viewModel: ProductsViewModel

    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupLayout()
        loadProducts()
    }

    private func setupNavigationBar() {
        title = "Notino"
    }

    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.pinSidesToContainer()
    }

    private func loadProducts() {
        viewModel.fetchProducts()
        viewModel.onReloadNeeded = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueCell(for: indexPath)
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.setup(with: cellViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let insets = collectionView.contentInset.horizontal
        let itemSpacing = layout.minimumInteritemSpacing * CGFloat(viewModel.numberOfItemsPerRow - 1)
        let padding = insets + itemSpacing
        let collectionWidth = collectionView.bounds.width
        let usableSpaceWidth = collectionWidth - padding

        let cellWidth = usableSpaceWidth / CGFloat(viewModel.numberOfItemsPerRow)
        let cellHeight = cellWidth * 1.8

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
