//
//  UIBarButtonItem + extension.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/2.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 先抽取一个类方法
    class func creatItems(_ imageName : String,highImageName : String,size : CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for:.normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        let barButtonItem = UIBarButtonItem(customView: btn)

        return barButtonItem
    }
    // 但是在 swift 中一般用到的是 构造函数比较多
    // 所以创建一个构造函数
    // 在类扩展里边创建构造函数需要满足: 1>convenience 便利构造函数
    // 2> 在构造函数中必须明确的调用一个设计的构造函数(self)
    convenience init(imageName : String,highImageName : String = "",size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for:.normal)
        if highImageName != "" {
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size != CGSize.zero {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        
        // 创建 UIBarButtonItem
        self.init(customView : btn)
    }
}
