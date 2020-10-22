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

        showPlayersTab()
    }

    @IBAction func didPressedMapButton(_ sender: Any) {
        showMapTab()
    }
    
    @IBAction func didPressedPlayersButton(_ sender: Any) {
        showPlayersTab()
    }
    
    func showMapTab() {
        if let childView = setAsChildOf(view: contentView, GamblingMapView.self) {
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
        delegate?.selected(index: atIndex)
    }
    
    func didPressedBackButton() {
        self.dismiss(animated: true)
    }
}
