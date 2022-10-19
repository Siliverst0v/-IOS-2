//
//  TableViewHeaderView.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 15.10.2022.
//

import Foundation
import UIKit

final class TableViewHeaderView: UITableViewHeaderFooterView {
    
    static var reuseIdentifier: String { "\(Self.self)" }
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 170, height: 30)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        setupCollection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.tag = 2
        collectionView.register(DivisionNameCell.self, forCellWithReuseIdentifier: DivisionNameCell.reuseIdentifier)
    }

    private func configureUI() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forSection section: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
        collectionView.reloadData()
    }
}
