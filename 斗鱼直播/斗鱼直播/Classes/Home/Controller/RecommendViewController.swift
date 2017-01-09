//
//  RecommendViewController.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/3.
//  Copyright © 2017年 com.ypc. All rights reserved.
// 推荐界面控制器

import UIKit

//MARK: - 定义常量
private let kMargin : CGFloat = 10
private let kNormalW : CGFloat = (kScreenW - 3*kMargin) * 0.5
private let kNormalH : CGFloat = kNormalW * 3 / 4
private let kPrettyH : CGFloat = kNormalW * 4 / 3
private let kHeaderCellW = kScreenW

private let normalReUsedId = "normalReUsedId"
private let prettyReUsedId = "prettyReUsedId"
private let headerReusedId = "headerReusedId"
class RecommendViewController: UIViewController {

    // MARK: - 定义属性
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        // 1.创建流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalW, height: kNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kMargin
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 44, right: kMargin)
        // 设置 headerCell的尺寸
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        
        // 2.创建 ccollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //collectionView最底部显示不全,应该设置随着控制器自由伸缩
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        // 注册 cell
            // 注册 普通的 cell
                collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalReUsedId)
            // 注册 颜值 cell
                collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyReUsedId)
            // 注册 headerCell
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReusedId)
        

        return collectionView
    }()
    
    // MARK: - 控制器生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置UI
        setUpUI()
    }
}

extension RecommendViewController {
    // 设置UI
    fileprivate func setUpUI() {
        // 添加 colelctionView
        view.addSubview(collectionView)
    }
}
//MARK: - UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建 cell 通过这种方式创建的 cell 必须注册
        let cell : UICollectionViewCell
        if indexPath.section == 1 {
         cell = collectionView.dequeueReusableCell(withReuseIdentifier:prettyReUsedId , for: indexPath)
        } else {
         cell = collectionView.dequeueReusableCell(withReuseIdentifier:normalReUsedId , for: indexPath)
        }
        return cell
    }
    
    // 返回collectionView的 header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 创建 headerCell 必须注册
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReusedId, for: indexPath)
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size : CGSize
        if indexPath.section == 1 {
            size = CGSize(width: kNormalW, height: kPrettyH)
        } else {
            size = CGSize(width: kNormalW, height: kNormalH)
        }
        return size
    }
}
