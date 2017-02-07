//
//  BaseViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

enum ErrorNetType:Int {
    case None //没有错误 --- 移除loadingView
    case Default  //默认错误
    case NoNet  //  无网络
    case ServerError// 服务器错误
}

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {

    var errorView:ErrorView = Bundle.main.loadNibNamed("ErrorView", owner: nil, options: nil)?.first as! ErrorView

    let loadingView : LoadingView = LoadingView()

    var timer:Timer?
    
    var errorType:ErrorNetType =  .Default {
        didSet{
            self.destoryTimer()
            errorView.isHidden = false
            loadingView.isHidden = true
            switch errorType {
            case .None:
                loadingView.removeFromSuperview()
                errorView.removeFromSuperview()
            case .Default:
                errorView.msgLabel.text = "网络错误"
                errorView.msgDetailLabel.text = "请检查网络连接"
            case .NoNet:
                errorView.msgLabel.text = "网络错误"
                errorView.msgDetailLabel.text = "请检查网络连接"
            case .ServerError:
                errorView.msgLabel.text = "出现错误"
                errorView.msgDetailLabel.text = "服务器出错，请稍后重试"
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.bringSubview(toFront: navBarView);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        //启用滑动返回手势
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        request()


        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        automaticallyAdjustsScrollViewInsets = false
        navigationController?.isNavigationBarHidden = true

        navBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        navBarView.leftButton.addTarget(self, action: #selector(BaseViewController.leftBtnClick), for: .touchUpInside)
        navBarView.rightButton.addTarget(self, action: #selector(BaseViewController.rightBtnClick), for: .touchUpInside)
        view.addSubview(navBarView)
        
        addLoadingView()
    }
    
    func request(){
        
    }

    // MARK:-- 加载loadingView
    func addLoadingView()  {
        view.addSubview(errorView)
        errorView.frame = view.frame;
        errorView.retryBtn.addTarget(self, action: #selector(BaseViewController.retryBtnClick), for: .touchUpInside)
        
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        
        addTimer()
    }
    
    func retryBtnClick() {
        self.addTimer()
        
        errorView.isHidden = true
        loadingView.isHidden = false
        
        request()
    }
    
    func timerAction() {
        loadingView.progress = loadingView.progress + 1
    }
    
    func addTimer() {
        if timer == nil {
            timer = Timer(timeInterval: 0.15, target: self, selector: #selector(BaseViewController.timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }
    
    func destoryTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    deinit {
        destoryTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: --- 启用手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }


    //MARK: -- NavBar

    var navBarView:BaseNaviBar = BaseNaviBar()

    var leftImg:String? {
        didSet {
            self.navBarView.leftButton.contentHorizontalAlignment = .left
            self.navBarView.leftButton.setImage(UIImage(named: leftImg ?? ""), for: .normal)
            self.navBarView.leftButton.setTitle(nil, for: .normal)
            self.navBarView.leftButton.setImage(UIImage(named: leftImg ?? "")?.imageWithTintColor(color: UIColor.lightGray), for: .highlighted)
        }
    }

    var leftTitle:String? {
        didSet {
            self.navBarView.leftButton.contentHorizontalAlignment = .center
            self.navBarView.leftButton.setTitle(leftTitle, for: .normal)
            self.navBarView.leftButton.setImage(nil, for: .normal)
            self.navBarView.leftButton.setImage(nil, for: .highlighted)
        }
    }

    var rightImg:String? {
        didSet {
            //            self.navBarView.rightButton.contentHorizontalAlignment = .left
            self.navBarView.rightButton.isHidden = false
            self.navBarView.rightButton.setImage(UIImage(named: rightImg ?? ""), for: .normal)
            self.navBarView.rightButton.setTitle(nil, for: .normal)
            self.navBarView.rightButton.setImage(UIImage(named: rightImg ?? "")?.imageWithTintColor(color: UIColor.lightGray), for: .highlighted)

        }
    }

    var rightTitle:String? {
        didSet {
            self.navBarView.rightButton.isHidden = false
            self.navBarView.rightButton.setTitle(rightTitle, for: .normal)
            self.navBarView.rightButton.setImage(nil, for: .normal)
            self.navBarView.rightButton.setImage(nil, for: .highlighted)
        }
    }

    var navTitleStr:String? {
        didSet {
            self.navBarView.navTitle.text = navTitleStr
        }
    }

    //MARK: -- 控制转屏

    func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
        //        navigationController?.popViewController(animated: true)
        print("---leftBtnClick---")
    }

    func rightBtnClick() {
        print("---leftBtnClick---")
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    
    
}
