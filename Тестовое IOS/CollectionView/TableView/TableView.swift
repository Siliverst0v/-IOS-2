//
//  TableView.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation
import UIKit

final class TableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        contentInset = .zero
        allowsSelection = true
        allowsMultipleSelection = false
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
        isScrollEnabled = true
        rowHeight = 100
        
        register(TableViewTeamCell.self, forCellReuseIdentifier: TableViewTeamCell.reuseIdentifier)
        register(RandomImageCell.self, forCellReuseIdentifier: RandomImageCell.reuseIdentifier)
        register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderView.reuseIdentifier)
    }
}
