//
//  ImageFetcherController.swift
//  ImageFetcher
//
//  Created by Alex Akrimpai on 09/02/2018.
//  Copyright © 2018 CodingWarrior. All rights reserved.
//

import UIKit


class ImageFetcherController: UICollectionViewController, ImageTaskDownloadedDelegate {
    var imageTasks = [Int: ImageTask]()
    
    let localServerAddress = "http://192.168.0.40:3000"

    let ServerAddress = "https://my-json-server.typicode.com/amosavian/restdemo/"
    
    
    
    var picsumPosToImageIdMapper = [Int: Int]()
    
    var address = ""
    
    var totalImages = 0
    var selectedImage: (row: Int, imageView: ImageFullScreenViewController)?
    
    let cellId = "cellId"
    
    var screenDimensions: CGSize?
    var urlAandB = [Int: [String]]()
    var labelName = [Int : String]()

    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.color = .black
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        return ai
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
//        setupUsingLocalServer()
        setupUsingPicsumServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedImage = nil
    }
    
    func imageDownloaded(position: Int) {
        self.collectionView?.reloadItems(at: [IndexPath(row: position, section: 0)])
    }
    
    private func setupUsingPicsumServer() {        
        address = ServerAddress
        enum range : String {
            case one = "1-10"
            case two = "11-20"
            case three = "21-30"
            case four = "31-40"
            case five = "41-50"
            
        }
        
        guard let url = URL(string: "\(address)" + range.one.rawValue) else { return }
        guard let url2 = URL(string: "\(address)" + range.two.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error getting the total count: ", error)
                return
            }
            
            
            guard let data = data else { return }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [[String: Any]] {
                let start = 0
                let count = responseJSON.count
                print(responseJSON)
                var pos = 0
                for i in start ..< count {
                    
                    guard let id = responseJSON[i]["id"] as? Int else { return }
                    guard let title = responseJSON[i]["title"] as? String  else { return }
                    guard let mainUrl = responseJSON[i]["url"] as? String  else { return }
                    guard let thumbnailUrl = responseJSON[i]["thumbnailUrl"] as? String  else { return }
                    self.picsumPosToImageIdMapper[pos] = id
                    let AandB = [thumbnailUrl, mainUrl]
                    self.urlAandB[i] = AandB
                    self.labelName[i] = title
                    pos += 1
                }
                
                self.finishedFetchingImagesInfo(totalImages: count - start)
            }
        }.resume()
    }
    
    private func setupUsingLocalServer() {
        address = localServerAddress
        
        guard let url = URL(string: "\(address)/total") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error getting the total count: ", error)
                self.displayInvalidServerAlert()
                return
            }
            
            guard let data = data else { return }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                guard let totalImages = responseJSON["totalImages"] as? Int else { return }
                self.finishedFetchingImagesInfo(totalImages: totalImages)
            }
        }.resume()
    }
    
    private func finishedFetchingImagesInfo(totalImages: Int) {
        DispatchQueue.main.async {
            self.setupImageTasks(totalImages: totalImages)
            self.totalImages = totalImages
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupImageTasks(totalImages: Int) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        for i in 0..<totalImages {
            let thumbUrl = URL(string: getImageThumbUrlFor(pos: i))!
            let mainUrl = URL(string: getImageMainUrlFor(pos: i))!
            let imageName = self.labelName[i]!
            let imageTask = ImageTask(name: imageName, position: i, thumburl: thumbUrl, mainurl: mainUrl, session: session, delegate: self)
            imageTasks[i] = imageTask
        }
    }
    
    private func displayInvalidServerAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Can't connect", message: "Can't connect to the '\(self.address)'.\nPlease make sure you have a server running at that address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    internal func getImageThumbUrlFor(pos: Int) -> String {
        let isPicsum = address.contains("amosavian")
        
        if isPicsum {
            let AaB = urlAandB[pos]
            let aA = AaB![0]
            return aA
        }
        self.displayInvalidServerAlert()
        return ""
    
}
    
    internal func getImageMainUrlFor(pos: Int) -> String {
        let isPicsum = address.contains("amosavian")
        
        if isPicsum {
            let AaB = urlAandB[pos]
            let aA = AaB![1]
            return aA
        }
        self.displayInvalidServerAlert()
        return ""
    }
}

