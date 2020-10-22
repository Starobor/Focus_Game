//
//  UIViewExtension.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

extension UIView {
    
    static var className: String {
        return String(describing: type(of: self.init()))
    }
}
