//
//  Extensions.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 19.10.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
