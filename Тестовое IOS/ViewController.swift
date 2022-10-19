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
        setupTableView()
    }
    
    private func fetchTeams() {
        presenter.fetchTeams {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: RandomImageCellView.reuseIdentifier, for: indexPath) as! RandomImageCellView
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamCellView.reuseIdentifier, for: indexPath) as! TeamCellView
        cell.configure(with: presenter, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.reuseIdentifier) as? TableViewHeaderView {
                header.collectionView.delegate = self
                header.collectionView.dataSource = self
                header.collectionView.reloadData()
                return header
            }
        }
        return UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
       return 0
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? DivisionNameCell else {return}
            if let index = presenter.teams.firstIndex(where: {$0.team.division.rawValue == cell.divisionLabel.text}) {
                let indexPath = IndexPath(row: index, section: 1)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}


