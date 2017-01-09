//
//  HomeViewController.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/2.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    // MARK: - 懒加载属性
   fileprivate lazy var pageTitleView : PageTitleView = {
    
    let rect = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)

        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: rect, titles: titles)
        titleView.delegate = self
    
        return titleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        let contentX : CGFloat = 0
        let contentY : CGFloat = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentW : CGFloat = kScreenW
        let contentH : CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
       
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for i in 0...2 {
            let vc = UIViewController()
            childVcs.append(vc)
            vc.view.backgroundColor = UIColor.randomColor()
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentController: self)
        // 设置代理
        contentView.delegate = self
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        setUpUI()
    }
}

// MARK - 设置UI
extension HomeViewController {
    
    // 设置UI
    func setUpUI() {
        // 0.不需要调整 UIScrollView 的内边距
        automaticallyAdjustsScrollViewInsets = false
        
       // 1.设置导航栏
        setUpNav()
        
        // 添加pageTitleView
        view.addSubview(pageTitleView)
        
        // 添加 pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
    }
    
    // MARK:设置导航栏
    func setUpNav() {
        
        // 1.设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右边的 item
        let size = CGSize(width: 30, height: 30)        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }

}
// MARK: 遵守 pageTitleViewDelegate
extension HomeViewController : pageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
}
extension HomeViewController : pageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setUpTitleLabel(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        }
}
