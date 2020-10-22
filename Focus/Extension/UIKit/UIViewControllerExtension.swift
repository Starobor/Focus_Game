//
//  UIViewControllerExtension.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setAsChildOf<T:UIView>(view: UIView, _ type: T.Type) -> T? {
        if !view.subviews.contains(where: {$0 is T}) {
            view.subviews.forEach({$0.removeFromSuperview()})
            let childView = T()
            view.addSubview(childView)
            childView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(0)
            }
            return childView
        }
        return nil
    }
    
    func setAsChildOf<T:UIView>(view: UIView, _ type: T.Type) {
        if !view.subviews.contains(where: {$0 is T}) {
            view.subviews.forEach({$0.removeFromSuperview()})
            let childView = T()
            view.addSubview(childView)
            childView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(0)
            }
        }
    }
    
    
}
