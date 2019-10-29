//
//  Partials.swift
//  boilerplate
//
//  Created by Ivan Abundis on 28/10/19.
//  Copyright © 2019 Nerdter. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol Navigation{}


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SlideMenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white : UIColor.darkGray
            nameLabel.textColor = isHighlighted ? UIColor.black : UIColor.white
            iconImageView.tintColor = isHighlighted ? UIColor.darkGray : UIColor.white
        }
    }
    
    var setting: MenuOption? {
        didSet {
            nameLabel.text = setting?.name
            nameLabel.textColor = .white
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage.ionicon(with: imageName, textColor: .white, size: .init(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.white
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        
        
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}






