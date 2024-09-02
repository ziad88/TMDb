//
//  UIView+TapGesture.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

extension UIView {
    fileprivate typealias Action = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    
    @discardableResult
    func createCustomHeaderBar(title: String, size: CGFloat = 32, isMultiLine: Bool = false)->TabBarHeaderViewController{
        let navigationBar =  Bundle.main.loadNibNamed("TabBarHeaderViewController", owner: self, options: nil)?.first as! TabBarHeaderViewController
        navigationBar.setupUI(title: title, size: size)
        navigationBar.frame = self.bounds
        self.addSubview(navigationBar)
        navigationBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return navigationBar
    }
}
extension Notification.Name {
    static let handleSelectedTab = Notification.Name("handleSelectedTab")
    static let didScrollNotification = Notification.Name("didScrollNotification")
}
