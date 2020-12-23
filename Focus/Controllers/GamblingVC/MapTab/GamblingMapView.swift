//
//  GamblingMapView.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

protocol GamblingMapDelegate: class {
    func didPressedBackButton()
}

class GamblingMapView: UIView {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    weak var delegate: GamblingMapDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(GamblingMapView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func didPressedBackButton(_ sender: Any) {
        delegate?.didPressedBackButton()
    }
    
    func prepareView(data: BaseGamblingMap) {
        distanceLabel.text = data.parametrs.first(where: {$0.name == "distance"})?.value
        weatherLabel.text = data.parametrs.first(where: {$0.name == "weather"})?.value
        stateLabel.text = data.parametrs.first(where: {$0.name == "state"})?.value
        timeLabel.text = data.parametrs.first(where: {$0.name == "time"})?.value
        descriptionTextView.text = data.description
    }
}
