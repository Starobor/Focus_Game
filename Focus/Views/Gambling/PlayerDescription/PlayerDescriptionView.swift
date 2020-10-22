//
//  PlayerDescriptionView.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

class PlayerDescriptionView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerDesctiptionTextView: UITextView!
    @IBOutlet weak var titleRiderLabel: UILabel!
    @IBOutlet weak var paramsRiderStackView: UIStackView!
    @IBOutlet weak var titleVehicleLabel: UILabel!
    @IBOutlet weak var paramsVehicleStackView: UIStackView!
    
    var data: BaseGamblingPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(PlayerDescriptionView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func prepareViews() {
        paramsRiderStackView.subviews.forEach({$0.removeFromSuperview()})
        paramsVehicleStackView.subviews.forEach({$0.removeFromSuperview()})
        self.playerDesctiptionTextView.text = data?.description
        
        if let params = data?.riderParametrs {
            for param in params {
                let label = UILabel()
                label.textColor = .black
                label.text = "\(param.name): \(param.value)"
                label.frame.size.height = 24
                paramsRiderStackView.addArrangedSubview(label)
            }
        }
        
        if let params = data?.vehicleParametrs {
            for param in params {
                let label = UILabel()
                label.text =  "\(param.name): \(param.value)"
                label.textColor = .black
                paramsVehicleStackView.addArrangedSubview(label)
                
            }
        }
    }
    
}
