//
//  BaseTabBarController.swift
//  banquemisr.challenge05
//
//  Created by mac on 27/08/2024.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var myViewControllers : [UIViewController] = []
    var customTabBar : TabBar!
    var btnSelectedTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        self.viewControllers = myViewControllers
        setupNewCustomTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAsNavigationRoot()
    }
    
    private func setAsNavigationRoot(){
        navigationController?.setViewControllers([self], animated: true)
    }
    
    private func setupViewControllers(){
        myViewControllers = [NowPlayingMoviesViewController(),
                             PopularMoviesViewController(),
                             UpcomingMoviesViewController()]
    }
    
    
    private func setupNewCustomTabBar(){
        var barHeight: CGFloat
        if UIScreen.main.bounds.size.height <= 667 {
            barHeight = 70
        } else {
            barHeight = 90
        }
        let nibName = "BaseTabBar"
        customTabBar = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? TabBar
        customTabBar.btnSelectedTag = btnSelectedTag
        customTabBar.delegate = self
        customTabBar.setupUIView()
        self.view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.heightAnchor.constraint(equalToConstant: barHeight),
            customTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 0),
            customTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            customTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
    
}
                             
extension BaseTabBarController : BaseTabBarDelegate{
    func selectTab(tab: Int) {
        self.selectedViewController = myViewControllers[tab]
    }
}
