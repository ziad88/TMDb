//
//  TabBarHeaderViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import UIKit

class TabBarHeaderViewController: UIView {

    // MARK: - Outlets
    @IBOutlet weak var lblHeader: UILabel!
    
    func setupUI(title:String, size: CGFloat) {
        lblHeader.text = title
        lblHeader.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lblHeader.textColor = .black
        lblHeader.numberOfLines = 0
    }
}
