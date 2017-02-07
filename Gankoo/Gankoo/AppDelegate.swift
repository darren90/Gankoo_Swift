//
//  AppDelegate.swift
//  Gankoo
//
//  Created by Fengtf on 2017/2/7.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        initThirdSevices()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func initThirdSevices(){
        initBugly()
        initUmengTrack()
        initUMsocial()
    }

    //MARK: -- Bugly
    func initBugly(){
        // Get the default config
        let config = BuglyConfig()
        #if DEBUG
            config.debugMode = true
        #endif
        config.reportLogLevel = BuglyLogLevel.warn

        config.channel = "Bugly"

        Bugly.start(withAppId: "900001055", config: config)

        Bugly.setTag(1799);

        Bugly.setUserIdentifier(UIDevice.current.name)

        Bugly.setUserValue(ProcessInfo.processInfo.processName, forKey: "Process")
    }

    //MARK: -- 友盟统计
    func initUmengTrack(){
        MobClick.setLogEnabled(true)
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = "5648bb2fe0f55a6ab8004696"
        config?.secret = ""
        MobClick.start(withConfigure: config)
    }

    //MARK: -- 友盟分享
    func initUMsocial() {
        let umMangerr = UMSocialManager.default()
        umMangerr!.openLog(true)
        umMangerr!.umSocialAppkey = ""

        //微信
        umMangerr!.setPlaform(.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")

        //qq
        umMangerr!.setPlaform(.QQ, appKey: "100424468", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")

        //新浪
        umMangerr!.setPlaform(.sina, appKey: "2949226810", appSecret: "ad08040031457a934608f9118a8577e4", redirectURL: "http://mobile.umeng.com/social")
    }



}

