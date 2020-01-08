//
//  AppDelegate.swift
//  StrikeIt
//
//  Created by Maha Habib on 22/12/2019.
//  Copyright © 2019 Maha Habib. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing New Realm\(error)")
        }
     
        return true
    }

    
 


}

