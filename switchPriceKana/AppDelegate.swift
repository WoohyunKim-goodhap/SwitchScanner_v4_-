//
//  AppDelegate.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/12.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//
/// e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.Woohyun-kim.switchPriceKana.refresh"]
/// e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.Woohyun-kim.switchPriceKana.processing"]

import UIKit
import CoreData
import Firebase
import GoogleMobileAds
import BackgroundTasks
import NotificationCenter



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let processingID = "com.Woohyun-kim.switchPriceKana.processing"
    let refreshingID = "com.Woohyun-kim.switchPriceKana.refresh"
    
    let svc = SwitchViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        //bgtask
        registerLocalNotification()
        UserDefaults.standard.setValue("???", forKey: "title")
        UserDefaults.standard.setValue("none", forKey: "price")
        
        BGTaskScheduler.shared.cancelAllTaskRequests()
        BGTaskScheduler.shared.register(forTaskWithIdentifier: processingID, using: nil) { (task) in
            print("background task triggered")
            self.handleBGProcessingTask(task as! BGProcessingTask)
        }

        BGTaskScheduler.shared.register(forTaskWithIdentifier: refreshingID, using: nil) { (task) in
            print("background task triggered")
            self.handleBGAppRefreshTask(task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    func handleBGProcessingTask(_ task: BGProcessingTask) {
        task.expirationHandler = {
            // TODO
        }
        UserDefaults.standard.setValue("\(priceForAlarm)", forKey: "title")
        UserDefaults.standard.setValue("\(titleForAlarm)", forKey: "price")

        print("backgroundProcessing called")
        
        scheduleLocalNotification(price: "\(priceForAlarm)", title: "\(titleForAlarm)")
        
        task.setTaskCompleted(success: true)
    }
    
    func handleBGAppRefreshTask(_ task: BGAppRefreshTask) {
        task.expirationHandler = {
            // TODO
        }
        UserDefaults.standard.setValue("\(priceForAlarm)", forKey: "title")
        UserDefaults.standard.setValue("\(titleForAlarm)", forKey: "price")
        
        print("backgroundRefresh called")
        
        scheduleLocalNotification(price: "\(priceForAlarm)", title: "\(titleForAlarm)")

        task.setTaskCompleted(success: true)
    }
    
    /// e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.Woohyun-kim.switchPriceKana.processing"]


    func startBGProcessingTask() {
        print("BackgroundProcessing called")
        let request = BGProcessingTaskRequest(identifier: processingID)
        request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = false
        
         request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60)
        // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            if alarmSwitchStatusIson {
                try BGTaskScheduler.shared.submit(request)
                print("startBGProcessingTask submitted request")
            }
        } catch {
            print("Could not schedule image fetch: \(error)")
        }
    }
    
    /// e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.Woohyun-kim.switchPriceKana.refresh"]
    
    func startBGAppRefreshTask() {
        print("BackgroundRefresh called")

        let appRefreshTaskReq = BGAppRefreshTaskRequest(identifier: refreshingID)
        appRefreshTaskReq.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
            if alarmSwitchStatusIson {
                try BGTaskScheduler.shared.submit(appRefreshTaskReq)
                print("submitted request")
            }
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    //notification
    func scheduleLocalNotification(price: String, title: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.fireNotification(price: price, title: title)
            }
        }
    }
    
    func fireNotification(price: String, title: String) {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "\(title)"
        notificationContent.body = "\(price)"
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
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
        let container = NSPersistentContainer(name: "switchPriceKana")
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

