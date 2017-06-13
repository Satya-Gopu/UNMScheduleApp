//
//  AppDelegate.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var filemanager = FileManager.default
    let remoteURLCurrent = URL(string: "http://datastore.unm.edu/schedules/current.xml")
    let remoteURLNext = URL(string: "http://datastore.unm.edu/schedules/next1.xml" )
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var completionForBackGround : (() -> Void)?
        //.appendingPathComponent("current.xml")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("DIDLAUNCH")
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("ReSIGN ACTIVE")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("Didenterbackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("willenterforeground")
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("DIDbecome active")
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("will terminate")
    }
    
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        self.completionForBackGround = completionHandler
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let urlrequest = URLRequest(url: remoteURLNext!)
        let session = URLSession.shared
        let task = session.downloadTask(with: urlrequest){(url,response,error) in
            if error == nil{
                
                do{
                    print("file downloaded")
                    if self.filemanager.fileExists(atPath: self.fileURL.path){
                        try FileManager.default.removeItem(at: self.fileURL)
                        
                    }
                    print("file removed")
                    try FileManager.default.moveItem(at: url!, to: self.fileURL)
                    print("file moved")
                    
                }
                catch{
                    print("App delegate error")
                    
                }
                
                completionHandler(.newData)
            }
            else{
                completionHandler(.failed)
                print("no data")
            }
            
        }
        
        task.resume()
        
    }


}


