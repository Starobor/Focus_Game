//
//  DialogView.swift
//  Focus
//
//  Created by Igor Starobor on 11.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

class DialogView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var speakerImageContainer: UIView!
    @IBOutlet weak var textContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(DialogView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        speakerImageContainer.layer.borderColor = UIColor.black.cgColor
        speakerImageContainer.layer.borderWidth = 2
        textContainerView.layer.borderColor = UIColor.black.cgColor
        textContainerView.layer.borderWidth = 2
        
    }
    
}
