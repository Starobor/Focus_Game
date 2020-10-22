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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var mapDescription: String? {
        get {
            return descriptionTextView.text
        }
        set {
            descriptionTextView.text = newValue
        }
    }
    
    weak var delegate: GamblingMapDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        descriptionTextView.text = mapDescription
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
    
}
