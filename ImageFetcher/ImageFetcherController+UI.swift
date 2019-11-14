//
//  ImageFetcherController+UI.swift
//  ImageFetcher
//
//  Created by meelad jabbarzade on today.
//  Copyright © 2019 meelad jabbarzade. All rights reserved.
//

import UIKit

extension ImageFetcherController {
    internal func setupView() {
        let navBarHeight = self.navigationController!.navigationBar.intrinsicContentSize.height + UIApplication.shared.statusBarFrame.height
        screenDimensions = CGSize(width: view.bounds.width, height: view.bounds.height - navBarHeight)
        
        guard let cw = collectionView else { return }
        
        cw.register(ImageFetcherCell.self, forCellWithReuseIdentifier: cellId)
        cw.backgroundColor = .white
        navigationItem.title = "Images"
        
        cw.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: cw.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: cw.centerYAnchor, constant: -50).isActive = true
    }
    
}
