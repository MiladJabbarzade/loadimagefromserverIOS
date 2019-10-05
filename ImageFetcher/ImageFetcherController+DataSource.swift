//
//  ImageFetcherController+DataSource.swift
//  ImageFetcher
//
//  Created by Alex Akrimpai on 09/02/2018.
//  Copyright © 2018 CodingWarrior. All rights reserved.
//

import UIKit

extension ImageFetcherController {    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalImages
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.pause()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageFetcherCell
        
        let image = imageTasks[indexPath.row]?.image
        let label = imageTasks[indexPath.row]?.name
        
        cell.set(image: image, label: label)

        return cell
    
    }
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageFullScreenViewController = ImageFullScreenViewController()
    
        let url = imageTasks[indexPath.row]?.mainUrl
        let label = (collectionView.cellForItem(at: indexPath) as! ImageFetcherCell).labelName.text
        
        imageFullScreenViewController.set(url: url, label: label) 
        selectedImage = (indexPath.row, imageFullScreenViewController)
        
        navigationController?.pushViewController(imageFullScreenViewController, animated: true)
    }
}
