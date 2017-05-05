//
//  InitialViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/29/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var thanklabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    
    var filemanager = FileManager.default
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.startAnimating()
        self.button.isHidden = true
        self.progress.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.runcode()
        
        
    }
    
    func runcode(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let urlrequest = URLRequest(url: self.delegate.remoteURL!)
            let session = URLSession.shared
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
            
        }
        
    }
    
    @IBAction func execute(){
        
        self.spinner.startAnimating()
        self.label.text = "Please wait"
        self.thanklabel.isHidden = true
        self.button.isHidden = true
        self.runcode()
        
    }

}



