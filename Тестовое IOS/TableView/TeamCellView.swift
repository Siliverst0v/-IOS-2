//
//  TableViewCell.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation
import UIKit

final class TeamCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "camera")?.withTintColor(.lightGray)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let conferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let divisionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addSubview(image)
        addSubview(titleLabel)
        addSubview(cityLabel)
        addSubview(conferenceLabel)
        addSubview(divisionLabel)
        
        NSLayoutConstraint.activate([
            
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.widthAnchor.constraint(equalTo: heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            cityLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            conferenceLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            conferenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            conferenceLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            
            divisionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            divisionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            divisionLabel.topAnchor.constraint(equalTo: conferenceLabel.bottomAnchor, constant: 4)
            
        ])
    }
}

extension TeamCellView {
    func configure(with presenter: PresenterProtocol, for indexPath: IndexPath) {
        let team = presenter.getTeam(for: indexPath)
        titleLabel.text = team.team.name
        cityLabel.text = team.team.location
        conferenceLabel.text = team.team.conference.rawValue
        divisionLabel.text = team.team.division.rawValue
        
        NetworkManager.shared.loadImage(url: URL(string: team.team.image)) { image in
            self.image.image = image
        }
    }
    
    private func saveImageToCache(data: Data, url: URL) {
        if let image = UIImage(data: data) {
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cacheResponse.data)
        }
        return nil
    }
}

class ImageCache {
    
    private init() {}
    
    static let shared = NSCache<NSString, UIImage>()
}

class StructWrapper<T>: NSObject {
    
    let value: T
    
    init(_ _struct: T) {
        self.value = _struct
    }
}
