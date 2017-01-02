//
//  AppDelegate.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/2.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 设置 tabBar的原始颜色不被渲染
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}

