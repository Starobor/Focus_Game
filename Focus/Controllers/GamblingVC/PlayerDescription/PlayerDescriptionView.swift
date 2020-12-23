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
    
    @IBOutlet weak var hName: UILabel!
    @IBOutlet weak var hSpeed: UILabel!
    @IBOutlet weak var hWeight: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pExp: UILabel!
    @IBOutlet weak var hAge: UILabel!
    @IBOutlet weak var pWeight: UILabel!
    @IBOutlet weak var pAge: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
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
        descriptionTextView.text = data?.description
        if let param = data?.vehicleParametrs.first(where: {$0.name == "Name"})?.value {
            hName.text = param
        }
        if let param = data?.vehicleParametrs.first(where: {$0.name == "Age"})?.value {
            hAge.text = "Вік: \(param)"
        }
        if let param = data?.vehicleParametrs.first(where: {$0.name == "Weight"})?.value {
            hWeight.text = "Вага: \(param)"
        }
        if let param = data?.vehicleParametrs.first(where: {$0.name == "Speed"})?.value {
            hSpeed.text = "Швидкість: \(param)"
        }
        if let param = data?.riderParametrs.first(where: {$0.name == "Name"})?.value {
            pName.text = param
        }
        if let param = data?.riderParametrs.first(where: {$0.name == "Age"})?.value {
            pAge.text = "Вік: \(param)"
        }
        if let param = data?.riderParametrs.first(where: {$0.name == "Weight"})?.value {
            pWeight.text = "Вага: \(param)"
        }
        if let param = data?.riderParametrs.first(where: {$0.name == "Experience"})?.value {
            pExp.text = "Досвід: \(param)"
        }
    }
    
}
