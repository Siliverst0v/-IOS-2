//
//  CollectionViewCell.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 14.10.2022.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                divisionLabel.layer.backgroundColor = UIColor.magenta.withAlphaComponent(0.3).cgColor
            } else {
                divisionLabel.layer.backgroundColor = UIColor.white.cgColor
            }
        }
    }
    
    private var divisions: [String] = []
    
    let divisionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
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
        addSubview(divisionLabel)
        
        NSLayoutConstraint.activate([
            
            divisionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            divisionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            divisionLabel.topAnchor.constraint(equalTo: topAnchor),
            divisionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}

extension CollectionViewCell {
    func configure(with presenter: PresenterProtocol, for indexPath: IndexPath) {
        let divisionName = presenter.getDivision(for: indexPath)
        divisionLabel.text = divisionName
    }
}
