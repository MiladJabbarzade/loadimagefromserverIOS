//
//  ImageFullScreenViewController.swift
//  ImageFetcher
//
//  Created by meelad jabbarzade on today.
//  Copyright © 2019 meelad jabbarzade. All rights reserved.
//

import UIKit

class ImageFullScreenViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.color = .black
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFit
        return iw
    }()
    
    let labelName: UILabel = {
        let lb = UILabel()
        
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func set(url: URL?, label : String?) {
        labelName.text = label
        if url == nil  {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            load(url: url)
        }
    }
    
    func load(url: URL!) {
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }

    
    private func setupView() {
        view.backgroundColor = .white
        labelName.textColor = UIColor.black
        labelName.numberOfLines = 0
        
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(labelName)
        labelName.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


    
