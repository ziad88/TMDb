//
//  BaseTabBar.swift
//  banquemisr.challenge05
//
//  Created by mac on 27/08/2024.
//

import UIKit

class TabBar : UIView {
    weak var delegate : BaseTabBarDelegate?
    var btnSelectedTag : Int = 0
    func setupUIView(){}
    func changeSelection(index : Int){}
}

class BaseTabBar: TabBar {

    @IBOutlet var tabBarLabels: [UILabel]!
    @IBOutlet var tabBarStacks: [UIStackView]!
    @IBOutlet var tabBarImages: [UIImageView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var labels = [
        "Now Playing",
        "Popular",
        "Upcoming"]
    var selectedTab = 0
    
    
    override func setupUIView(){
        setupStackViews()
        setupLabels()
        setupImages()
        updateTabBar(tab: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedTab(_:)), name: .handleSelectedTab, object: nil)
    }
    
    private func setupStackViews(){
        for stackView in tabBarStacks{
            stackView.addTapGestureRecognizer {
                self.updateTabBar(tab: stackView.tag)
            }
        }
    }
    
    private func setupImages(){
        for image in tabBarImages {
            image.tintColor = .gray
        }
    }
    
    private func setupLabels(){
        for i in 0...tabBarLabels.count - 1{
            tabBarLabels[i].text = labels[i]
            tabBarLabels[i].font = UIFont.systemFont(ofSize: 12, weight: .bold)
            tabBarLabels[i].textColor = .gray
        }
    }
    
    private func updateTabBar(tab: Int){
        delegate?.selectTab(tab: tab)
        updateLabelAndImage(color: .gray)
        selectedTab = tab
        updateLabelAndImage(color: .black)
    }
    
    private func updateLabelAndImage(color: UIColor){
        tabBarLabels[selectedTab].textColor = color
        tabBarImages[selectedTab].tintColor = color
    }
    
    @objc private func handleSelectedTab(_ notification: Notification) {
        guard let tab = notification.userInfo?["tab"] as? Int else {return}
        updateTabBar(tab: tab)
    }

    
}
