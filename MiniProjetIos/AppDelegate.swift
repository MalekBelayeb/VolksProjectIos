//
//  AppDelegate.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/7/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Parse
import FacebookCore
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    
    
    
    func sendPushNotifications(to:String,message:String) {
        let cloudParams : [AnyHashable:String] = ["username":to,"message":message]
     PFCloud.callFunction(inBackground: "pushsample", withParameters: cloudParams, block: {
               (result: Any?, error: Error?) -> Void in
               if error != nil {
                   if let descrip = error?.localizedDescription{
                       print(descrip)
                   }
               }else{
                   print(result as! String)
               }
           })
    }
    
    
    
    
 func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        createInstallationOnParse(deviceTokenData: deviceToken)
    }
    
    
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != [] {
            application.registerForRemoteNotifications()
        }
    }
    
   
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    func saveUserToServer(username:String)
    {
        
        if let installation = PFInstallation.current(){
            installation.setObject([username], forKey: "channels")
                    
            if let userId = PFUser.current()?.objectId {
                        installation.setObject(userId, forKey: "userId")
                    }
           
            installation.saveInBackground {
                (success: Bool, error: Error?) in
           
            }
        }
        
    }
    

    
    
    
    
 func createInstallationOnParse(deviceTokenData:Data){
  if let installation = PFInstallation.current(){
      installation.setDeviceTokenFrom(deviceTokenData)
   // installation.setObject(["News"], forKey: "channels")

      installation.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              print("You have successfully saved your push installation to Back4App!")
          } else {
              if let myError = error{
                  print("Error saving parse installation \(myError.localizedDescription)")
              }else{
                  print("Uknown error")
              }
          }
      }
  }
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        
                SessionUtils.getInstance().updateSession(username: SessionUtils.getInstance().getSession(isconnected: 1)[0].username!, isconnected: 0)
          }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "Rtp0ozfnB68SSrEGurJbb6qRy3X3XSJHlK2NHcEL"
            $0.clientKey = "FTKhHNk920m2gJCV2XuQb4Q9lI8pkrgikBUqctjE"
            $0.server = "https://parseapi.back4app.com"
        
        }
        
       Parse.initialize(with: configuration)
        
    
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay ]) {
                (granted, error) in
                    print("Permission granted: \(granted)")
                     guard granted else { return }
                     self.getNotificationSettings()
                
       /* if(granted)
              {
                  DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                  })
              }*/
              
            }
        
      
      //  UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    

    
   func getNotificationSettings() {
    
      UNUserNotificationCenter.current().getNotificationSettings { (settings) in
           print("Notification settings: \(settings)")
           guard settings.authorizationStatus == .authorized else { return }
           UIApplication.shared.registerForRemoteNotifications()
    }
    
   }

    
    


    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MiniProjetIos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    


}


