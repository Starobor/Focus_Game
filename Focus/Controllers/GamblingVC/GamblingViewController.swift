//
//  GamblingViewController.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit
import SnapKit

protocol GamblingViewDelegate: class {
    func selected(index: Int)
}

class GamblingViewController: UIViewController {

    @IBOutlet weak var blurContainer: UIView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var contentView: UIView!
    
    let data: BaseGamblingDataSource
    
    weak var delegate: GamblingViewDelegate?
    
    init(data: BaseGamblingDataSource) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurContainer.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurContainer.addSubview(blurEffectView)
        
        
        mainContainer.layer.cornerRadius = 12
        mainContainer.layer.borderWidth = 3
        mainContainer.layer.borderColor = UIColor.black.cgColor
        mainContainer.backgroundColor = .appGrey
        showPlayersTab()
        
        
        mainContainer.alpha = 0
        blurContainer.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.mainContainer.alpha = 1
            self.blurContainer.alpha = 1
        }
    }

    @IBAction func didPressedMapButton(_ sender: Any) {
        showMapTab()
    }
    
    @IBAction func didPressedPlayersButton(_ sender: Any) {
        showPlayersTab()
    }
    
    func showMapTab() {
        if let childView = setAsChildOf(view: contentView, GamblingMapView.self) {
            childView.prepareView(data: data.map)
            childView.delegate = self
        }
    }
    
    func showPlayersTab() {
        if let childView = setAsChildOf(view: contentView, GamblingContentView.self) {
            childView.delegate = self
            childView.players = data.players
            childView.map = data.map
            childView.prepare()
        }
    }
    
}

extension GamblingViewController: GamblingContentDelegate, GamblingMapDelegate {
    func didPressedSelectButton(atIndex: Int) {
        let this = self
        UIView.animate(withDuration: 0.5, animations: {
            this.mainContainer.alpha = 0
            this.blurContainer.alpha = 0
        }, completion: { (_) in
            this.delegate?.selected(index: atIndex)
            this.dismiss(animated: false)
        })
       
    }
    
    func didPressedBackButton() {
        let this = self
        UIView.animate(withDuration: 0.5, animations: {
            this.mainContainer.alpha = 0
            this.blurContainer.alpha = 0
        }, completion: { (_) in
            this.dismiss(animated: false)
        })
    }
}
