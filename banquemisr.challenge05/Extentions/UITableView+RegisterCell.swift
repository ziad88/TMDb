//
//  UITableView+RegisterCell.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

public extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type) {
        self.register(T.nibName, forCellReuseIdentifier: T.className)
    
    }
    func registerClass<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.className)
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return cell
    }
}

extension NSObject {
    
    static public var className: String {
        return String(describing: self)
    }
    
    static public var nibName : UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
