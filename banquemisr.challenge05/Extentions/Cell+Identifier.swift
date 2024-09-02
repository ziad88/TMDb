//
//  Cell+Identifier.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

