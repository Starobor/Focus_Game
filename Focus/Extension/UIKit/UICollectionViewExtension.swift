//
//  UICollectionViewExtension.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(className: String) {
        self.register(UINib(nibName: className,  bundle: nil),
                      forCellWithReuseIdentifier: className)
    }
}
