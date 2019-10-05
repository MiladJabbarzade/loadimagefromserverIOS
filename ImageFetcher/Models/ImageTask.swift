//
//  ImageTask.swift
//  ImageFetcher
//
//  Created by Alex Akrimpai on 10/02/2018.
//  Copyright © 2018 CodingWarrior. All rights reserved.
//

import UIKit

class ImageTask {
    
    let position: Int
    let thumbUrl: URL
    let mainUrl : URL
    let name : String
    let session: URLSession
    let delegate: ImageTaskDownloadedDelegate
    
    var image: UIImage?
    

    
    private var task: URLSessionDownloadTask?
    private var resumeData: Data?
    
    
    
    private var isDownloading = false
    private var isFinishedDownloading = false

    init(name : String, position: Int, thumburl: URL, mainurl : URL, session: URLSession, delegate: ImageTaskDownloadedDelegate) {
        self.name = name
        self.position = position
        self.thumbUrl = thumburl
        self.mainUrl = mainurl
        self.session = session
        self.delegate = delegate
    }
    
    func resume() {
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            } else {
                task = session.downloadTask(with: thumbUrl, completionHandler: downloadTaskCompletionHandler)
            }
            
            task?.resume()
        }
    }
    
    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })
            
            self.isDownloading = false
        }
    }
    
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("Error downloading: ", error)
            return
        }
        
        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async {
            self.image = image
            self.delegate.imageDownloaded(position: self.position)
        }
        
        self.isFinishedDownloading = true
    }
}
