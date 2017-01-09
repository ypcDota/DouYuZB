//
//  PageTitleView.swift
//  斗鱼直播
//
//  Created by ypc on 17/1/2.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit
// MARK : 定义一个协议
protocol pageTitleViewDelegate : class{
    func pageTitleView(_ titleView : PageTitleView,selectIndex index : Int)
    
}
//MARK: - 定义常量
let kBottomViewH : CGFloat = 0.5
let kScrollLineH : CGFloat = 2
let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
//MARK: - 定义 PageTitleView 类
class PageTitleView: UIView {

    // 定义属性保存 titles
    fileprivate var titles : [String]
    fileprivate var labelIndex : Int = 0
    // 代理属性
    weak var delegate : pageTitleViewDelegate?
    // MARK: - 懒加载
    
    // 定义属性保存label
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView  = {
        let scrollView = UIScrollView()
        // 设置scrollView属性
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
  // 重写构造函数
     init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        // 设置 UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - 设置UI
extension PageTitleView {
    
    func setUpUI() {
        // 1,添加 scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加titles对应的label
        setUpTitleLabel()
        
        // 3.设置底线和滚动的view
        setUpBottomLineAndScrollLine()
    }
    
    func setUpTitleLabel() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat  = frame.height
        let labelY : CGFloat  = 0
        // 遍历 标题 数组创建 label
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            // 把label添加到 scrollview上
            scrollView.addSubview(label)
            // 把label添加到 数组 titleLabels中
            titleLabels.append(label)
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 给 label 添加手势
            label.isUserInteractionEnabled = true
            let gesture : UIGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(gesture)
            
        }

    }
    
    func setUpBottomLineAndScrollLine() {
        
        // 1.设置底线
        let bottomView = UIView()
        let bottomViewY : CGFloat = frame.size.height - kBottomViewH
        let bottomViewW : CGFloat = bounds.size.width
        bottomView.frame = CGRect(x: 0, y: bottomViewY, width: bottomViewW, height: kBottomViewH)
        bottomView.backgroundColor = UIColor.lightGray
        
        //把底线添加到view上
        addSubview(bottomView)
        
        // 2.添加滚动滑块
        // 取出第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.size.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}
// MARK: - 监听label的点击
extension PageTitleView {
    // 通过手势监听label的点击
   @objc fileprivate func titleLabelClick(_ labelGes : UIGestureRecognizer) {
    
    // 1. 获取当前点击的 label
    guard let currentLabel = labelGes.view as? UILabel else {return}
    // 2. 如果重复点击一个 label ,直接 return
    if currentLabel.tag == labelIndex {return}
    
    currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    
    
    // 3. 获取旧的 label
     let oldLabel = titleLabels[labelIndex]
    oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
    
    //  4. 保存当前label的index
    labelIndex = currentLabel.tag
    
    //  5. 改变滑块的位置
    let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
    UIView.animate(withDuration: 0.15, animations: {
        self.scrollLine.frame.origin.x = scrollLineX
    })
    
    // 6.通知代理
    delegate?.pageTitleView(self, selectIndex: labelIndex)
    }
}

extension PageTitleView {

    
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    
    func setUpTitleLabel(_ progress : CGFloat,sourceIndex : Int,targetIndex: Int){
        // 在这里可以拿到 progress sourceIndex sourceIndex
        // 1.取出 sourceLabel 和 targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.修改滑块的逻辑
        // 2.1计算出滑块的一次最大滑动范围
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        // 2.2 计算出滑块滑动速率
        let movex = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + movex
    
        // 3.处理label的文字颜色的渐变
        // 3.1 处理颜色渐变的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        // 3.2改变sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        // 3.3改变 targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 保存最新的index
        labelIndex = targetIndex
    }
}
/*
    分析:
 要实现pageTitleView,因为要在很多其他的地方用到这个 view,所以在 main中自定义一个 pageTitleView,
 实现构造方法,传进来 view的frame 和 上面的标题数组
 因为有的view需要实现滚动,所以往 pageTitleView上添加一个 scrollView ,再在上面添加 label,然后监听label的手势实现响应方法
 
 */
