//
//  ViewController.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation
import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var presenter: PresenterProtocol = Presenter()
    private let tableView = TableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchTeams()
        setupCollectionView()
    }
    
    private func fetchTeams() {
        presenter.fetchTeams {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    //MARK: - Table View DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return presenter.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RandomImageCell.reuseIdentifier, for: indexPath) as! RandomImageCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTeamCell.reuseIdentifier, for: indexPath) as! TableViewTeamCell
        cell.configure(with: presenter, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UITableViewHeaderFooterView()
        }
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.reuseIdentifier) as? TableViewHeaderView {
            header.collectionView.delegate = self
            header.collectionView.dataSource = self
            header.collectionView.reloadData()
            return header
        }
        return UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
       return 50
    }
    
    //MARK: - Collection View DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        let divisions = presenter.teams.compactMap{ $0.team.division.rawValue }
        return Array(Set(divisions)).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.reuseIdentifier, for: indexPath) as! ImageViewCell
            cell.configure(with: presenter, for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DivisionNameCell.reuseIdentifier, for: indexPath) as? DivisionNameCell
        cell?.configure(with: presenter, for: indexPath)
        return cell ?? DivisionNameCell()
    }
}

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
