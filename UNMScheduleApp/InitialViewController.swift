//
//  InitialViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/29/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import Foundation




class InitialViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var thanklabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    var filesDownloaded : Int = 0
    
    @IBOutlet weak var progress: UIProgressView!
    
    var filemanager = FileManager.default
    
    lazy var session : URLSession = {[unowned self]  in
        
        let config = URLSessionConfiguration.default
        //config.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
    }()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.startAnimating()
        self.progress.isHidden = true
        self.button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.runcode()
        }
      }
    
    func runcode(){
            let urlrequest = URLRequest(url: self.appDelegate.remoteURLCurrent!)
            let downloadtask = self.session.downloadTask(with: urlrequest)
            downloadtask.resume()
            
            let urlrequest2 = URLRequest(url: self.appDelegate.remoteURLNext!)
            let downloadtask2 = self.session.downloadTask(with: urlrequest2)
            downloadtask2.resume()
        
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
        if error == nil{
            performUIUpdatesOnMain {
                UserDefaults.standard.set(true, forKey: "visited")
                self.spinner.isHidden = true
                self.thanklabel.isHidden = true
                self.label.text = "welcome"
                self.progress.isHidden = true
                self.label.font = self.label.font.withSize(25)
                
                self.label.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                UIView.animate(withDuration: 2.0, delay: 0, options: .allowAnimatedContent, animations:{() -> Void in
                    self.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    print("animating")
                    
                } , completion: { complated in
                    UserDefaults.standard.set(Date(), forKey: "lastUpdateOn")
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        else{
            print("error")
            
        }
        
        
    }
    
    
    @IBAction func execute(){
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        self.label.text = "Please wait"
        self.thanklabel.isHidden = true
        self.button.isHidden = true
        //self.progress.isHidden = false
        self.runcode()
        
    }

}

extension InitialViewController : URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        filesDownloaded += 1
        //DispatchQueue.global(qos: .userInitiated).async {
        print("downloaded")
        let parser = XMLParserClass(url: location)
        parser.startParsing()
        if let semester = parser.semester{
            if downloadTask.originalRequest?.url?.lastPathComponent == "current.xml"{
                NSKeyedArchiver.archiveRootObject(semester, toFile: self.appDelegate.fileURL.appendingPathComponent("current").path)
                
            }
            else{
                NSKeyedArchiver.archiveRootObject(semester, toFile: self.appDelegate.fileURL.appendingPathComponent("next").path)
                
               
            }
            performUIUpdatesOnMain {
                self.label.text = "Almost done, please hang on"
                self.thanklabel.isHidden = true
            }
            
            if filesDownloaded >= 2{
                session.finishTasksAndInvalidate()
            }
        }
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        performUIUpdatesOnMain {
            self.progress.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        }
        
    }
    

}


extension InitialViewController : URLSessionTaskDelegate{
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil{
            
            performUIUpdatesOnMain {
                task.cancel()
                self.spinner.isHidden = true
                self.thanklabel.isHidden = true
                self.label.text = "Sorry, something went wrong. Please make sure you have an active internet connection"
                self.button.isHidden = false
                self.progress.isHidden = true
            }
            
            
        }
    }
    
}
