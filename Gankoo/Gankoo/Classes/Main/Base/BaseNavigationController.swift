//
//  BaseNavigationController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 隐藏导航栏
        isNavigationBarHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return (topViewController?.supportedInterfaceOrientations)!
    }


    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (topViewController?.preferredInterfaceOrientationForPresentation)!
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if interactivePopGestureRecognizer != nil {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }

        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
