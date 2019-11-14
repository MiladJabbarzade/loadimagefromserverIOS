//
//  ImageFetcherCell.swift
//  ImageFetcher
//
//  Created by meelad jabbarzade on today.
//  Copyright © 2019 meelad jabbarzade. All rights reserved.
//

import UIKit

class ImageFetcherCell: UICollectionViewCell {
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        return ai
    }()
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        
        return iw
    }()
    
    let labelName: UILabel = {
        let lb = UILabel()
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func set(image: UIImage?, label : String?) {
        imageView.image = image
        labelName.text = label
        if image == nil  {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor.rgb(red: 216, green: 216, blue: 216)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        clipsToBounds = true
        
        labelName.font = UIFont(name: "System", size: 4)
        labelName.numberOfLines = 0
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(labelName)
        labelName.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 60, paddingLeft: 20, paddingBottom: 4, paddingRight: 20, width: 0, height: 0)
        
        addSubview(activityIndicator)
        activityIndicator.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
