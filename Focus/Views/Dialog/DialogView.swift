//
//  DialogView.swift
//  Focus
//
//  Created by Igor Starobor on 11.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit

protocol DialogViewDelegate: class {
    
}

class DialogView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var speakerImageContainer: UIView!
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    weak var delegate: DialogViewDelegate?
    
    var texts: [String]?
    var hero: Hero?
    
    var imageSpeaker: UIImage? {
        if let hero = hero {
            switch hero {
            case .cow:
                return .cowSpeakAvatar
            case .radio:
                return .radioSpeakAvatar
            }
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(text: String, hero: Hero) {
        self.texts = [text]
        self.hero = hero
        super.init(frame: .zero)
        self.commonInit()
    }
    
    init(texts: [String], hero: Hero) {
        self.texts = texts
        self.hero = hero
        super.init(frame: .zero)
        self.commonInit()
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
        prepareViews()
    }
    
    func prepareViews() {
        textLabel.layoutMargins = .zero
        textLabel.text = texts?.first
        speakerImageView.image = imageSpeaker
        updateBuutons()
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        let currentTextIndex = texts?.firstIndex(where: {$0 == textLabel.text}) ?? 0
        if currentTextIndex != 0 {
            textLabel.text = texts?[currentTextIndex - 1]
        }
        updateBuutons()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        let currentTextIndex = texts?.firstIndex(where: {$0 == textLabel.text}) ?? 0
        if currentTextIndex != (texts?.count ?? 0) - 1 {
            textLabel.text = texts?[currentTextIndex + 1]
        }
        updateBuutons()
    }
    
    func updateBuutons() {
        let currentTextIndex = texts?.firstIndex(where: {$0 == textLabel.text}) ?? 0
        leftButton.isHidden = currentTextIndex == 0
        rightButton.isHidden = currentTextIndex == (texts?.count ?? 0) - 1
    }
}
