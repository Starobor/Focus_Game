//
//  PlayerDescriptionCVC.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit
import SnapKit

class PlayerDescriptionCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    var plView: PlayerDescriptionView!
    
    var data: BaseGamblingPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func prepare() {
        let plView = PlayerDescriptionView()
        plView.data = data!
        containerView.addSubview(plView)
        plView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(0)
        }
        plView.prepareViews()
        self.plView = plView
    }
    
}
