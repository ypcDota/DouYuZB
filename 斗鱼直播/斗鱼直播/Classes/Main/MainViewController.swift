//
//  MainViewController.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/2.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加自控制器
        // 通过 storyBoard 加载
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")

    }
    
    // 添加自控制器 抽取函数
    fileprivate func addChildVc(_ VcName : String) {
        
        let childVc = UIStoryboard(name: VcName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    
    }

}
