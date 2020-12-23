//
//  GamblingContentView.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit
import SnapKit

protocol GamblingContentDelegate: class {
    func didPressedBackButton()
    func didPressedSelectButton(atIndex: Int)
}

class GamblingContentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    var players: [BaseGamblingPlayer]?
    var map: BaseGamblingMap?
    
    var selectedPlayerIndex: Int?
    
    weak var delegate: GamblingContentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(GamblingContentView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(className: PlayerDescriptionCVC.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
    }
    
    func prepare() {
        setCurrentSelected(index: 0)
    }
    
    @IBAction func didPressedBackButton(_ sender: Any) {
        delegate?.didPressedBackButton()
    }
    
    @IBAction func didPressedSelectButton(_ sender: Any) {
        if let index = selectedPlayerIndex {
            delegate?.didPressedSelectButton(atIndex: index)
        }
    }
    
    func setCurrentSelected(index: Int) {
        selectedPlayerIndex = index
      //  playersCountLabel.text = "\(index + 1) / \(players?.count ?? 0)"
    }
}

extension GamblingContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerDescriptionCVC", for: indexPath) as! PlayerDescriptionCVC
        cell.data = players?[indexPath.row]
        cell.prepare()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let indexPath = collectionView.indexPathForItem(at: center) {
            setCurrentSelected(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

