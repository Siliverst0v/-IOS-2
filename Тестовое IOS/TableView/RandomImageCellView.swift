//
//  TableImageCell.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 19.10.2022.
//

import Foundation
import UIKit

final class RandomImageCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: width/1.5 , height: 100)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollection()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.tag = 1
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier)
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
