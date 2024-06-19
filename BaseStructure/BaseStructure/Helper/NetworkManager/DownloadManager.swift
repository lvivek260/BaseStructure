//
//  DownloadManager.swift
//  PHN Inventory
//
//  Created by PHN MAC 1 on 07/06/24.
//
import Foundation

class DownloadManager: NSObject, URLSessionDownloadDelegate {
    static let shared = DownloadManager()
    
    private var urlSession: URLSession!
    private var activeDownloads: [URL: Download] = [:]
    
    private override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    func startDownload(from url: URL, progressHandler: @escaping (Float) -> Void, completionHandler: @escaping (URL?, Error?) -> Void) {
        if activeDownloads[url] == nil {
            let download = Download(url: url, progressHandler: progressHandler, completionHandler: completionHandler)
            download.task = urlSession.downloadTask(with: url)
            download.task?.resume()
            activeDownloads[url] = download
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else { return }
        let download = activeDownloads[url]
        activeDownloads[url] = nil
        
        // Move downloaded file to desired location
        let fileManager = FileManager.default
        let destinationURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(url.lastPathComponent)
        
        do {
            // Ensure the destination directory exists
            let destinationDir = destinationURL.deletingLastPathComponent()
            if !fileManager.fileExists(atPath: destinationDir.path) {
                try fileManager.createDirectory(at: destinationDir, withIntermediateDirectories: true, attributes: nil)
            }
            
            // If file already exists at the destination, remove it
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            
            try fileManager.moveItem(at: location, to: destinationURL)
            download?.completionHandler?(destinationURL, nil)
        } catch {
            download?.completionHandler?(nil, error)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.originalRequest?.url,
              let download = activeDownloads[url] else { return }
        
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        download.progressHandler?(download.progress)
    }
}

class Download {
    var url: URL
    var task: URLSessionDownloadTask?
    var progress: Float = 0.0
    var completionHandler: ((URL?, Error?) -> Void)?
    var progressHandler: ((Float) -> Void)?
    
    init(url: URL, progressHandler: @escaping (Float) -> Void, completionHandler: @escaping (URL?, Error?) -> Void) {
        self.url = url
        self.progressHandler = progressHandler
        self.completionHandler = completionHandler
    }
}
