//
//  InitialViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/29/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var thanklabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    
    var filemanager = FileManager.default
    
    lazy var session : URLSession = {[unowned self]  in
        
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
    }()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.startAnimating()
        self.button.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.runcode()
        }
      }
    
    func runcode(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let urlrequest = URLRequest(url: self.appDelegate.remoteURLCurrent!)
            let downloadtask = self.session.downloadTask(with: urlrequest)
            downloadtask.resume()
            let urlrequest2 = URLRequest(url: self.appDelegate.remoteURLNext!)
            let downloadtask2 = self.session.downloadTask(with: urlrequest2)
            downloadtask2.resume()
            
        }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
        performUIUpdatesOnMain {
                self.spinner.isHidden = true
                self.label.text = "welcome"
                self.progress.isHidden = true
                self.label.font = self.label.font.withSize(25)
                self.label.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                UIView.animate(withDuration: 2.0, delay: 0, options: .allowAnimatedContent, animations:{() -> Void in
                    self.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    print("animating")
                    
                } , completion: { complated in
                    self.dismiss(animated: true, completion: nil)
                })
            }
    }
    
            /*
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
            let task = session.downloadTask(with: urlrequest){(url,response,error) in
                if error == nil{
                    print("file downloaded")
                    
                    do{
                        
                        if self.filemanager.fileExists(atPath: self.delegate.fileURL.path){
                            try FileManager.default.removeItem(at: self.delegate.fileURL)
                            print("file removed")
                            
                        }
                    }
                    catch{
                        print("file can't be deleted")
                    }
                    do{
                        
                        try FileManager.default.moveItem(at: url!, to: self.delegate.fileURL)
                        print("file moved")
                        UserDefaults.standard.set(true, forKey: "visited")
                        
                        performUIUpdatesOnMain {
                            self.label.text = "welcome"
                            self.spinner.isHidden = true
                            self.thanklabel.isHidden = true
                            self.label.font = self.label.font.withSize(25)
                            self.label.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
                            //self.view.layoutIfNeeded()
                            UIView.animate(withDuration: 2.0, delay: 0, options: .allowAnimatedContent, animations:{() -> Void in
                                self.label.transform = CGAffineTransform(scaleX: 1.5, y: 1.3)
                                print("animating")
                                
                            } , completion: { complated in
                                self.dismiss(animated: true, completion: nil)
                            })
                            
                        }
                        
                        
                    }
                    catch{
                        print("App delegate error")
                        
                        performUIUpdatesOnMain {
                            self.spinner.isHidden = true
                            self.label.text = "Sorry, something went wrong. Please try after sometime"
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                else{
                    
                    performUIUpdatesOnMain {
                        
                        self.spinner.isHidden = true
                        self.label.text = "Sorry, something went wrong. Please make sure you have an active internet connection"
                        self.button.isHidden = false
                        
                    }
                    
                    print("no data")
                }
                
            }
            
            task.resume()
            
        }*/
        
    
    
    @IBAction func execute(){
        
        self.spinner.startAnimating()
        self.label.text = "Please wait"
        self.thanklabel.isHidden = true
        self.button.isHidden = true
        self.progress.isHidden = false
        self.runcode()
        
    }

}

extension InitialViewController : URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let remoteURl = downloadTask.originalRequest?.url
        let lastPathComponent = remoteURl?.lastPathComponent
        
        do{
            if self.filemanager.fileExists(atPath: self.appDelegate.fileURL.appendingPathComponent(lastPathComponent!).path){
                try FileManager.default.removeItem(at: self.appDelegate.fileURL.appendingPathComponent(lastPathComponent!))
                print("file removed")
            }
        }
        catch{
            print("file can't be deleted")
        }
        do{
            try FileManager.default.moveItem(at: location, to: self.appDelegate.fileURL.appendingPathComponent(lastPathComponent!))
            print("file moved")
            UserDefaults.standard.set(true, forKey: "visited")
            
            performUIUpdatesOnMain {
                self.label.text = "Almost done! Please hang on."
                //self.spinner.isHidden = true
                self.thanklabel.isHidden = true
                self.progress.progress = 0
                //self.progress.isHidden = true
                
                
            }
        }
        catch{
            print("File cannot be moved")
            
            performUIUpdatesOnMain {
                self.spinner.isHidden = true
                self.label.text = "Sorry, something went wrong. Please try after sometime"
            }
        }
        session.finishTasksAndInvalidate()
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
                
                self.spinner.isHidden = true
                self.thanklabel.isHidden = true
                self.label.text = "Sorry, something went wrong. Please make sure you have an active internet connection"
                self.button.isHidden = false
                self.progress.isHidden = true
            }
            
            
        }
    }
    
}
