//
//  BaseNaviBar.swift
//  01_ProjectBase
//
//  Created by Tengfei on 2016/12/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseNaviBar: UIView {
    // MARK:-- 左侧返回按钮
    lazy var leftButton:UIButton = UIButton(type: .custom)
    
    lazy var rightButton:UIButton = UIButton(type: .custom)
    
    lazy var navTitle:UILabel = UILabel()
    
    lazy var navBgImage:UIImageView = UIImageView()
    
    lazy var navTitleImage:UIImageView = UIImageView()
    
    lazy var lineView:UIView = UIView()
    
    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        super.init(frame: rect)

        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)

        addFunViews()
    }
    
    
    func addFunViews() {
        let width = UIScreen.main.bounds.width
        
        leftButton.frame = CGRect(x: 13, y: 24, width: 66, height: 40)
        leftButton.contentHorizontalAlignment = .left
        leftButton.setTitleColor(UIColor.black, for: .normal)
        leftButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton.setImage(UIImage(named: "nav_btn_back_h"), for: .normal)
        leftButton.setImage(UIImage(named: "nav_btn_back_h")?.imageWithTintColor(color: UIColor.lightGray), for: .highlighted)
//        leftButton.sizeToFit()
//        leftButton.backgroundColor = UIColor.brown
        addSubview(leftButton)
        
        rightButton.frame = CGRect(x: width - 65 - 10, y: 24, width: 65, height: 40)
        rightButton.contentHorizontalAlignment = .center
        rightButton.setTitleColor(UIColor.black, for: .normal)
        rightButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightButton.setImage(UIImage(named: "nav_btn_back_h"), for: .normal)
        rightButton.isHidden = true
//        rightButton.sizeToFit()
//        rightButton.backgroundColor = UIColor.blue
        addSubview(rightButton)
        
        navTitle.frame = CGRect(x: leftButton.frame.maxX, y: 24, width: width - 75 - 75, height: 40)
        navTitle.textColor = UIColor.black
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 18)
//        navTitle.sizeToFit()
//        navTitle.backgroundColor = UIColor.cyan
        addSubview(navTitle)
        
        navTitleImage.center = navTitle.center
        navTitleImage.bounds = CGRect(x: 0, y: 0, width: 83, height: 27)
        navTitleImage.contentMode = .scaleAspectFit
        addSubview(navTitleImage)
        
        lineView.frame = CGRect(x: 0, y: 64, width: width, height: 0.5)
        let colorNum:Float = 243 / 255.0
        lineView.backgroundColor = UIColor(colorLiteralRed: colorNum, green: colorNum, blue: colorNum, alpha: 0.8)
        addSubview(lineView)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
