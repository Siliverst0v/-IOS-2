//
//  ImageViewCell.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 15.10.2022.
//

import Foundation
import UIKit

final class ImageViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
        
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}

extension ImageViewCell {
    func configure(with presenter: PresenterProtocol, for indexPath: IndexPath) {
        let imageName = presenter.getImage(for: indexPath)
        imageView.image = UIImage(named: imageName)
    }
}
